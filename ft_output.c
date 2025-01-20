/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_output.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/04 15:26:27 by sliziard          #+#    #+#             */
/*   Updated: 2025/01/20 15:06:10 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdlib.h>
#include "libft.h"

#define PUTNBR_BASE 10

void	ft_putchar_fd(char c, int fd)
{
	if (fd < 0)
		return ;
	write(fd, &c, 1);
}

void	ft_putstr_fd(char *s, int fd)
{
	if (fd < 0)
		return ;
	write(fd, s, ft_strlen(s));
}

void	ft_putendl_fd(char *s, int fd)
{
	char	*endl;

	if (fd < 0)
		return ;
	endl = ft_strjoin(s, "\n");
	if (endl)
	{
		ft_putstr_fd(endl, fd);
		free(endl);
	}
	else
	{
		ft_putstr_fd(s, fd);
		write(fd, "\n", 1);
	}
}

static void	_recurs_putnbr_fd(long n, int fd)
{
	if (n < 0)
	{
		ft_putchar_fd('-', fd);
		n = -n;
	}
	if (n >= PUTNBR_BASE)
		_recurs_putnbr_fd(n / PUTNBR_BASE, fd);
	ft_putchar_fd((n % PUTNBR_BASE) + '0', fd);
}

void	ft_putnbr_fd(int n, int fd)
{
	if (fd < 0)
		return ;
	_recurs_putnbr_fd((long)n, fd);
}
