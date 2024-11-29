/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_conversion.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/04 15:20:37 by sliziard          #+#    #+#             */
/*   Updated: 2024/11/12 09:46:13 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#include <stdlib.h>
#include <limits.h>

int	ft_atoi(const char *nptr)
{
	int	r;
	int	s;

	r = 0;
	s = 1;
	while ((*nptr < 14 && *nptr > 8) || *nptr == ' ')
		nptr++;
	if (*nptr == '-' || *nptr == '+')
	{
		if (*nptr == '-')
			s = -1;
		nptr++;
	}
	while (*nptr >= '0' && *nptr <= '9' && *nptr)
	{
		r = (r * 10) + *nptr - '0';
		nptr++;
	}
	return (r * s);
}

static void	nb_to_astr(long nb, t_str *dest, char *base, size_t b_len)
{
	dest->str[dest->len] = '\0';
	if (nb == 0)
	{
		dest->str[0] = base[0];
		return ;
	}
	if (nb < 0)
	{
		nb = -nb;
		dest->str[0] = '-';
	}
	while (nb)
	{
		dest->str[--dest->len] = base[nb % b_len];
		nb /= b_len;
	}
}

static t_str	*init_dest(long n, size_t base_l)
{
	t_str	*dest;

	dest = malloc(sizeof (t_str));
	if (!dest)
		return (NULL);
	dest->len = 0;
	if (n <= 0)
	{
		dest->len = 1;
		if (n)
			n = -n;
	}
	while (n)
	{
		n /= base_l;
		dest->len++;
	}
	dest->str = malloc(sizeof (char) * (dest->len + 1));
	if (!dest->str)
	{
		free(dest);
		return (NULL);
	}
	return (dest);
}

//* INT
char	*ft_itoa(int n)
{
	t_str	*dest;
	char	*n_in_base10;

	dest = init_dest((long)n, 10);
	if (!dest)
		return (NULL);
	nb_to_astr((long)n, dest, "0123456789", 10);
	n_in_base10 = dest->str;
	free(dest);
	return (n_in_base10);
}
