/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libft_internal.h                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/01/20 14:34:46 by sliziard          #+#    #+#             */
/*   Updated: 2025/01/20 15:04:06 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBFT_INTERNAL_H
# define LIBFT_INTERNAL_H

# include <stddef.h>
# include <stdbool.h>

/**
 * @struct s_mem
 * @brief Represents a memory table with content and size.
 */
typedef struct s_mem
{
	char	*content;
	size_t	size;
}	t_mem;

//* conversion utils
void	_nb_to_asciistr(long nb, t_mem *dest, char *base, size_t b_len);
t_mem	*_init_dest_to_convert(long n, size_t base_l);

bool	ft_valid_base(char *base, size_t *len);

#endif
