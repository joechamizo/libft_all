/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strlcat.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: joaqumar <joaqumar@student.42barcelon      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/04/16 09:35:05 by joaqumar          #+#    #+#             */
/*   Updated: 2026/04/24 10:47:53 by joaqumar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

size_t	ft_strlcat(char *dst, const char *src, size_t dstsize)
{
	size_t	s_len;
	size_t	d_len;
	size_t	remain;

	s_len = ft_strlen(src);
	d_len = 0;
	while (d_len < dstsize && dst[d_len])
		d_len++;
	if (d_len == dstsize)
		return (dstsize + s_len);
	dst += d_len;
	remain = dstsize - d_len;
	while (*src && remain > 1)
	{
		*dst++ = *src++;
		remain--;
	}
	*dst = '\0';
	return (d_len + s_len);
}
