/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_convert.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/04 15:20:37 by sliziard          #+#    #+#             */
/*   Updated: 2025/01/20 15:03:24 by sliziard         ###   ########.fr       */
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

int	ft_satoi(char const *nptr, int *error)
{
	long	r;
	int		s;

	r = 0;
	s = 1;
	*error = 0;
	if (*nptr == '-' || *nptr == '+')
	{
		if (*nptr == '-')
			s = -1;
		nptr++;
	}
	while (*nptr >= '0' && *nptr <= '9' && *nptr)
	{
		r = (r * 10) + *nptr - '0';
		if ((s == 1 && r > INT_MAX) || (s == -1 && (r * -1) < INT_MIN))
		{
			*error = 1;
			return ((s == 1) * INT_MAX + (s != 1) * INT_MIN);
		}
		nptr++;
	}
	if (*nptr || *(nptr - 1) == '-' || *(nptr - 1) == '+')
		*error = 1;
	return ((int)r * s);
}

char	*ft_itoa(int n)
{
	t_mem	*dest;
	char	*n_in_base10;

	dest = _init_dest_to_convert((long)n, 10);
	if (!dest)
		return (NULL);
	_nb_to_asciistr((long)n, dest, "0123456789", 10);
	n_in_base10 = dest->content;
	free(dest);
	return (n_in_base10);
}

char	*ft_ltoa(long n)
{
	t_mem	*dest;
	char	*n_in_base10;

	if (n == LONG_MIN)
		return (ft_strdup("-9223372036854775808"));
	dest = _init_dest_to_convert(n, 10);
	if (!dest)
		return (NULL);
	_nb_to_asciistr(n, dest, "0123456789", 10);
	n_in_base10 = dest->content;
	free(dest);
	return (n_in_base10);
}
