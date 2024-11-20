/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_split.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: sliziard <sliziard@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/04 15:26:15 by sliziard          #+#    #+#             */
/*   Updated: 2024/11/13 18:15:10 by sliziard         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"
#	include <stdlib.h>
#	include <stdbool.h>

static size_t	ft_count_words(const char *s, char separator)
{
	size_t	i;
	size_t	count;

	if (!s)
		return (-1);
	i = 0;
	count = 0;
	while (s[i])
	{
		while (s[i] == separator)
			i++;
		if (s[i])
			count++;
		while (s[i] != separator && s[i])
			i++;
	}
	return (count);
}

static void	ft_free_strtab(char **tab, size_t end)
{
	size_t	i;

	i = 0;
	while (i < end)
	{
		free(tab[i]);
		i++;
	}
	free(tab);
}

static bool	ft_get_substr(char const *src, char c, size_t *start, char **substr)
{
	char	*tmp;
	size_t	end;
	size_t	i;

	i = *start;
	while (src[i] == c)
		i++;
	*start = i;
	while (src[i] != c && src[i])
		i++;
	end = i;
	if (end > *start)
	{
		tmp = ft_substr(src, ((unsigned int)(*start)), end - *start);
		if (!tmp)
			return (false);
		*substr = tmp;
	}
	*start = end;
	return (true);
}

char	**ft_split(char const *s, char c)
{
	char	**tab;
	char	*str;
	size_t	word_c;
	size_t	i;
	size_t	j;

	if (!s)
		return (NULL);
	word_c = ft_count_words(s, c);
	tab = malloc(sizeof (char *) * (word_c + 1));
	if (!tab)
		return (NULL);
	j = 0;
	i = 0;
	while (s[i] && j < word_c)
	{
		if (ft_get_substr(s, c, &i, &str))
			tab[j++] = str;
		else
			return (ft_free_strtab(tab, j), NULL);
	}
	tab[j] = NULL;
	return (tab);
}
