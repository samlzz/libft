/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_utils.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/04 15:15:55 by sliziard          #+#    #+#             */
/*   Updated: 2024/12/16 12:40:08 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#include <stdlib.h>
#include <stdint.h>

void	ft_bzero(void *s, size_t n)
{
	ft_memset(s, 0, n);
}

void	*ft_calloc(size_t nmemb, size_t size)
{
	void	*ptr;
	size_t	alloc_s;

	if (nmemb == 0 || size == 0)
		return (malloc(0));
	if (nmemb >= SIZE_MAX / size)
		return (NULL);
	alloc_s = nmemb * size;
	if (alloc_s > INT32_MAX)
		return (NULL);
	ptr = malloc(alloc_s);
	if (!ptr)
		return (NULL);
	ft_bzero(ptr, alloc_s);
	return (ptr);
}

unsigned int	ft_abs(int value)
{
	if (value < 0)
		return (-value);
	return (value);
}
