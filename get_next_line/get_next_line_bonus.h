/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_bonus.h                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: joaqumar <joaqumar@student.42barcelona.co  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/05/10 23:02:14 by joaqumar          #+#    #+#             */
/*   Updated: 2026/05/10 23:07:34 by joaqumar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef GET_NEXT_LINE_BONUS_H
# define GET_NEXT_LINE_BONUS_H

# include <unistd.h>
# include <stdlib.h>
# include <limits.h>

# ifndef BUFFER_SIZE
#  define BUFFER_SIZE 5
# endif

# ifndef CUT_CHAR
#  define CUT_CHAR '\n'
# endif

# ifndef OPEN_MAX
#  define OPEN_MAX 1024
# endif

typedef struct s_list
{
	char			*str_buf;
	struct s_list	*next;
}	t_list;

char	*get_next_line_c(int fd, char cut_char);
# define get_next_line(fd) get_next_line_c((fd), CUT_CHAR)
void	create_list(t_list **list, int fd, char cut_char);
char	*get_line_from_list(t_list *list, char cut_char);
void	refine_list(t_list **list, char cut_char);
void	dealloc_list(t_list **list, t_list *clean_node);
int		found_newline(t_list *list, char cut_char);
t_list	*find_last_node(t_list *list);
void	append_node(t_list **list, char *buf);
int		len_until_newline(t_list *list, char cut_char);
void	copy_str(t_list *list, char *str, char cut_char);

#endif
