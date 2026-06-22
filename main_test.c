/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_test.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: joaqumar <joaqumar@student.42barcelona.co  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2026/06/22 21:04:53 by joaqumar          #+#    #+#             */
/*   Updated: 2026/06/22 21:21:51 by joaqumar         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft/libft.h"
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <limits.h>

int main(void)
{
#ifdef TEST_LIBFT
    printf("\n============ 📦 BATERÍA EXTENSA: LIBFT BASE ============\n");
    
    printf("[1/4] Probando ft_split con múltiples delimitadores...\n");
    char **matrix = ft_split("---Hola---mundo---desde---42-Madrid---", '-');
    if (matrix)
    {
        int i = 0;
        while (matrix[i])
        {
            printf("  -> Palabra [%d]: %s\n", i, matrix[i]);
            free(matrix[i++]);
        }
        free(matrix);
    }

    printf("\n[2/4] Probando ft_itoa con límites enteros (Edge Cases)...\n");
    char *res_min = ft_itoa(INT_MIN);
    char *res_max = ft_itoa(INT_MAX);
    char *res_zero = ft_itoa(0);
    printf("  -> INT_MIN: %s\n", res_min);
    printf("  -> INT_MAX: %s\n", res_max);
    printf("  -> CERO:    %s\n", res_zero);
    free(res_min); free(res_max); free(res_zero);

    printf("\n[3/4] Probando ft_strjoin con strings vacíos...\n");
    char *join1 = ft_strjoin("", "42");
    char *join2 = ft_strjoin("Madrid", "");
    printf("  -> Join 1: '%s'\n", join1);
    printf("  -> Join 2: '%s'\n", join2);
    free(join1); free(join2);

    printf("\n[4/4] Probando ft_strnstr (búsquedas complejas)...\n");
    char *haystack = "Un anillo para gobernarlos a todos.";
    printf("  -> Encontrado 'anillo' (len 15): %s\n", ft_strnstr(haystack, "anillo", 15));
    printf("  -> Encontrado 'anillo' (len 5, insuficiente): %s\n", ft_strnstr(haystack, "anillo", 5) ? "Sí" : "NULL (Correcto)");
#endif

#ifdef TEST_PRINTF
    printf("\n============ ✍️ BATERÍA EXTENSA: FT_PRINTF ESTÁNDAR ============\n");
    int mock_len;

    printf("[1/3] Tipos numéricos combinados:\n");
    mock_len = ft_printf("  -> Mi printf:   %%d=%d, %%i=%i, %%u=%u, %%x=%x, %%X=%X\n", -2147483647, 4242, 4294967295U, 255, 255);
    printf("     (Mide: %d caracteres)\n", mock_len);

    printf("\n[2/3] Strings, Caracteres y Nulos:\n");
    mock_len = ft_printf("  -> Char: '%c' | String nulo: %s\n", 'A', (char *)NULL);
    printf("     (Mide: %d caracteres)\n", mock_len);

    printf("\n[3/3] Punteros Extremos y Direcciones:\n");
    int val = 42;
    mock_len = ft_printf("  -> Puntero normal: %p | Puntero NULL: %p\n", &val, (void *)NULL);
    printf("     (Mide: %d caracteres)\n", mock_len);
#endif

#ifdef TEST_PRINTF_BONUS
    printf("\n============ 🎖️ BATERÍA EXTENSA: FT_PRINTF BONUS ============\n");
    
    printf("[1/3] Combinación de Flags '+' y ' ' (Espacio) con números:\n");
    ft_printf("  -> Positivo con '+': %+d | Negativo con '+': %+d\n", 500, -500);
    ft_printf("  -> Positivo con ' ': % d | Negativo con ' ': % d\n", 500, -500);

    printf("\n[2/3] Flag '#' con Hexadecimales (Mayúsculas/Minúsculas):\n");
    ft_printf("  -> Hex '#' cero:      %#x\n", 0);
    ft_printf("  -> Hex '#' normal x:  %#x\n", 3735928559U); // DEADBEEF
    ft_printf("  -> Hex '#' normal X:  %#X\n", 3735928559U);

    printf("\n[3/3] Mezclas extremas en cadena:\n");
    ft_printf("  -> Flags: %+d | %#x | % i | %% (Porcentaje literal)\n", 7, 15, 0);
#endif

#ifdef TEST_GNL
    printf("\n============ 📖 BATERÍA EXTENSA: GET_NEXT_LINE ============\n");
    
    // Crear escenario
    int temp_fd = open("test_gnl_extensive.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (temp_fd >= 0)
    {
        write(temp_fd, "Linea de texto estándar con saltos de linea normales.\n\n", 55);
        write(temp_fd, "Siguiente línea sin salto al final de la misma", 46);
        close(temp_fd);
    }

    int fd = open("test_gnl_extensive.txt", O_RDONLY);
    if (fd < 0) return (1);

    char *line;
    int line_num = 1;
    printf("[Procesando archivo línea a línea]:\n");
    while ((line = get_next_line(fd)) != NULL)
    {
        printf("  -> Línea %d: [%s]\n", line_num++, line);
        free(line);
    }
    close(fd);
    unlink("test_gnl_extensive.txt");
    
    printf("\n[Edge Case] Pasando un FD incorrecto o cerrado (-1):\n");
    char *err_line = get_next_line(-1);
    printf("  -> Output con FD -1: %s\n", err_line ? err_line : "NULL (Correcto y Protegido)");
    free(err_line);
#endif

#ifdef TEST_GNL_BONUS
    printf("\n============ 🎖️ BATERÍA EXTENSA: GET_NEXT_LINE BONUS ============\n");
    
    // Crear escenario multirruta
    int fda = open("file_a.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    int fdb = open("file_b.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    int fdc = open("file_c.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    write(fda, "A1\nA2\n", 6);
    write(fdb, "B1\nB2\n", 6);
    write(fdc, "C1\nC2\n", 6);
    close(fda); close(fdb); close(fdc);

    fda = open("file_a.txt", O_RDONLY);
    fdb = open("file_b.txt", O_RDONLY);
    fdc = open("file_c.txt", O_RDONLY);

    char *la, *lb, *lc;

    printf("[Lectura entrelazada de 3 archivos en paralelo]:\n");
    
    // Ronda 1
    la = get_next_line(fda); printf("  -> Desde FD A (Esperado A1): %s", la); free(la);
    lb = get_next_line(fdb); printf("  -> Desde FD B (Esperado B1): %s", lb); free(lb);
    lc = get_next_line(fdc); printf("  -> Desde FD C (Esperado C1): %s", lc); free(lc);

    // Ronda 2
    la = get_next_line(fda); printf("  -> Desde FD A (Esperado A2): %s", la); free(la);
    lb = get_next_line(fdb); printf("  -> Desde FD B (Esperado B2): %s", lb); free(lb);
    lc = get_next_line(fdc); printf("  -> Desde FD C (Esperado C2): %s", lc); free(lc);

    close(fda); close(fdb); close(fdc);
    unlink("file_a.txt"); unlink("file_b.txt"); unlink("file_c.txt");
    printf("\n");
#endif

    return (0);
}

