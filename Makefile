# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: um4s <um4s@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/05 19:03:59 by sliziard          #+#    #+#              #
#    Updated: 2024/11/28 17:42:59 by um4s             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#* VARIABLES
NAME =		libft.a

#TODO: Folders name must end with '\'
SRC_DIR =
OBJ_DIR =
INCL_DIR = 

CC = cc
CFLAGS := -Wall -Wextra -Werror
RM = rm -f
MD = mkdir -p
AR = ar rcs

C_FILES =	ft_char.c		\
			ft_conversion.c	\
			ft_is.c 		\
			ft_mem.c 		\
			ft_output.c		\
			ft_split.c		\
			ft_str_alloc.c	\
			ft_str_iter.c	\
			ft_str.c		\
			ft_utils.c
			
BONUS_SRC =	ft_lst_edit_bonus.c	\
			ft_lst_get_bonus.c	\
			ft_lst_iter_bonus.c

#* Colors

ESC = \033[
DEF_COLOR = $(ESC)0;39m
GRAY = $(ESC)0;90m
RED = $(ESC)0;91m
GREEN = $(ESC)0;92m
YELLOW = $(ESC)0;93m
BLUE = $(ESC)0;94m
MAGENTA = $(ESC)0;95m
CYAN = $(ESC)0;96m
UNDERLINE = $(ESC)4m

COLOR_PRINT = @printf "$(1)$(2)$(DEF_COLOR)\n"

#* Automatic

ifdef INCL_DIR
	CFLAGS += -I$(INCL_DIR)
endif

SRCS = $(addprefix $(SRC_DIR), $(C_FILES))
OBJS =	$(addprefix $(OBJ_DIR), $(notdir $(SRCS:.c=.o)))
BONUS_OBJ =	$(addprefix $(OBJ_DIR), $(BONUS_SRC:.c=.o))

#? cmd for make final file
ifeq ($(suffix $(NAME)), .a)
	LINK_CMD = $(AR) $(NAME) $(OBJS)
else
	LINK_CMD = $(CC) $(CFLAGS) $(OBJS) -o $(NAME)
endif

#* Rules

all:	$(NAME)

$(NAME): $(OBJ_DIR) $(OBJS)
	@printf "$(GRAY)"
	$(LINK_CMD)
	$(call COLOR_PRINT,$(GREEN)$(UNDERLINE),$(NAME) compiled !)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	$(call COLOR_PRINT,$(YELLOW),Compiling: $<)
	@$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR):
	@$(MD) $(OBJ_DIR)

bonus: $(NAME) $(BONUS_OBJ)
	@$(AR) $(NAME) $(BONUS_OBJ)

clean:
	@$(RM) $(OBJS)
	@$(RM) -r $(OBJ_DIR)
	@$(RM) libft_obj.txt
	$(call COLOR_PRINT,$(BLUE),$(NAME) object files cleaned!)

fclean:		clean
	@$(RM) $(NAME)

re:		fclean all
	$(call COLOR_PRINT,$(GREEN),Cleaned and rebuilt everything for $(NAME)!)

.PHONY:		all clean fclean re bonus
