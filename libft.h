/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libft.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/05 11:54:22 by sliziard          #+#    #+#             */
/*   Updated: 2025/01/20 15:13:01 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBFT_H
# define LIBFT_H

# ifdef LIBFT_INTERNAL_H
#  warning "'libft_internal.h' was already included in 'libft.h'."
# endif

# include "libft_internal.h"

//* ft_is
int				ft_isalpha(int c);
int				ft_isdigit(int c);
int				ft_isalnum(int c);
int				ft_isascii(int c);
int				ft_isprint(int c);

//* ft_char
int				ft_toupper(int c);
int				ft_tolower(int c);
char			*ft_strchr(const char *s, int c);
char			*ft_strrchr(const char *s, int c);

//* ft_str
size_t			ft_strlen(const char *str);
size_t			ft_strlcat(char *dst, const char *src, size_t size);
size_t			ft_strlcpy(char *dst, const char *src, size_t size);
/**
 * @brief Compares two strings up to a given number of characters.
 * @return 
 *	- 0, if the s1 and s2 are equal

 *	- a `negative` value if s1 is less than s2
 
 *	- a `positive` value if s1 is greater than s2.
 */
int				ft_strncmp(const char *s1, const char *s2, size_t n);
char			*ft_strnstr(const char *big, const char *little, size_t len);

//* ft_str_alloc
char			*ft_strdup(const char *s);
char			*ft_substr(char const *s, unsigned int start, size_t len);
char			*ft_strjoin(char const *s1, char const *s2);
char			*ft_strtrim(char const *s1, char const *set);
// split
char			**ft_split(char const *s, char c);
void			ft_splitfree(char **splited, size_t end);

//* ft_str_iter
char			*ft_strmapi(char const *s, char (*f) (unsigned int, char));
void			ft_striteri(char *s, void (*f) (unsigned int, char *));

//* ft_mem
void			*ft_memset(void *s, int c, size_t n);
// Don't manage overlap
void			*ft_memcpy(void *dest, const void *src, size_t n);
// Manage overlap
void			*ft_memmove(void *dest, const void *src, size_t n);
void			*ft_memchr(const void *s, int c, size_t n);
int				ft_memcmp(const void *s1, const void *s2, size_t n);

//* ft_utils
void			ft_bzero(void *s, size_t n);
void			*ft_calloc(size_t nmemb, size_t size);
unsigned int	ft_abs(int value);

//* ft_convert
int				ft_atoi(const char *nptr);
int				ft_satoi(char const *nptr, int *error);
char			*ft_itoa(int n);
char			*ft_ltoa(long n);

//* ft_convert_base
char			*ft_itoa_base(int n, char *base);
char			*ft_ltoa_base(long n, char *base);
char			*ft_ulltoa_base(unsigned long long n, char *base);

//* ft_output
void			ft_putchar_fd(char c, int fd);
void			ft_putstr_fd(char *s, int fd);
void			ft_putendl_fd(char *s, int fd);
void			ft_putnbr_fd(int n, int fd);

//* BONUS

/**
 * @struct s_list
 * @brief Represents a node in a linked list.
 */
typedef struct s_list
{
	void			*content;
	struct s_list	*next;
}	t_list;
/**
 * @typedef t_lst_f
 * @brief Function pointer type for list element operations.
 */
typedef void	(*t_lst_f) (void *);

//* functions
t_list			*ft_lstnew(void *content);
int				ft_lstsize(t_list *lst);
t_list			*ft_lstlast(t_list *lst);
t_list			*ft_lstoflast(t_list *lst, size_t offset);
void			ft_lstadd_front(t_list **lst, t_list *new);
void			ft_lstadd_back(t_list **lst, t_list *new);
void			ft_lstdelone(t_list *lst, t_lst_f del);
void			ft_lstclear(t_list **lst, t_lst_f del);
void			ft_lstiter(t_list *lst, void (*f)(void *));
void			ft_lstiteri(t_list *lst, void (*f)(void *, size_t));
t_list			*ft_lstmap(t_list *lst, void *(*f)(void *), t_lst_f del);

#endif
