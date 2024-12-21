#!/bin/bash

# ANSI Color Codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
RESET='\033[0m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

function MENU() {
    NC="\033[0m"
    INDICATOR="<"
    SELECTED=0
    OPTIONS=("$@")
    LENGTH=${#OPTIONS[@]}

	PRINT_MENU() {
		clear

		for (( i=0;i<(($LENGTH));i++ )); do
			if [[ $SELECTED -eq $i ]]; then
				echo -e "${OPTIONS[$i]} $YELLOW$INDICATOR$NC"
			else
				echo "${OPTIONS[$i]}"
			fi
		done
	}

	PRINT_MENU

	while read -rsn1 input; do
		case $input in
			"A")
				if [[ $SELECTED -lt 1 ]]; then
					SELECTED=$(($LENGTH-1))
				else
					SELECTED=$(($SELECTED-1))
				fi
				PRINT_MENU
				;;
			"B")
				if [[ $SELECTED -gt $(($LENGTH-2)) ]]; then
					SELECTED=0
				else
					SELECTED=$(($SELECTED+1))
				fi
				PRINT_MENU
				;;
			"") return $(($SELECTED+1)) ;;
		esac
	done
}

function display_menu() {
	selected=()
	OPTIONS=("Automatically compile bonuses" "Add ft_printf" "Add get_next_line" "Quit")

	MENU "${OPTIONS[@]}"

	SELECTION=$?
	case $SELECTION in
	1)
		selected+=("bonus")
		echo -e "${GREEN}Bonuses will be compiled automatically.${RESET}"
		break
		;;
	2)
		selected+=("ft_printf")
		echo -e "${GREEN}ft_printf will be added.${RESET}"
		break
		;;
	3)
		selected+=("get_next_line")
		echo -e "${GREEN}get_next_line will be added.${RESET}"
		break
		;;
	4)
		echo -e "${RED}Exiting menu.${RESET}"
		clear
		return
		;;
	*)
		echo -e "${RED}Invalid option $REPLY${RESET}"
		;;
	esac
	clear
}	

# Function to update Makefile for bonuses
function compile_bonuses() {
    sed -i "/^all:.*\$(NAME)/ s/$/ bonus/" Makefile
    echo -e "${MAGENTA}Makefile updated to compile bonuses automatically.${RESET}"
}

function handle_include_and_header() {
    local header_path="$1"
    local header_name="$2"

    if [ ! -d "include" ]; then
        echo -e "${YELLOW}Creating 'include' directory...${RESET}"
        mkdir include
        mv libft.h include/
        echo -e "${GREEN}'include' directory created and libft.h moved.${RESET}"
    fi

    mv "$header_path" include/
    sed -i "/# include <stddef.h>/ a # include \"${header_name}\"" include/libft.h
    sed -i "/^INCL_DIR/ a include" Makefile
    echo -e "${GREEN}${header_name} successfully added to libft.h.${RESET}"
}

function add_ft_printf() {
    echo -e "${CYAN}Cloning ft_printf...${RESET}"
    git clone https://github.com/user/ft_printf.git
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

# Function to add get_next_line
function add_gnl() {
    echo -e "${CYAN}Cloning get_next_line...${RESET}"
    git clone https://github.com/user/get_next_line.git
    cd get_next_line || exit
    echo -e "${YELLOW}Cleaning repository...${RESET}"
	find . -type f ! -name "get_next_line.c" ! -name "get_next_line_utils.c" ! -name "get_next_line.h" -delete
    cd ..
    handle_include_and_header "get_next_line/get_next_line.h" "get_next_line.h"
	sed -i "/^C_FILES/ a get_next_line/get_next_line.c \\" Makefile
	sed -i "/^C_FILES/ a get_next_line/get_next_line_utils.c \\" Makefile
    echo -e "${GREEN}get_next_line added successfully.${RESET}"
}

# Main script logic
clear
echo -e "${BOLD}${UNDERLINE}Welcome to the Libft Configuration Script${RESET}"
selected=()
display_menu

for option in "${selected[@]}"; do
    case $option in
        "bonus")
            compile_bonuses
            ;;
        "ft_printf")
            add_ft_printf
            ;;
        "get_next_line")
            add_gnl
            ;;
    esac
done

# Final steps
echo -e "${CYAN}Script completed.${RESET}"
echo -e "${MAGENTA}Please run '${BOLD}norminette${RESET}${MAGENTA}' to verify compliance.${RESET}"
echo -e "${RED}This script will now delete itself.${RESET}"
#rm -- "$0"
