/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list2_bonus.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/12 12:11:04 by sliziard          #+#    #+#             */
/*   Updated: 2024/11/14 13:18:42 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	ft_lstadd_front(t_list **lst, t_list *new)
{
	if (new)
	{
		new->next = *lst;
		*lst = new;
	}
}

void	ft_lstadd_back(t_list **lst, t_list *new)
{
	t_list	*last;

	if (!*lst)
		return (ft_lstadd_front(lst, new));
	last = ft_lstlast(*lst);
	last->next = new;
}

void	ft_lstiter(t_list *lst, void (*f)(void *))
{
	t_list	*first;

	first = lst;
	while (lst)
	{
		f(lst->content);
		lst = lst->next;
		if (first == lst)
			break ;
	}
}

void	ft_lstiteri(t_list *lst, void (*f)(void *, size_t))
{
	t_list	*first;
	size_t	i;

	i = 0;
	first = lst;
	while (lst)
	{
		f(lst->content, i++);
		lst = lst->next;
		if (first == lst)
			break ;
	}
}

t_list	*ft_lstmap(t_list *lst, void *(*f)(void *), void (*del)(void *))
{
	t_list	*first;
	t_list	*mapped;
	t_list	*new;
	void	*content;

	mapped = NULL;
	new = NULL;
	first = lst;
	while (lst)
	{
		content = f(lst->content);
		new = ft_lstnew(content);
		if (!new)
		{
			del(content);
			ft_lstclear(&mapped, del);
			return (NULL);
		}
		ft_lstadd_back(&mapped, new);
		lst = lst->next;
		if (lst == first)
			return (ft_lstclear(&mapped, del), NULL);
	}
	return (mapped);
}
