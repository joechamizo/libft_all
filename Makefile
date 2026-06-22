NAME        = libft.a
TEST_EXE    = test_program

# 📁 Directorios de los módulos
LIBFT_DIR   = libft/
PRINTF_DIR  = ft_printf/
GNL_DIR     = get_next_line/
PUSH_DIR    = push_swap/

# 📄 Archivos de cabecera para control de cambios
HEADERS     = $(LIBFT_DIR)libft.h $(PRINTF_DIR)ft_printf.h $(GNL_DIR)get_next_line.h

# 🎨 Colores y formato
GREEN       = \033[0;32m
CYAN        = \033[0;36m
YELLOW      = \033[0;33m
MAGENTA     = \033[0;35m
RESET       = \033[0m
BOLD        = \033[1m

all: menu

lib: $(NAME)

$(NAME): Makefile $(HEADERS)
	@echo "🚀 $(BOLD)Iniciando compilación de la librería maestra...$(RESET)"
	@printf "📦 $(GREEN)[▰▱▱▱▱▱▱▱▱▱] 10%%$(RESET) Compilando Libft...\r"
	@make -C $(LIBFT_DIR) > /dev/null
	@printf "✍️  $(GREEN)[▰▰▰▰▰▱▱▱▱▱] 50%%$(RESET) Compilando FT_Printf...\r"
	@make -C $(PRINTF_DIR) > /dev/null
	@printf "📖 $(GREEN)[▰▰▰▰▰▰▰▰▱▱] 80%%$(RESET) Compilando Get_Next_Line...\r"
	@make -C $(GNL_DIR) > /dev/null
	@cp $(LIBFT_DIR)$(NAME) .
	@ar -rcs $(NAME) $(PRINTF_DIR)*.o $(GNL_DIR)*.o > /dev/null
	@printf "✨ $(GREEN)[▰▰▰▰▰▰▰▰▰▰] 100%%$(RESET) ¡Librería $(BOLD)$(NAME)$(RESET)$(GREEN) empaquetada con éxito!$(RESET)\n"

bonus: lib_bonus push_bonus

lib_bonus: Makefile $(HEADERS)
	@echo "🚀 $(BOLD)Iniciando compilación BONUS de la librería maestra...$(RESET)"
	@printf "📦 $(GREEN)[▰▱▱▱▱▱▱▱▱▱] 10%%$(RESET) Compilando Libft...\r"
	@make -C $(LIBFT_DIR) > /dev/null
	@printf "✍️  $(GREEN)[▰▰▰▰▰▱▱▱▱▱] 50%%$(RESET) Compilando FT_Printf bonus...\r"
	@make -C $(PRINTF_DIR) bonus > /dev/null
	@printf "📖 $(GREEN)[▰▰▰▰▰▰▰▰▱▱] 80%%$(RESET) Compilando Get_Next_Line bonus...\r"
	@make -C $(GNL_DIR) bonus > /dev/null
	@cp $(LIBFT_DIR)$(NAME) .
	@ar -rcs $(NAME) $(PRINTF_DIR)*.o $(GNL_DIR)*.o > /dev/null
	@printf "✨ $(GREEN)[▰▰▰▰▰▰▰▰▰▰] 100%%$(RESET) ¡Librería BONUS $(BOLD)$(NAME)$(RESET)$(GREEN) empaquetada con éxito!$(RESET)\n"

# 📑 MENÚ PRINCIPAL
menu:
	@while true; do \
		clear; \
		echo "$(BOLD)$(MAGENTA)╔═════════════════════════════════════════╗$(RESET)"; \
		echo "$(BOLD)$(MAGENTA)║      🧪 PANEL DE CONTROL DE 42 🧪       ║$(RESET)"; \
		echo "$(BOLD)$(MAGENTA)╚═════════════════════════════════════════╝$(RESET)"; \
		echo "$(BOLD)Selecciona un área de trabajo:$(RESET)"; \
		echo "  1) ⚙️  Menú de Compilaciones y Limpieza"; \
		echo "  2) 📂 Ejecutar Pruebas Estándar (Los 3 Proyectos)"; \
		echo "  3) 🎖️  Ejecutar Pruebas de Versiones BONUS"; \
		echo "  0) ❌ Salir"; \
		echo ""; \
		printf "$(BOLD)Introduce una opción [1-3, o 0]: $(RESET)"; \
		read opt; \
		if [ "$$opt" = "1" ]; then \
			make submenu_compile; \
		elif [ "$$opt" = "2" ]; then \
			make submenu_std; \
		elif [ "$$opt" = "3" ]; then \
			make submenu_bonus; \
		elif [ "$$opt" = "0" ]; then \
			echo "\n$(CYAN)Saliendo sin realizar acciones...$(RESET)"; \
			exit 0; \
		else \
			echo "\n$(YELLOW)Opción no válida. Inténtalo de nuevo.$(RESET)"; \
			sleep 1; \
		fi; \
	done

# ⚙️ SUBMENÚ 1: COMPILACIONES Y LIMPIEZA
submenu_compile:
	@while true; do \
		clear; \
		echo "$(BOLD)$(GREEN)╔═════════════════════════════════════════╗$(RESET)"; \
		echo "$(BOLD)$(GREEN)║       ⚙️  COMPILACIONES Y LIMPIEZA       ║$(RESET)"; \
		echo "$(BOLD)$(GREEN)╚═════════════════════════════════════════╝$(RESET)"; \
		echo "  1) Compilar solo librería estándar (make)"; \
		echo "  2) Compilar todos los BONUS (Librería + Checker)"; \
		echo "  3) Ejecutar limpieza de objetos (clean)"; \
		echo "  4) Ejecutar limpieza total (fclean)"; \
		echo "  5) Recompilar todo desde cero (re)"; \
		echo "  0) ⬅️  Volver al menú principal"; \
		echo ""; \
		printf "$(BOLD)Introduce una opción [1-5, o 0]: $(RESET)"; \
		read opt; \
		if [ "$$opt" = "1" ]; then \
			clear; make $(NAME); \
			echo "\n$(GREEN)Librería estándar empaquetada. ¡Buen desarrollo!$(RESET)"; \
			printf "$(YELLOW)Presiona [ENTER] para salir...$(RESET)"; read tmp; \
			pkill -P $$$$ || exit 0; \
		elif [ "$$opt" = "2" ]; then \
			clear; make bonus; \
			echo "\n$(GREEN)¡Todos los bonus generados con éxito!$(RESET)"; \
			printf "$(YELLOW)Presiona [ENTER] para salir...$(RESET)"; read tmp; \
			pkill -P $$$$ || exit 0; \
		elif [ "$$opt" = "3" ]; then \
			clear; make clean; \
			printf "\n$(YELLOW)Presiona [ENTER] para continuar...$(RESET)"; read tmp; \
		elif [ "$$opt" = "4" ]; then \
			clear; make fclean; \
			printf "\n$(YELLOW)Presiona [ENTER] para continuar...$(RESET)"; read tmp; \
		elif [ "$$opt" = "5" ]; then \
			clear; make re; \
			printf "\n$(YELLOW)Presiona [ENTER] para continuar...$(RESET)"; read tmp; \
		elif [ "$$opt" = "0" ]; then \
			exit 0; \
		else \
			echo "\n$(YELLOW)Opción no válida...$(RESET)"; sleep 1; \
		fi; \
	done

# 📂 SUBMENÚ 2: PRUEBAS ESTÁNDAR
submenu_std:
	@while true; do \
		clear; \
		echo "$(BOLD)$(CYAN)╔═════════════════════════════════════════╗$(RESET)"; \
		echo "$(BOLD)$(CYAN)║        📂 PRUEBAS ESTÁNDAR (MÓDULOS)     ║$(RESET)"; \
		echo "$(BOLD)$(CYAN)╚═════════════════════════════════════════╝$(RESET)"; \
		echo "  1) Probar LIBFT base"; \
		echo "  2) Probar FT_PRINTF estándar"; \
		echo "  3) Probar GET_NEXT_LINE estándar"; \
		echo "  0) ⬅️  Volver al menú principal"; \
		echo ""; \
		printf "$(BOLD)Introduce una opción [1-3, o 0]: $(RESET)"; \
		read opt; \
		if [ "$$opt" = "1" ]; then \
			make test_libft; \
			printf "\n$(YELLOW)Presiona [ENTER] para continuar...$(RESET)"; read tmp; \
		elif [ "$$opt" = "2" ]; then \
			make test_printf; \
			printf "\n$(YELLOW)Presiona [ENTER] para continuar...$(RESET)"; read tmp; \
		elif [ "$$opt" = "3" ]; then \
			make test_gnl; \
			printf "\n$(YELLOW)Presiona [ENTER] para continuar...$(RESET)"; read tmp; \
		elif [ "$$opt" = "0" ]; then \
			exit 0; \
		else \
			echo "\n$(YELLOW)Opción no válida...$(RESET)"; sleep 1; \
		fi; \
	done

# 🎖️ SUBMENÚ 3: PRUEBAS BONUS
submenu_bonus:
	@while true; do \
		clear; \
		echo "$(BOLD)$(YELLOW)╔═════════════════════════════════════════╗$(RESET)"; \
		echo "$(BOLD)$(YELLOW)║          🎖️  PRUEBAS MÓDULOS BONUS       ║$(RESET)"; \
		echo "$(BOLD)$(YELLOW)╚═════════════════════════════════════════╝$(RESET)"; \
		echo "  1) Probar FT_PRINTF BONUS"; \
		echo "  2) Probar GET_NEXT_LINE BONUS"; \
		echo "  0) ⬅️  Volver al menú principal"; \
		echo ""; \
		printf "$(BOLD)Introduce una opción [1-2, o 0]: $(RESET)"; \
		read opt; \
		if [ "$$opt" = "1" ]; then \
			make test_printf_bonus; \
			printf "\n$(YELLOW)Presiona [ENTER] para continuar...$(RESET)"; read tmp; \
		elif [ "$$opt" = "2" ]; then \
			make test_gnl_bonus; \
			printf "\n$(YELLOW)Presiona [ENTER] para continuar...$(RESET)"; read tmp; \
		elif [ "$$opt" = "0" ]; then \
			exit 0; \
		else \
			echo "\n$(YELLOW)Opción no válida...$(RESET)"; sleep 1; \
		fi; \
	done

# 🧪 Reglas de Tests Individuales
test_libft: $(NAME) main_test.c
	@echo "\n🧪 $(YELLOW)Compilando ejecutable de pruebas para LIBFT...$(RESET)"
	@cc -Wall -Wextra -Werror -D TEST_LIBFT main_test.c $(NAME) -o $(TEST_EXE)
	@./$(TEST_EXE)
	@rm -f $(TEST_EXE)

test_printf: $(NAME) main_test.c
	@echo "\n🧪 $(YELLOW)Compilando ejecutable de pruebas para FT_PRINTF...$(RESET)"
	@cc -Wall -Wextra -Werror -D TEST_PRINTF main_test.c $(NAME) -o $(TEST_EXE)
	@./$(TEST_EXE)
	@rm -f $(TEST_EXE)

test_gnl: $(NAME) main_test.c
	@echo "\n🧪 $(YELLOW)Compilando ejecutable de pruebas para GET_NEXT_LINE...$(RESET)"
	@cc -Wall -Wextra -Werror -D TEST_GNL main_test.c $(NAME) -o $(TEST_EXE)
	@./$(TEST_EXE)
	@rm -f $(TEST_EXE) test_gnl_input.txt

test_printf_bonus: lib_bonus main_test.c
	@echo "\n🧪 $(YELLOW)Compilando ejecutable de pruebas para FT_PRINTF BONUS...$(RESET)"
	@cc -Wall -Wextra -Werror -D TEST_PRINTF_BONUS main_test.c $(NAME) -o $(TEST_EXE)
	@./$(TEST_EXE)
	@rm -f $(TEST_EXE)

test_gnl_bonus: lib_bonus main_test.c
	@echo "\n🧪 $(YELLOW)Compilando ejecutable de pruebas para GET_NEXT_LINE BONUS...$(RESET)"
	@cc -Wall -Wextra -Werror -D TEST_GNL_BONUS main_test.c $(NAME) -o $(TEST_EXE)
	@./$(TEST_EXE)
	@rm -f $(TEST_EXE) test_gnl_bonus_input.txt

# 🔀 Reglas de Push_Swap
push_swap: $(NAME)
	@echo "🧮 $(BOLD)Llamando a la compilación de Push_Swap...$(RESET)"
	@make -C $(PUSH_DIR)

push_bonus: $(NAME)
	@echo "🎯 $(BOLD)Llamando a la compilación de los Bonus de Push_Swap...$(RESET)"
	@make -C $(PUSH_DIR) bonus

clean:
	@make clean -C $(LIBFT_DIR) > /dev/null
	@make clean -C $(PRINTF_DIR) > /dev/null
	@make clean -C $(GNL_DIR) > /dev/null
	@if [ -d "$(PUSH_DIR)" ]; then make clean -C $(PUSH_DIR); fi
	@echo "🧹 $(CYAN)Archivos objeto (.o) de todo el entorno eliminados.$(RESET)"

fclean: clean
	@rm -f $(NAME) $(TEST_EXE) test_gnl_input.txt test_gnl_bonus_input.txt
	@make fclean -C $(LIBFT_DIR) > /dev/null
	@make fclean -C $(PRINTF_DIR) > /dev/null
	@make fclean -C $(GNL_DIR) > /dev/null
	@if [ -d "$(PUSH_DIR)" ]; then make fclean -C $(PUSH_DIR); fi
	@echo "🗑️  $(CYAN)Librerías, binarios y residuos eliminados por completo.$(RESET)"

re: fclean lib

.PHONY: all clean fclean re push_swap push_bonus test_libft test_printf test_gnl test_printf_bonus test_gnl_bonus menu lib lib_bonus bonus submenu_std submenu_bonus submenu_compile

