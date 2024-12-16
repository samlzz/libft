/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libft.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/05 11:54:22 by sliziard          #+#    #+#             */
/*   Updated: 2024/12/16 12:48:35 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBFT_H
# define LIBFT_H

# include <stddef.h>

typedef struct s_str
{
	char	*str;
	size_t	len;
}	t_str;

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
int				ft_strncmp(const char *s1, const char *s2, size_t n);
char			*ft_strnstr(const char *big, const char *little, size_t len);

//?		alloc
char			*ft_strdup(const char *s);
char			*ft_substr(char const *s, unsigned int start, size_t len);
char			*ft_strjoin(char const *s1, char const *s2);
char			*ft_strtrim(char const *s1, char const *set);

//?		iter
char			*ft_strmapi(char const *s, char (*f) (unsigned int, char));
void			ft_striteri(char *s, void (*f) (unsigned int, char *));

//?		split
char			**ft_split(char const *s, char c);

//* ft_mem
void			*ft_memset(void *s, int c, size_t n);
void			*ft_memcpy(void *dest, const void *src, size_t n);
void			*ft_memmove(void *dest, const void *src, size_t n);
void			*ft_memchr(const void *s, int c, size_t n);
int				ft_memcmp(const void *s1, const void *s2, size_t n);

//* ft_utils
void			ft_bzero(void *s, size_t n);
void			*ft_calloc(size_t nmemb, size_t size);
unsigned int	ft_abs(int value);

//* ft_conversion
int				ft_atoi(const char *nptr);
char			*ft_itoa(int n);

//* ft_output
void			ft_putchar_fd(char c, int fd);
void			ft_putstr_fd(char *s, int fd);
void			ft_putendl_fd(char *s, int fd);
void			ft_putnbr_fd(int n, int fd);

//* BONUS

typedef struct s_list
{
	void			*content;
	struct s_list	*next;
}	t_list;

typedef void	(*t_lst_f) (void *);

//?	get list
t_list			*ft_lstnew(void *content);
int				ft_lstsize(t_list *lst);
t_list			*ft_lstlast(t_list *lst);
t_list			*ft_lstoflast(t_list *lst, size_t offset);

//?	edit list
void			ft_lstadd_front(t_list **lst, t_list *new);
void			ft_lstadd_back(t_list **lst, t_list *new);
void			ft_lstdelone(t_list *lst, t_lst_f del);
void			ft_lstclear(t_list **lst, t_lst_f del);

//? iter list
void			ft_lstiter(t_list *lst, void (*f)(void *));
void			ft_lstiteri(t_list *lst, void (*f)(void *, size_t));
t_list			*ft_lstmap(t_list *lst, void *(*f)(void *), t_lst_f del);

#endif
