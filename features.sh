#!/bin/bash

#? Git repository adress
GNL_GIT="git@github.com:samlzz/get_next_line.git"
FT_PRINTF_GIT="git@github.com:samlzz/ft_printf.git"

#* ANSI color codes 
# format: '$ESC[<style>;<color>m

ESC='\033'
#? style
BD=1
IT=3
UD=4
RV=7

#? colors
BLACK=30
RED=31
GREEN=32
YELLOW=33
BLUE=34
MAGENTA=35
CYAN=36
WHITE=37

RESET="$ESC[0m"

BG()
{
	local input=$1
	echo $((input + 10))
}
BRIGHT()
{
	local input=$1
	echo $((input + 60))
}

#* Functions

handle_error() {
    local message="$1"

    echo -e "$RESET$ESC[$BD;91mError:$ESC[22m ${message}${RESET}" >&2
    exit 1
}

is_contains_others() {
    local selected="$1"
    local options=("${!2}")
    for option in "${options[@]}"; do
        if [[ "$option" -ne "$selected" ]]; then
            return 0
        fi
    done
    return 1
}

MENU() {
	local indicator="$ESC[$BD;${YELLOW}m<"
	options=("$@")
	local len=${#options[@]}
	local quit_selected=0
	SELECTED=0
	SELECTED_OPTIONS=()

	print_menu() {
		HILIGHT="$ESC[$UD;$(BRIGHT $CYAN)m"
		clear

		echo -e "${HILIGHT}Welcome to the $ESC[${BD}mLibft$ESC[22m Configuration Script${RESET}"
		echo -e "$ESC[$IT;${BLACK}mNavigate with arrow, press space to select and enter for submit${RESET}"
		echo ""

		for (( i=0; i<len; i++ )); do
			if [[ " ${SELECTED_OPTIONS[*]} " =~ " $i " ]]; then
				mark="$ESC[0;${BLUE}m~"
			else
				mark="-"
			fi

			if [[ $SELECTED -eq $i ]]; then
				echo -e "$ESC[38;5;15m $mark ${options[$i]} $indicator${RESET}"
			else
				echo -e "$mark ${options[$i]}$RESET"
			fi
		done
		if [[ quit_selected -eq 1 ]]; then
			echo -e "$ESC[$IT;${RED}mYou can't select multiple options if yout want to quit.${RESET}"
			quit_selected=0
		fi
	}

    print_menu

	while IFS="" read -r -s -n 1 c; do
		case $c in
			"A")
				SELECTED=$(( (SELECTED - 1 + len) % len ))
				;;
			"B")
				SELECTED=$(( (SELECTED + 1) % len ))
				;;
			" ")
				#? if selected was already selected remove it, else add it
				if [[ " ${SELECTED_OPTIONS[*]} " =~ " $SELECTED " ]]; then
					SELECTED_OPTIONS=("${SELECTED_OPTIONS[@]/$SELECTED}")
				else 
						SELECTED_OPTIONS+=($SELECTED)
				fi
				;;
			"")
				if (( SELECTED == len - 1 )); then
					if is_contains_others "$SELECTED" SELECTED_OPTIONS[@]; then
						quit_selected=1
					else
						break
					fi
				else
					break
				fi
				;;
		esac
		print_menu
	done

    echo "${SELECTED_OPTIONS[@]}"
}

function compile_bonuses() {
	sed -i "/^all:.*\$(NAME)/ s/$/ bonus/" Makefile || handle_error "Failed to update Makefile for auto-compil bonuses."
	echo -e "$ESC[0;${GREEN}mBonuses will be compiled automatically !${RESET}"
}

handle_include_and_header() {
	local header_path="$1"
	local header_name="$2"

	if [ ! -d "include" ]; then
		echo -e "$ESC[0;$(BRIGHT $YELLOW)mCreating 'include' directory...${RESET}"
		mkdir include || handle_error "Failed to create 'include' directory."
		mv libft.h include/ || handle_error "Failed to move 'libft.h' to 'include'."
		sed -i '/^INCL_DIR =/ s/$/ include/' Makefile || handle_error "Failed to update 'INCL_DIR' in Makefile."
	fi

	mv "$header_path" include/ || handle_error "Failed to move '$header_path'."
	sed -i "/# include <stddef.h>/ a # include \"${header_name}\"" include/libft.h || handle_error "Failed to update 'libft.h'."
	echo -e "$ESC[2;${GREEN}m'libft.h' was moved."
}

function add_ft_printf() {
	local lib_subfolder="libft"
	echo -e "$ESC[$BD;${MAGENTA}mThe structure of libft folder is about to change.${RESET}"
	echo -e "$ESC[0;${BLACK}mNothing will change for you.${RESET}"

	mkdir "$lib_subfolder"
	for item in *; do
		if [ "$item" != "$lib_subfolder" ] && [ "$item" != "features.sh" ]; then
			mv "$item" "$lib_subfolder"
		fi
	done
	echo -e "$ESC[0;${CYAN}mCloning ft_printf...$ESC[$IT;${BLACK}m"
	if [ -d ".git" ]; then
  		handle_error "A git repository already exists in the current directory."
	fi
	git clone ${FT_PRINTF_GIT} ./.temp || handle_error "Failed to clone ft_printf repository."
	
	echo -e "$ESC[0;${YELLOW}mCleaning repository...${RESET}"
	cd .temp || handle_error "Failed to navigate to cloned directory."
	rm -rf .git .gitignore
	if [ -d "libft" ]; then
		rm -r libft || handle_error "Failed to delete libft folder of printf"
	fi
	cd .. || handle_error "Failed to navigate back to parent directory."
	mv ./.temp/* ./ || handle_error "Failed to move printf source in current directory"
	rm -rf ./.temp || handle_error "Failed to delete '.temp' directory"
	mv ./src ./ftprintf_src || handle_error "Failed to rename printf 'src' directory"

	#? Edit SRC and OBJ DIR name for ftprintf
	sed -i 's|^SRC_DIR *= *src/$|SRC_DIR = ftprintf_src/|' Makefile
	sed -i 's|^OBJ_DIR *= *build/$|OBJ_DIR = ftprintf_obj/|' Makefile
	#? Edit archive name
	sed -i "s/^NAME *= *libftprintf.a$/NAME = libft.a/" Makefile
	#sed -i "s/^LIBFT = libft$/LIBFT = $lib_subfolder/" Makefile
	if [ -d "$lib_subfolder/include" ]; then
		mv "$lib_subfolder/include" ./
	else
		mkdir include
		mv "$lib_subfolder/libft.h" ./include
	fi
	mv ftprintf_src/ft_printf.h ./include
	sed -i '/^INCL_DIR = $(LIBFT)/ s|$(LIBFT)$|include|' Makefile
	sed -i '/^INCL_DIR =  include/ s|include|../include|' "$lib_subfolder/Makefile"

	echo -e "$ESC[0;${GREEN}mFt_printf added successfully !${RESET}"
}

function add_gnl() {

	echo -e "$ESC[0;${CYAN}mCloning get_next_line...$ESC[$IT;${BLACK}m"
	git clone ${GNL_GIT} || handle_error "Failed to clone get next line repository."
	cd get_next_line || handle_error "Failed to navigate to 'get_next_line' directory."
	echo -e "$ESC[0;${YELLOW}mCleaning repository...${RESET}"
	find . -type f ! -name "get_next_line.c" ! -name "get_next_line_utils.c" ! -name "get_next_line.h" -delete
	cd .. || handle_error "Failed to navigate back to parent directory."
	handle_include_and_header "get_next_line/get_next_line.h" "get_next_line.h"

	sed -i '/typedef struct s_mem/,/}.*;/d' include/libft.h || handle_error "Failed to delete t_mem in 'libft.h'."
	sed -i "/^C_FILES =/a \ $(printf '\t\t\t')get_next_line/get_next_line.c \\\\" Makefile || handle_error "Failed to update 'C_FILES' in Makefile."
	sed -i "/^C_FILES =/a \ $(printf '\t\t\t')get_next_line/get_next_line_utils.c \\\\" Makefile || handle_error "Failed to update 'C_FILES' in Makefile."
	echo -e "$ESC[0;${GREEN}mGet_next_line added successfully !${RESET}"
}

navigate_to_libft() {
	if [[ $(basename "$PWD") == "libft" ]]; then
		echo "Already in the libft directory."
		return
	fi

	LIBFT_PATH=$(find . -type d -name "libft" -print -quit)

	if [[ -n "$LIBFT_PATH" ]]; then
		cd "$LIBFT_PATH" || { echo -e "${RED}Error: Failed to navigate to $LIBFT_PATH."; exit 1; }
	else
		echo -e "${RED}Error: 'libft' directory not found."
		exit 1
	fi
}

display_and_confirm() {
	local options=("$@")

	print_rectangle()
	{
		local	elements=("$@")
		local	width=0

		#? Find the max width for rectangle
		for selected in "${elements[@]}"; do
			[[ ${#options[selected]} -gt $width ]] && width=${#options[selected]}
		done
		width=$((width + 4))

		echo ""
		echo "┌$(printf '─%.0s' $(seq 1 $width))┐"

		for selected in "${elements[@]}"; do
			if [[ -n $selected ]]; then
				printf "│ %-*s │\n" $((width - 2)) "${options[selected]}"
			fi
		done

		echo "└$(printf '─%.0s' $(seq 1 $width))┘"
		echo ""
	}
	print_rectangle "${SELECTED_OPTIONS[@]}"

	#? Ask confirmation
    while true; do
        echo -e "$ESC[${YELLOW}mConfirm your selection ? (Y/n):${RESET}"
        read -r -p ' > ' confirmation
		confirmation=${confirmation:-y}
        case $confirmation in
            [Yy]*) return 0 ;;
            [Nn]*) echo -e "$ESC[${RED}mOperation canceled.${RESET}"; return 1 ;;
            *) echo -e "$ESC[${MAGENTA}mPlease answer 'y' or 'n'.${RESET}" ;;
        esac
    done
}


#* Main script logic

options=("Automatically compile bonuses" "Add ft_printf" "Add get_next_line" "Quit")

navigate_to_libft
MENU "${options[@]}"
clear

if display_and_confirm "${options[@]}"; then
    has_add_ft_printf=false

    for i in "${SELECTED_OPTIONS[@]}"; do
        case $i in
            0) compile_bonuses ;;
            1) has_add_ft_printf=true ;;
            2) add_gnl ;;
        esac
    done
    if $has_add_ft_printf; then
        add_ft_printf
    fi

else
    echo -e "$ESC[0;${CYAN}mNo actions were performed.${RESET}"
	exit 0
fi

echo ""
echo -e "$ESC[$BD;${GREEN}mScript completed !${RESET}"
echo -e "$ESC[0;${MAGENTA}mPlease run '$ESC[${BD}mnorminette$ESC[22m' to verify compliance.${RESET}"
echo -e "$ESC[0;${RED}mThis script will now delete itself.${RESET}"
cd .. || handle_error "Failed to navigate back to parent directory."
rm -- "$0"
