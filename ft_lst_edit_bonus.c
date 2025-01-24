/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_lst_edit_bonus.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/12 12:11:52 by sliziard          #+#    #+#             */
/*   Updated: 2025/01/24 17:09:55 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#include <stdlib.h>

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

void	ft_lstremove(t_list **lst, t_list *to_rm, t_lst_f del)
{
	t_list	*curr;
	t_list	*prev;
	t_list	*next;

	if (!*lst || !to_rm || !del)
		return ;
	prev = NULL;
	curr = *lst;
	next = NULL;
	while (curr && curr != to_rm)
	{
		prev = curr;
		curr = curr->next;
	}
	if (curr)
		next = curr->next;
	ft_lstdelone(to_rm, del);
	if (!next)
		return ;
	if (prev)
		prev->next = next;
	else
		*lst = next;
}

void	ft_lstdelone(t_list *lst, t_lst_f del)
{
	if (!lst)
		return ;
	if (del)
		del(lst->content);
	free(lst);
}

void	ft_lstclear(t_list **lst, t_lst_f del)
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
