#!/bin/bash

#? Git repository adress
GNL_GIT="git@github.com:samlzz/get_next_line.git"
FT_PRINTF_GIT=""

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


function menu() {
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
				print_menu
				;;
			"B")
				SELECTED=$(( (SELECTED + 1) % len ))
				print_menu
				;;
			" ")
				#? if selected was already selected remove it, else add it
				if [[ " ${SELECTED_OPTIONS[*]} " =~ " $SELECTED " ]]; then
					SELECTED_OPTIONS=("${SELECTED_OPTIONS[@]/$SELECTED}")
				else 
					#? Check if it not last option (quit)
					if (( SELECTED == len - 1 )); then
						quit_selected=1
					else
						SELECTED_OPTIONS+=($SELECTED)
					fi
				fi
				print_menu
				;;
			"")
				break
				;;
		esac
	done

    echo "${SELECTED_OPTIONS[@]}"
}

function compile_bonuses() {
	sed -i "/^all:.*\$(NAME)/ s/$/ bonus/" Makefile
	echo -e "$ESC[0;${MAGENTA}mBonuses will be compiled automatically.${RESET}"
}

function handle_include_and_header() {
	local header_path="$1"
	local header_name="$2"

	if [ ! -d "include" ]; then
		echo -e "$ESC[0;$(BRIGHT $YELLOW)mCreating 'include' directory...${RESET}"
		mkdir include
		mv libft.h include/
	fi

	mv "$header_path" include/
	sed -i "/# include <stddef.h>/ a # include \"${header_name}\"" include/libft.h
	sed -i "/^INCL_DIR/ a include" Makefile
	echo -e "$ESC[0;${GREEN}m$header_name successfully added to libft.h.${RESET}"
}

function add_ft_printf() {
	echo -e "${CYAN}Cloning ft_printf...${GREY}"
	git clone ${FT_PRINTF_GIT}
	cd ft_printf || exit
	echo -e "${YELLOW}Cleaning repository...${RESET}"
	rm -rf .git Makefile .gitignore
	mv src/* ./
	rm -rf src
	cd ..
	handle_include_and_header "ft_printf/ft_printf.h" "ft_printf.h"
	find ft_printf -name '*.c' -exec basename {} \; | while read -r file; do
		sed -i "/^C_FILES/ a ft_printf/$file \\" Makefile
	done
	echo -e "${GREEN}ft_printf added successfully.${RESET}"
}

function add_gnl() {
	echo -e "${CYAN}Cloning get_next_line...${GREY}"
	git clone ${GNL_GIT}
	cd get_next_line || exit
	echo -e "${YELLOW}Cleaning repository...${RESET}"
	find . -type f ! -name "get_next_line.c" ! -name "get_next_line_utils.c" ! -name "get_next_line.h" -delete
	cd ..
	handle_include_and_header "get_next_line/get_next_line.h" "get_next_line.h"
	sed -i "/^C_FILES/ a get_next_line/get_next_line.c \\" Makefile
	sed -i "/^C_FILES/ a get_next_line/get_next_line_utils.c \\" Makefile
	echo -e "${GREEN}get_next_line added successfully.${RESET}"
}

function navigate_to_libft() {
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

#* Main
navigate_to_libft
clear

options=("Automatically compile bonuses" "Add ft_printf" "Add get_next_line" "Quit")
menu "${options[@]}"
clear
#for select_i in "${SELECTED_OPTIONS[@]}"; do
#	case $SELECTION in
#		0)
#			compile_bonuses
#			;;
#		1)
#			add_ft_printf
#			;;
#		2)
#			add_gnl
#			;;
#	esac
#done

for i in "${SELECTED_OPTIONS[@]}"; do
    echo "- $i"
done

echo -e "$ESC[$BD;${CYAN}mScript completed !${RESET}"
echo -e "$ESC[0;${MAGENTA}mPlease run '$ESC[${BD}mnorminette$ESC[22m' to verify compliance.${RESET}"
echo -e "$ESC[0;${RED}mThis script will now delete itself.${RESET}"
#rm -- "$0"
