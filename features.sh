# le tout en anglais:

# demander ce que l'utilisateur veux ajouter a la libft
# afficher un menu, navigue avec les fleches et selectionner les options avec espace
# - voulez vous automatiquement compiler les bonus pour votre lifbt ?
# - voulez vous ajouter ft_printf ?
# - voulez vous ajouter get_next_line ?

#? './libft':

#* Pour compiler bonus automatiquement
# trouver la ligne avec 'all:	$(NAME)' dans ./Makefile
# rajouter ' bonus' a la fin de cette ligne

#* Pour ajouter ft_printf
# git clone > ./ft_printf
# ?cd ft_printf
# suprimer tout sauf src (.git, Makefile, .gitignore, ...)
# deplacer tout les fichiers de ./src dans ./
# suprimer src
# ?cd ..
# mkdir -p include
# mv ./libft.h ./include/
# mv ./ft_printf/ft_printf.h ./include/
# trouver '# include <stddef.h>' dans libft.h et ajouter '# include <ft_printf.h>'
# dans ./Makefile:
# ajouter tout les fichiers .c contenu dans ./ft_printf a C_FILES
# ajouter include a INCL_DIR


#* Pour ajouter get_next_line
# git clone > ./get_next_line
# ?cd get_next_line
# suprimer tout sauf "get_next_line.c get_next_line_utils.c get_next_line.h"
# ? cd ..
# mkdir -p include
# mv ./libft.h ./include/
# mv ./get_next_line/get_next_line.h ./include/
# trouver '# include <stddef.h>' dans libft.h et ajouter '# include <get_next_line.h>'
# dans ./Makefile:
# ajouter les fichiers .c dans ./get_next_line a C_FILES
# ajouter include a INCL_DIR

# quand ce script se finis il informe qu'il va se suprrimer, invite l'user a lancer 'norminette' pour verifier si tout est bien a la norme
# puis suprime ce fichiers (features.sh)