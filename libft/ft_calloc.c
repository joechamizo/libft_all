/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_calloc.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: joaqumar <joaqumar@student.42barcelona.co  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/04/19 12:32:24 by joaqumar          #+#    #+#             */
/*   Updated: 2026/04/23 13:27:43 by joaqumar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

void	*ft_calloc(size_t count, size_t size)
{
	void	*ptr;
	size_t	total_s;

	total_s = count * size;
	if (count != 0 && total_s / count != size)
		return (NULL);
	ptr = malloc(total_s);
	if (!ptr)
		return (NULL);
	ft_memset(ptr, 0, total_s);
	return (ptr);
}
