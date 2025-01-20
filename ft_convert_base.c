/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_convert_base.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/20 14:44:45 by sliziard          #+#    #+#             */
/*   Updated: 2025/01/20 15:15:38 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#include <limits.h>
#include <stdlib.h>

char	*ft_itoa_base(int n, char *base)
{
	t_mem	*dest;
	size_t	b_len;
	char	*n_in_b;

	if (!ft_valid_base(base, &b_len))
		return (NULL);
	dest = _init_dest_to_convert((long)n, b_len);
	if (!dest)
		return (NULL);
	_nb_to_asciistr((long)n, dest, base, b_len);
	n_in_b = dest->content;
	free(dest);
	return (n_in_b);
}

char	*ft_ltoa_base(long n, char *base)
{
	t_mem	*dest;
	size_t	b_len;
	char	*n_in_b;

	if (!ft_valid_base(base, &b_len))
		return (NULL);
	if (n == LONG_MIN)
	{
		return (ft_strdup("-9223372036854775808"));
	}
	dest = _init_dest_to_convert(n, b_len);
	if (!dest)
		return (NULL);
	_nb_to_asciistr(n, dest, base, b_len);
	n_in_b = dest->content;
	free(dest);
	return (n_in_b);
}

char	*ft_ulltoa_base(unsigned long long n, char *base)
{
	unsigned long long	tmp;
	size_t				base_len;
	t_mem				dest;

	if (!ft_valid_base(base, &base_len))
		return (NULL);
	tmp = n;
	dest.size = 1;
	while (tmp >= (unsigned long long)base_len)
	{
		tmp /= (unsigned long long)base_len;
		dest.size++;
	}
	dest.content = malloc(sizeof(char) * (dest.size + 1));
	if (!dest.content)
		return (NULL);
	dest.content[dest.size] = '\0';
	while (dest.size)
	{
		dest.content[--dest.size] = base[n % base_len];
		n /= base_len;
	}
	return (dest.content);
}
