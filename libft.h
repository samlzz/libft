/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libft.h                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/05 11:54:22 by sliziard          #+#    #+#             */
/*   Updated: 2025/01/20 17:52:22 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBFT_H
# define LIBFT_H

# ifdef LIBFT_INTERNAL_H
#  warning "Check your import, 'libft_internal.h' was already included."
# endif

# include "libft_internal.h"

//* ft_is
int				ft_isalpha(int c) __attribute__ ((const));
int				ft_isdigit(int c) __attribute__ ((const));
int				ft_isalnum(int c) __attribute__ ((const));
int				ft_isascii(int c) __attribute__ ((const));
int				ft_isprint(int c) __attribute__ ((const));

//* ft_char
int				ft_toupper(int c) __attribute__ ((const));
int				ft_tolower(int c) __attribute__ ((const));
char			*ft_strchr(const char *s, int c) __attribute__ ((nonnull(1)));
char			*ft_strrchr(const char *s, int c) __attribute__ ((nonnull(1)));

//* ft_str
size_t			ft_strlen(const char *str) __attribute__ ((nonnull(1), pure));
size_t			ft_strlcat(char *dst, const char *src, size_t size)
				__attribute__ ((nonnull(1, 2)));
size_t			ft_strlcpy(char *dst, const char *src, size_t size)
				__attribute__ ((nonnull(1, 2)));
/**
 * @brief Compares two strings up to a given number of characters.
 * @return 
 *	- 0, if the s1 and s2 are equal

 *	- a `negative` value if s1 is less than s2
 
 *	- a `positive` value if s1 is greater than s2.
 */
int				ft_strncmp(const char *s1, const char *s2, size_t n)
				__attribute__ ((nonnull(1, 2)));
char			*ft_strnstr(const char *big, const char *little, size_t len)
				__attribute__ ((nonnull(1, 2)));

//* ft_str_alloc
char			*ft_strdup(const char *s)
				__attribute__ ((warn_unused_result, nonnull(1)));
char			*ft_substr(char const *s, unsigned int start, size_t len)
				__attribute__ ((warn_unused_result, nonnull(1)));
char			*ft_strjoin(char const *s1, char const *s2)
				__attribute__ ((warn_unused_result, nonnull(1, 2)));
char			*ft_strtrim(char const *s1, char const *set)
				__attribute__ ((warn_unused_result, nonnull(1, 2)));
// split
char			**ft_split(char const *s, char c)
				__attribute__ ((warn_unused_result, nonnull(1)));
void			ft_splitfree(char **splited, size_t end);

//* ft_str_iter
char			*ft_strmapi(char const *s, char (*f) (unsigned int, char))
				__attribute__ ((nonnull(1, 2)));
void			ft_striteri(char *s, void (*f) (unsigned int, char *))
				__attribute__ ((nonnull(1, 2)));

//* ft_mem
void			*ft_memset(void *s, int c, size_t n)
				__attribute__ ((nonnull(1)));
// Don't manage overlap
void			*ft_memcpy(void *dest, const void *src, size_t n)
				__attribute__ ((nonnull(1, 2)));
// Manage overlap
void			*ft_memmove(void *dest, const void *src, size_t n)
				__attribute__ ((nonnull(1, 2)));
void			*ft_memchr(const void *s, int c, size_t n)
				__attribute__ ((nonnull(1)));
int				ft_memcmp(const void *s1, const void *s2, size_t n)
				__attribute__ ((nonnull(1, 2)));

//* ft_utils
void			ft_bzero(void *s, size_t n) __attribute__ ((nonnull(1)));
void			*ft_calloc(size_t nmemb, size_t size)
				__attribute__ ((warn_unused_result, alloc_size(1, 2)));
void			*ft_realloc(void *ptr, size_t og_size, size_t new_size)
				__attribute__ ((warn_unused_result, alloc_size(3)));
unsigned int	ft_abs(int value) __attribute__ ((const));

//* ft_convert
int				ft_atoi(const char *nptr)
				__attribute__ ((nonnull(1)));
int				ft_satoi(char const *nptr, int *error)
				__attribute__ ((nonnull(1, 2)));
char			*ft_itoa(int n);
char			*ft_ltoa(long n);

//* ft_convert_base
char			*ft_itoa_base(int n, char *base)
				__attribute__ ((nonnull(2)));
char			*ft_ltoa_base(long n, char *base)
				__attribute__ ((nonnull(2)));
char			*ft_ulltoa_base(unsigned long long n, char *base)
				__attribute__ ((nonnull(2)));

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
int				ft_lstsize(t_list *lst) __attribute__ ((pure));
t_list			*ft_lstlast(t_list *lst)__attribute__ ((warn_unused_result));
t_list			*ft_lstoflast(t_list *lst, size_t offset)
				__attribute__((deprecated("This func needs to be re-written")));
void			ft_lstadd_front(t_list **lst, t_list *new)
				__attribute__ ((nonnull(1)));
void			ft_lstadd_back(t_list **lst, t_list *new)
				__attribute__ ((nonnull(1)));
void			ft_lstdelone(t_list *lst, t_lst_f del);
void			ft_lstclear(t_list **lst, t_lst_f del)
				__attribute__ ((nonnull(1)));
void			ft_lstiter(t_list *lst, t_lst_f f)
				__attribute__ ((nonnull(2)));
void			ft_lstiteri(t_list *lst, void (*f)(void *, size_t))
				__attribute__ ((nonnull(2)));
t_list			*ft_lstmap(t_list *lst, void *(*f)(void *), t_lst_f del)
				__attribute__ ((warn_unused_result, nonnull(2)));

#endif
