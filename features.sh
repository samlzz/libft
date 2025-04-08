#!/bin/bash

# Global Constants
GNL_GIT="git@github.com:samlzz/get_next_line.git"
FT_PRINTF_GIT="git@github.com:samlzz/ft_printf.git"
CONTAINER_GIT="git@github.com:samlzz/libft_containers.git"

TMP_DIR="/tmp/.libft_features"

ESC='\033'
BD=1; IT=3; UD=4
BLACK=30; RED=31; GREEN=32; YELLOW=33; BLUE=34; MAGENTA=35; CYAN=36
RESET="${ESC}[0m"

BG() { echo $(( $1 + 10 )); }
BRIGHT() { echo $(( $1 + 60 )); }

# Utility: Print error and exit
handle_error() {
	local msg="$1"
	printf "$ESC[$BD;${RED}mError:$ESC[22m %s${RESET}\n" "$msg" >&2
	exit 1
}

# Utility: Git clone
clone_repo() {
	local url="$1" dest="$2" name="$3"
	printf "$ESC[0;${CYAN}mCloning %s...$ESC[$IT;${BLACK}m\n" "$name"
	git clone "$url" "$dest" || handle_error "Cloning $name failed"
}

# Utility: Header relocation
move_headers_to_include() {
	local src="$1"
	[[ ! -d include ]] && mkdir include
	find "$src" -maxdepth 1 -type f -name "*.h" -exec mv {} include/ \;
}

# Utility: Add .c files to Makefile
append_cfiles_to_makefile() {
	local dir="$1"
	for cfile in "$dir"/*.c; do
		[[ -f $cfile ]] && sed -i "/^C_FILES =/a \ \ \ \ $cfile \\\\" Makefile
	done
}

# Utility: Inject include to libft.h
inject_headers_to_libft_h() {
	local dir="$1"
	for hfile in "$dir"/*.h; do
		local base
		base=$(basename "$hfile")
		grep -qxF "# include \"$base\"" include/libft.h || \
			sed -i "/^# include \"libft_internal.h\"/a \# include \"$base\"" include/libft.h
	done
}

# Create libftp structure
setup_libftp_structure() {
	local newlib="libftp"
	mkdir -p "../$newlib/libft" || handle_error "Failed to create $newlib/libft"
	for item in *; do
		[[ "$item" != "$(basename "$0")" ]] && mv "$item" "../$newlib/libft/"
	done
	cd "../$newlib" || handle_error "Could not cd to $newlib"
}

# Add ft_printf
add_ftprintfs() {
	local tmp="/tmp/.libft_features/ft_printf"
	local src="ftprintf_src"

	setup_libftp_structure
	clone_repo "$FT_PRINTF_GIT" "$tmp" "ft_printf"
	mv "$tmp/src" "$src"
	mv "$tmp/Makefile" .
	rm -rf "$tmp"

	sed -i "s|^SRC_DIR *=.*|SRC_DIR = $src/|" Makefile
	sed -i "s|^OBJ_DIR *=.*|OBJ_DIR = ftprintf_obj/|" Makefile

	[[ -d libft/include ]] && mv libft/include . || move_headers_to_include libft
	sed -i "s|^INCL_DIR *=.*|INCL_DIR = ../include|" libft/Makefile
	move_headers_to_include "$src"
	sed -i "s|^INCL_DIR *=.*|INCL_DIR = include|" Makefile

	sed -i 's|^LIBFT *=.*|LIBFT = libftp|' ../Makefile 2>/dev/null || true
	sed -i 's|^LIB_FILES *=.*|LIB_FILES = ftp|' ../Makefile 2>/dev/null || true

	printf "$ESC[0;${GREEN}mFt_printf added successfully!$RESET\n"
	printf "$ESC[$BD;${MAGENTA}mLib renamed to libftp.$RESET\n"
}

# Add get_next_line
add_gnl() {
	local dir="get_next_line"
	clone_repo "$GNL_GIT" "$dir" "get_next_line"
	find "$dir" -type f ! -name "get_next_line*" -delete
	rm -rf "$dir/.git"
	inject_headers_to_libft_h "$dir"
	move_headers_to_include "$dir"
	append_cfiles_to_makefile "$dir"
	sed -i '/^INCL_DIR =/ s/$/ include/' Makefile
	printf "$ESC[0;${GREEN}mGNL added successfully!$RESET\n"
}

# Add containers
add_containers() {
	local tmp="/tmp/.libft_features/containers"
	local dst="containers"

	clone_repo "$CONTAINER_GIT" "$tmp" "libft_containers"
	rm -rf "$tmp/src/libft_utils"

	move_headers_to_include .
	inject_headers_to_libft_h "$tmp/include"
	move_headers_to_include "$tmp/include"

	mkdir -p "$dst"
	mv "$tmp/src"/* "$dst"
	rm -rf "$tmp"
	append_cfiles_to_makefile "$dst"
	sed -i '/^INCL_DIR =/ s/$/ include/' Makefile
	printf "$ESC[0;${GREEN}mContainers added successfully!$RESET\n"
}

MENU() {
	local options=("$@") len=${#options[@]}
	selected=0
	local indicator="$ESC[$BD;${YELLOW}m<"
	SELECTED_OPTIONS=()

	draw() {
		local hilight="$ESC[$UD;$(BRIGHT $CYAN)m"
		clear

		printf "${hilight}Welcome to the $ESC[${BD}mLibft$ESC[22m Config Script${RESET}\n"
		printf "$ESC[$IT;${BLACK}mArrow keys to navigate, space to select, enter to confirm/quit$RESET\n\n"

		for ((i = 0; i < len; i++)); do
			local mark="-"
			[[ " ${SELECTED_OPTIONS[*]} " =~ "$i " ]] && mark="$ESC[0;${BLUE}m~"
			if [[ $selected -eq $i ]]; then
				printf "$ESC[38;5;15m $mark %s <$RESET\n" "${options[$i]}"
			else
				printf " $mark %s\n$RESET" "${options[$i]}"
			fi
		done
	}

	draw
	stty -icanon -echo
	while IFS="" read -r -s -n 1 c; do
		case $c in
		"A")
			selected=$(((selected - 1 + len) % len))
			;;
		"B")
			selected=$(((selected + 1) % len))
			;;
		" ")
			#? if selected was already selected remove it, else add it
			if [[ " ${SELECTED_OPTIONS[*]} " =~ " $selected " ]]; then
				local new_list=()
				for idx in "${SELECTED_OPTIONS[@]}"; do
					[[ $idx -ne $selected ]] && new_list+=("$idx")
				done
				SELECTED_OPTIONS=("${new_list[@]}")
			else
				SELECTED_OPTIONS+=("$selected")
			fi
			;;
		"")
			break
			;;
		esac
		draw
	done
	stty sane
}


# Confirm choices
confirm_choices() {
	local opts=("$@") choice

	draw_rectangle() {
		local options=("$@")
		local width=0

		for selected in "${SELECTED_OPTIONS[@]}"; do
			[[ ${#options[selected]} -gt $width ]] && width=${#options[selected]}
		done
		width=$((width + 4))

		echo ""
		echo "┌$(printf '─%.0s' $(seq 1 $width))┐"
		for selected in "${SELECTED_OPTIONS[@]}"; do
			if [[ -n $selected ]]; then
				printf "│ %-*s │\n" $((width - 2)) "${options[selected]}"
			fi
		done
		echo "└$(printf '─%.0s' $(seq 1 $width))┘"
		echo ""
	}
	draw_rectangle "${opts[@]}"

	while true; do
		printf "\n$ESC[${YELLOW}mConfirm? (Y/n):$RESET "
		read -r choice
		choice=${choice:-y}
		case "$choice" in
			[Yy]*) return 0 ;;
			[Nn]*) printf "$ESC[${RED}mCanceled.$RESET\n"; return 1 ;;
			*) printf "$ESC[${MAGENTA}mPlease answer 'y' or 'n'.$RESET\n" ;;
		esac
	done
}

# Move to libft directory if needed
navigate_to_libft() {
	[[ $(basename "$PWD") == "libft" ]] && return
	local found
	found=$(find . -type d -name libft -print -quit)
	[[ -z "$found" ]] && handle_error "libft folder not found"
	cd "$found" || handle_error "Failed to cd into libft"
}

# Main
main() {
	command -v git >/dev/null || handle_error "git not installed"
	command -v sed >/dev/null || handle_error "sed not installed"
	mkdir -p $TMP_DIR

	local opts=("Add libft_containers" "Add ft_printf" "Add get_next_line")
	navigate_to_libft
	MENU "${opts[@]}"
	clear

	[[ ${#SELECTED_OPTIONS[@]} -eq 0 ]] && {
		printf "$ESC[${RED}mNo options selected. Exiting.$RESET\n"
		exit 0
	}
	confirm_choices "${opts[@]}" || exit 0

	local add_printf=false
	for idx in "${SELECTED_OPTIONS[@]}"; do
		case $idx in
			0) add_containers ;;
			1) add_printf=true ;;
			2) add_gnl ;;
		esac
	done
	$add_printf && add_ftprintfs

	printf "\n$ESC[$BD;${GREEN}mScript completed!$RESET\n"
	printf "$ESC[0;${MAGENTA}mRun 'norminette' to verify.$RESET\n"

	cd .. || handle_error "Could not return to parent dir"
	printf "$ESC[0;${RED}mDelete script? (Y/n):$RESET "
	read -r -p ' > ' confirm
	[[ ${confirm:-y} =~ ^[Yy]$ ]] && rm -- "$0"
	[[ -d libft && -z $(ls -A libft) ]] && rmdir libft
	rm -rf $TMP_DIR
}

main "$@"
