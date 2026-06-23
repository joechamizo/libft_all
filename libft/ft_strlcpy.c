/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlcpy.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: joaqumar <joaqumar@student.42barcelon      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/04/16 08:18:22 by joaqumar          #+#    #+#             */
/*   Updated: 2026/04/23 16:13:43 by joaqumar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

size_t	ft_strlcpy(char *dst, const char *src, size_t size)
{
	const char	*s;

	if (!src)
		return (0);
	s = src;
	if (size > 0)
	{
		while (*s && size > 1)
		{
			*dst++ = *s++;
			size--;
		}
		*dst = '\0';
	}
	while (*s)
		s++;
	return (s - src);
}
