/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_bonus.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/12 12:11:52 by sliziard          #+#    #+#             */
/*   Updated: 2024/11/12 17:23:14 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#include <stdlib.h>

t_list	*ft_lstnew(void *content)
{
	t_list	*new;

	new = malloc(sizeof (t_list));
	if (!new)
		return (NULL);
	new->content = content;
	new->next = NULL;
	return (new);
}

int	ft_lstsize(t_list *lst)
{
	int		len;
	t_list	*first;

	len = 0;
	if (!lst)
		return (len);
	first = lst;
	while (lst)
	{
		len++;
		lst = lst->next;
		if (first == lst)
			break ;
	}
	return (len);
}

t_list	*ft_lstlast(t_list *lst)
{
	t_list	*first;

	if (!lst)
		return (NULL);
	first = lst;
	while (lst->next)
	{
		lst = lst->next;
		if (first == lst)
			break ;
	}
	return (lst);
}

void	ft_lstdelone(t_list *lst, void (*del)(void *))
{
	if (!lst)
		return ;
	del(lst->content);
	free(lst);
}

void	ft_lstclear(t_list **lst, void (*del)(void *))
{
	t_list	*curr;
	t_list	*nxt_save;

	curr = *lst;
	nxt_save = NULL;
	while (curr)
	{
		nxt_save = curr->next;
		ft_lstdelone(curr, del);
		curr = nxt_save;
		if (curr == *lst)
			break ;
	}
	*lst = NULL;
}
