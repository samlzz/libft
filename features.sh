#!/bin/bash

# Git repository adress
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

MENU() {
	local indicator="$ESC[$BD;${YELLOW}m<"
	options=("$@")
	local len=${#options[@]}
	local quit_selected=0
	SELECTED=0
	SELECTED_OPTIONS=()

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
	stty -icanon -echo
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
	stty sane

    echo "${SELECTED_OPTIONS[@]}"
}

handle_error() {
    local message="$1"

    echo -e "$RESET$ESC[$BD;91mError:$ESC[22m ${message}${RESET}" >&2
    exit 1
}

handle_git_clone()
{
	local repo="$1"
	local path="$2"
	local name="$3"

	echo -e "$ESC[0;${CYAN}mCloning $name...$ESC[$IT;${BLACK}m"
	git clone $repo $path || handle_error "Failed to clone $name repository."
	echo -e "$ESC[0;${YELLOW}mCleaning repository...${RESET}"
}

delete_if_empty() {
    local dir="$1"

    if [ -d "$dir" ] && [ -z "$(ls -A "$dir")" ]; then
        rmdir "$dir"
    fi
}

# function ()
# verifier si un dossier include existe dans libft (le dossier courant)
# si il n'existe ne pas
#		le creer et deplacer tout les fichiers .h dedans
# sinon ne rien faire
check_incldir()
{
	local dir="$1"

	if [[ -z "$dir" ]]; then
		dir="."
	fi
	if [ ! -d "include" ]; then
		mkdir "include" || handle_error "Failed to create include dir in $(pwd)"
	fi
	for file in $dir/*.h; do
		if [[ -f "$file" ]]; then
			mv "$file" "include/" || handle_error "Failed to move header file of $(pwd)/$dir"
		fi
	done
}


compile_bonuses() {
	sed -i "/^all:.*\$(NAME)/ s/$/ bonus/" Makefile || handle_error "Failed to update Makefile for auto-compil bonuses."
	echo -e "$ESC[0;${GREEN}mBonuses will be compiled automatically !${RESET}"
}

# renommer le dossier actuel (libft) en plibft
create_plibft()
{
	local new_libname="$1"

	echo -e "$ESC[$BD;${MAGENTA}mThe structure of libft folder is about to change.${RESET}"

	mkdir "../$new_libname" || handle_error "Failed to create $new_libname folder."
	mkdir "../$new_libname/libft" || handle_error "Failed to create $new_libname/libft folder."
	for item in *; do
		if [[ "$item" != "$(basename "$0")" ]]; then
			mv "$item" "../$new_libname/libft/" || handle_error "Failed to move $item to $new_libname/libft."
		fi
	done
	cd "../$new_libname"
}

# creer un dossier `libft` (dans plibft)
# deplacer toutes les fichiers du dossier courant dans le dossier lifbt (sauf lui meme et features.sh (ce script))
# cloner dans /tmp/.libft_features/ft_printf
# deplacer le dossier src et le fichier Makefile depuis le dossier du repos vers le dossier courant
# renommer le dossier src en ftprintfs_src
# modifier SRC_DIR et OBJ_DIR dans le Makefile
# deplacer le dossier libft/include dans le dossier courant
# modifier 'INCL_DIR = ' dans libft/Makefile, remplacer 'include' par ''../include'
# deplacer tout les .h dans le dossier include
# modifier 'INCL_DIR = $(LIBFT)' dans Makefile par 'INCL_DIR = include'
# afficher en magenta que le nom de la lib (.a et dossier) a changé en plibft
add_ftprintfs()
{	
	local tmp_dir="/tmp/.libft_features/ft_printf"
	local src="ftprintf_src"

	create_plibft libftp
	handle_git_clone "$FT_PRINTF_GIT" "$tmp_dir" "ft_printf"
	mv "$tmp_dir/src" "./$src" || handle_error "Failed to move printf srcs"
	mv "$tmp_dir/Makefile" ./ || handle_error "Failed to move printf Makefile"
	rm -rf "$tmp_dir" || handle_error "Failed to delete temp directory"

	#? Edit SRC and OBJ DIR name for ftprintf
	sed -i "s|^SRC_DIR *= *src/$|SRC_DIR = $src/|" Makefile || handle_error "Failed to update SRC_DIR"
	sed -i 's|^OBJ_DIR *= *build/$|OBJ_DIR = ftprintf_obj/|' Makefile || handle_error "Failed to update OBJ_DIR"

	#? Move .h files and update INCL_DIR (for both libft and printf)
	if [ -d "libft/include" ]; then
		mv libft/include ./ || handle_error "Failed to move libft/include"
		sed -i '/^INCL_DIR *= *include/ s|include| ../include|' libft/Makefile || handle_error "Failed to update INCL_DIR in libft/Makefile"
	else
		check_incldir libft
		sed -i '/^INCL_DIR *=/ s|$| ../include|' libft/Makefile || handle_error "Failed to update INCL_DIR in libft/Makefile"
	fi
	check_incldir "$src"
	sed -i '/^INCL_DIR *= *$(LIBFT)/ s|$(LIBFT)|include|' Makefile || handle_error "Failed to update INCL_DIR"

	#? Change lib name in Makefile of curr project
	local makefile="../Makefile"
	sed_and_warn()
	{
		local var="$1"
		local value="$2"
		local expected="${value}p"
		
		if ! sed -i "/^$var *=/ s|$value|$expected|" "$makefile"; then
			echo -e "$ESC[$BD;${YELLOW}mWarning$ESC[0;${YELLOW}m failed to update $ESC[$BD;${YELLOW}m${var}$ESC[0;${YELLOW}m to $ESC[$UD;${YELLOW}m${expected}$ESC[0;${YELLOW}m in the Makefile."
			echo -e "$ESC[0;${MAGENTA}mPlease update it manually.$RESET"
			return 1
		fi
		return 0
	}
	if sed_and_warn LIBFT libft; then
		sed_and_warn LIB_FILES ft
	fi

	echo -e "$ESC[0;${GREEN}mFt_printf added successfully !${RESET}"
	echo -e "$ESC[$BD;${MAGENTA}mThe name of libft folder and archive is now libftp.${RESET}"
}

# cloner dans get_next_line
# supprimer tout les fichiers, dans le dossier get_next_line 
#	sauf tout ceux dont le nom commence par get_next_line, (ex: get_next_line.c, get_next_line_utils.c, get_next_line.h)
#	meme les cachés genre `.git` et `.gitignore` 
# deplacer les fichiers .h (du dossier get_next_line) dans le dossier include
# ajouter tout les fichiers restant dans le dossier get_next_line dans le Makefile, a la variable 'C_FILES'
add_gnl()
{
	handle_git_clone "$GNL_GIT" "get_next_line" "get_next_line"

	find get_next_line -type f ! -name "get_next_line*" -delete || handle_error "Failed to clean repo"
	rm -rf get_next_line/.git
	check_incldir
	check_incldir get_next_line

	sed -i '/^INCL_DIR =/ s/$/ include/' Makefile || handle_error "Failed to update INCL_DIR in Makefile"
	for file in get_next_line/*c; do
		if [[ -f "$file" ]]; then
			sed -i "/^C_FILES =/a \ $(printf '\t\t\t')$file \\\\" Makefile || handle_error "Failed to update 'C_FILES' in Makefile."
		fi
	done

	sed -i '/^# include "libft_internal.h"/a \# include "get_next_line.h"' || handle_error "Failed to include gnl header"
	echo -e "$ESC[0;${GREEN}mGnl added successfully !${RESET}"
}

navigate_to_libft() {
	if [[ $(basename "$PWD") == "libft" ]]; then
		echo "Already in the libft directory."
		return
	fi

	LIBFT_PATH=$(find . -type d -name "libft" -print -quit)

	if [[ -n "$LIBFT_PATH" ]]; then
		cd "$LIBFT_PATH" || handle_error "Failed to navigate to $LIBFT_PATH."
	else
		handle_error "'libft' directory not found."
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

command -v git >/dev/null 2>&1 || handle_error "git is not installed."
command -v sed >/dev/null 2>&1 || handle_error "sed is not installed."

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
        add_ftprintfs
    fi
else
    echo -e "$ESC[0;${CYAN}mNo actions were performed.${RESET}"
	exit 0
fi

echo ""
echo -e "$ESC[$BD;${GREEN}mScript completed !${RESET}"
echo -e "$ESC[0;${MAGENTA}mPlease run '$ESC[${BD}mnorminette$ESC[22m' to verify compliance.${RESET}"

cd .. || handle_error "Failed to navigate back to parent directory."
echo -en "$ESC[0;${RED}mDelete the script itself? (Y/n):${RESET}"
read -r -p ' > ' confirm
confirm=${confirm:-y}
[[ $confirm =~ ^[Yy]$ ]] && rm -- "$0"
delete_if_empty libft
