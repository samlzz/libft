/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libft_bonus.h                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/04/06 22:12:39 by sliziard          #+#    #+#             */
/*   Updated: 2025/04/06 22:13:35 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBFT_BONUS_H
# define LIBFT_BONUS_H

# include <stddef.h>

//* Linked list
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
void			ft_lstadd_front(t_list **lst, t_list *new_node)
				__attribute__ ((nonnull(1)));
void			ft_lstadd_back(t_list **lst, t_list *new_node)
				__attribute__ ((nonnull(1)));
int				ft_lstrm_byctn(t_list **lst, void *content, t_lst_f del)
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

//* Dynamic buffer

# ifndef DYNBUF_INIT_CAP
#  define DYNBUF_INIT_CAP		8
# endif
# ifndef DYNBUF_REALOC_FACTOR
#  define DYNBUF_REALOC_FACTOR	2
# endif

typedef struct s_dynbuf
{
	char	*data;
	size_t	len;
	size_t	capacity;
}	t_dynbuf;

t_dynbuf		ft_dynbuf_new(int *init_cap);
char			*ft_dynbuf_append_str(t_dynbuf *buf, const char *s)
				__attribute__ ((nonnull(1)));
char			*ft_dynbuf_append_char(t_dynbuf *buf, char c)
				__attribute__ ((nonnull(1)));
void			ft_dynbuf_free(t_dynbuf *buf)
				__attribute__ ((nonnull(1)));

#endif
