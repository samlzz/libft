/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_lst_edit_bonus.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/12 12:11:52 by sliziard          #+#    #+#             */
/*   Updated: 2024/12/16 12:48:08 by sliziard         ###   ########.fr       */
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
