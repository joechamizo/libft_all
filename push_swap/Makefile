NAME        = push_swap
BONUS_NAME  = checker
CC          = cc
CFLAGS      = -Wall -Wextra -Werror
INCLUDES    = -I.
SRC_DIR     = srcs
OBJ_DIR     = obj

# 📄 Archivos Fuente (Mantenidos exactamente de tu lista)
SRCS        = push_swap.c \
              $(SRC_DIR)/input.c \
              $(SRC_DIR)/parser.c \
              $(SRC_DIR)/split.c \
              $(SRC_DIR)/operations.c \
              $(SRC_DIR)/handlers.c \
              $(SRC_DIR)/router.c \
              $(SRC_DIR)/flags.c \
              $(SRC_DIR)/indexing.c \
              $(SRC_DIR)/strategies.c \
              $(SRC_DIR)/strategies_chunks.c \
              $(SRC_DIR)/strategies_radix.c \
              $(SRC_DIR)/strategies_utils.c \
              $(SRC_DIR)/benchmark.c \
              $(SRC_DIR)/benchmark_utils.c \
              $(SRC_DIR)/memory.c \
              $(SRC_DIR)/utils.c \
              $(SRC_DIR)/string_utils.c

BONUS_SRCS  = checker.c \
              $(SRC_DIR)/input.c \
              $(SRC_DIR)/parser.c \
              $(SRC_DIR)/split.c \
              $(SRC_DIR)/operations.c \
              $(SRC_DIR)/handlers.c \
              $(SRC_DIR)/router.c \
              $(SRC_DIR)/flags.c \
              $(SRC_DIR)/indexing.c \
              $(SRC_DIR)/strategies.c \
              $(SRC_DIR)/strategies_chunks.c \
              $(SRC_DIR)/strategies_radix.c \
              $(SRC_DIR)/strategies_utils.c \
              $(SRC_DIR)/benchmark.c \
              $(SRC_DIR)/benchmark_utils.c \
              $(SRC_DIR)/memory.c \
              $(SRC_DIR)/utils.c \
              $(SRC_DIR)/string_utils.c

# 📦 Mapeo de objetos redirigidos a la carpeta $(OBJ_DIR)/
OBJS        = $(addprefix $(OBJ_DIR)/, $(SRCS:.c=.o))
BONUS_OBJS  = $(addprefix $(OBJ_DIR)/, $(BONUS_SRCS:.c=.o))

# 🎨 Colores y formato ANSI
GREEN       = \033[0;32m
CYAN        = \033[0;36m
RESET       = \033[0m
BOLD        = \033[1m

# 📊 Contadores dinámicos para la barra de progreso
TOTAL_FILES := $(words $(SRCS))
CURR_FILE   := 0

all: $(NAME)

# 🚀 Creación del ejecutable principal
$(NAME): Makefile $(OBJS)
	@$(CC) $(CFLAGS) $(OBJS) -o $(NAME)
	@printf "\n✨ $(GREEN)[▰▰▰▰▰▰▰▰▰▰] 100%%$(RESET) ¡Ejecutable $(BOLD)$(NAME)$(RESET)$(GREEN) creado con éxito!$(RESET)\n"

# 🎯 Creación del ejecutable del Bonus (checker)
bonus: Makefile $(BONUS_OBJS)
	@$(CC) $(CFLAGS) $(BONUS_OBJS) -o $(BONUS_NAME)
	@printf "\n🎯 $(GREEN)[▰▰▰▰▰▰▰▰▰▰] 100%%$(RESET) ¡Bonus $(BOLD)$(BONUS_NAME)$(RESET)$(GREEN) creado con éxito!$(RESET)\n"

# 🛠️ Regla de compilación con creación automática de $(OBJ_DIR) y barra de carga
$(OBJ_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	@$(eval CURR_FILE=$(shell echo $$(($(CURR_FILE)+1))))
	@$(eval PROGRESS=$(shell echo $$(($(CURR_FILE)*100/$(TOTAL_FILES)))))
	@$(eval BAR_FILLED=$(shell echo $$(($(PROGRESS)/10))))
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@
	@printf "🔄 $(GREEN)["
	@@i=0; while [ $$i -lt $(BAR_FILLED) ]; do printf "▰"; i=$$((i+1)); done
	@@i=$(BAR_FILLED); while [ $$i -lt 10 ]; do printf "▱"; i=$$((i+1)); done
	@printf "] %d%%$(RESET) Compilando: %s\r" $(PROGRESS) $<

clean:
	@rm -rf $(OBJ_DIR)
	@echo "🧹 $(CYAN)Archivos objeto de push_swap y carpeta $(OBJ_DIR)/ eliminados.$(RESET)"

fclean: clean
	@rm -f $(NAME) $(BONUS_NAME)
	@echo "🗑️  $(CYAN)Ejecutables eliminados por completo.$(RESET)"

re: fclean all

.PHONY: all clean fclean re bonus
