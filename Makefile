# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/11/05 19:03:59 by sliziard          #+#    #+#              #
#    Updated: 2024/11/14 17:18:20 by sliziard         ###   ########.fr        #
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
			
BONUS_SRC =	ft_list_bonus.c	\
			ft_list2_bonus.c

#* Colors

DEF_COLOR = \033[0;39m
GRAY = \033[0;90m
RED = \033[0;91m
GREEN = \033[0;92m
YELLOW = \033[0;93m
BLUE = \033[0;94m
MAGENTA = \033[0;95m
CYAN = \033[0;96m
WHITE = \033[0;97m
UNDERLINE = \033[4m


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
	@echo "$(GRAY)"
	$(LINK_CMD)
	@echo "$(GREEN)$(UNDERLINE)$(NAME) compiled!$(DEF_COLOR)"

$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	@echo "$(YELLOW)Compiling: $< $(DEF_COLOR)"
	@$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR):
	@$(MD) $(OBJ_DIR)

bonus: $(OBJ_DIR) $(OBJS) $(BONUS_OBJ)
	@$(AR) $(NAME) $(BONUS_OBJ)

clean:
	@$(RM) $(OBJS)
	@$(RM) -r $(OBJ_DIR)
	@$(RM) libft_obj.txt
	@echo "$(BLUE)$(NAME) object files cleaned!$(DEF_COLOR)"

fclean:		clean
	@$(RM) $(NAME)

re:		fclean all
	@echo "$(GREEN)Cleaned and rebuilt everything for $(NAME)!$(DEF_COLOR)"

.PHONY:		all clean fclean re bonus
