#!/bin/bash

# ANSI Color Codes
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
RESET='\033[0m'
BOLD='\033[1m'
UNDERLINE='\033[4m'

# Function to display a colored menu and handle user input
function display_menu() {
    echo -e "${CYAN}What would you like to add to libft?${RESET}"
    echo -e "${YELLOW}Use arrow keys to navigate and space to select:${RESET}"
    options=("Automatically compile bonuses" "Add ft_printf" "Add get_next_line" "Quit")
    selected=()
    PS3="Please select an option: "

    while true; do
        echo ""
        select opt in "${options[@]}"; do
            case $opt in
                "Automatically compile bonuses")
                    selected+=("bonus")
                    echo -e "${GREEN}Bonuses will be compiled automatically.${RESET}"
                    break
                    ;;
                "Add ft_printf")
                    selected+=("ft_printf")
                    echo -e "${GREEN}ft_printf will be added.${RESET}"
                    break
                    ;;
                "Add get_next_line")
                    selected+=("get_next_line")
                    echo -e "${GREEN}get_next_line will be added.${RESET}"
                    break
                    ;;
                "Quit")
                    echo -e "${RED}Exiting menu.${RESET}"
                    return
                    ;;
                *)
                    echo -e "${RED}Invalid option $REPLY${RESET}"
                    ;;
            esac
        done
    done
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
    rm -rf !(get_next_line.c|get_next_line_utils.c|get_next_line.h)
    cd ..
    handle_include_and_header "get_next_line/get_next_line.h" "get_next_line.h"
	sed -i "/^C_FILES/ a get_next_line/get_next_line.c \\" Makefile
	sed -i "/^C_FILES/ a get_next_line/get_next_line_utils.c \\" Makefile
    echo -e "${GREEN}get_next_line added successfully.${RESET}"
}

# Main script logic
clear
echo -e "${BOLD}${UNDERLINE}Welcome to the Libft Configuration Script${RESET}"
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
rm -- "$0"
