# 📚 Librería Maestra Unificada - 42 Barcelona - Por joaqumar

Este proyecto centraliza la compilación de la **Libft** ampliada (que incluye `ft_printf` y `get_next_line`) junto con el soporte de automatización para el proyecto **Push_Swap**. Cuenta con un potente `Makefile` interactivo basado en menús que incluye barras de progreso animadas e iconos visuales para facilitar el desarrollo, la limpieza y el testeo estricto de cara a las evaluaciones de 42.

---

## 📁 Estructura del Repositorio

El repositorio mantiene una arquitectura modular y plana en la raíz. Cada submódulo conserva su independencia lógica para evitar colisiones de archivos u objetos duplicados, y contiene su propia documentación específica:

```text
├── 📁 libft/             # Funciones base de la Libft estándar (Contiene su propio README.md)
├── 📁 ft_printf/         # Formateador de texto personalizado (Contiene su propio README.md)
├── 📁 get_next_line/     # Lector de archivos línea a línea (Contiene su propio README.md)
├── 📁 push_swap/         # Algoritmo de ordenación de stacks (Contiene su propio README.md)
├── Makefile              # Makefile Maestro unificado interactivo
├── main_test.c           # Batería de pruebas exhaustiva para toda la librería
└── README.md             # Documentación global del proyecto
```

> 💡 **Nota:** Para conocer los detalles internos de implementación, prototipos y algoritmos específicos de cada proyecto, consulta el archivo `README.md` ubicado dentro del directorio correspondiente de cada librería.

---

## 🛠️ Panel de Control Interactivo

Para facilitar la interacción con todo el entorno, el `Makefile` principal inicia por defecto un panel visual en la terminal usando secuencias de escape ANSI y comandos nativos Bash.

Para desplegar el panel, ejecuta en la raíz:
```bash
make
```

### 📑 Árbol de Navegación y Menús

#### 1. Menú Principal
Al arrancar, verás la pantalla de bienvenida con las siguientes rutas de acceso numeradas:
* `1) ⚙️  Menú de Compilaciones y Limpieza`
* `2) 📂 Ejecutar Pruebas Estándar (Los 3 Proyectos)`
* `3) 🎖️  Ejecutar Pruebas de Versiones BONUS`
* `0) ❌ Cancelar y salir`

#### 2. Submenú 1: Compilaciones y Limpieza (`1`)
Permite generar los binarios de producción sin necesidad de ejecutar los scripts de prueba:
* `1) Compilar solo librería estándar (make)` -> Genera `libft.a` tradicional.
* `2) Compilar todos los BONUS (Librería + Checker)` -> Construye `ft_printf` bonus, `gnl` bonus y el ejecutable `checker`.
* `3) Ejecutar limpieza de objetos (clean)` -> Borra archivos `.o` de todo el entorno de forma silenciosa.
* `4) Ejecutar limpieza total (fclean)` -> Borra `.o`, librerías `.a` y ejecutables temporales.
* `5) Recompilar todo desde cero (re)` -> Fuerza un ciclo `fclean` + `make`.
* `0) ⬅️  Volver al menú principal`

#### 3. Submenú 2: Pruebas Estándar (`2`)
Compila y lanza de manera controlada los tests del archivo `main_test.c` aislando las funciones estándar:
* `1) Probar LIBFT base`
* `2) Probar FT_PRINTF estándar`
* `3) Probar GET_NEXT_LINE estándar`
* `0) ⬅️  Volver al menú principal`

#### 4. Submenú 3: Pruebas Bonus (`3`)
Compila las dependencias de los bonus y ejecuta las pruebas de estrés correspondientes:
* `1) Probar FT_PRINTF BONUS` -> Evalúa la gestión de flags combinadas (`#`, `+`, ` `).
* `2) Probar GET_NEXT_LINE BONUS` -> Evalúa la lectura entrelazada y concurrente de múltiples FDs en paralelo.
* `0) ⬅️  Volver al menú principal`

---

## ⚙️ Comandos Directos por Terminal

Si deseas omitir el panel visual e interactivo para automatizar scripts de compilación en segundo plano o integrarlos en correctores (*moulinette*), puedes invocar estas reglas directamente:

```bash
make lib           # Compila silenciosamente la versión estándar de la librería
make bonus         # Compila las versiones bonus junto al ejecutable 'checker'
make clean         # Borra todos los archivos objeto (.o) de los cuatro directorios
make fclean        # Borra todos los objetos, archivos '.a' y ejecutables residuales
make re            # Recompilar todo el repositorio desde cero
```

---

## ⚠️ Consideraciones de Ingeniería y Control Anti-Recompilación

1. **Gestión de Dependencias Estricta**: El `Makefile` maestro rastrea en tiempo real cualquier cambio estructural en el archivo de configuración o en los ficheros de cabecera (`libft.h`, `ft_printf.h`, `get_next_line.h`). Si modificas un prototipo, el sistema se actualizará de forma inteligente. Si no hay cambios, **no recompilará nada**, cumpliendo de forma estricta las normas de evaluación de la escuela 42.
2. **Modularidad Plana**: Al mantener los componentes de `ft_printf` y `get_next_line` en carpetas desacopladas del núcleo de la `libft`, se garantiza que no existan redefiniciones de funciones (como `ft_putchar` o `ft_strlen` repetidas) que invaliden el linkado o empaquetado del archivo `libft.a`.
3. **Pausas y Limpieza de Terminal**: Los submenús limpian el búfer gráfico con la instrucción `clear` antes de renderizarse. Adicionalmente, cada prueba de software o compilación pura se congela al terminar con un prompt (`Presiona [ENTER] para continuar`), impidiendo que los resultados de tus pruebas o errores de compilación pasen desapercibidos antes de cambiar de pantalla.

---

## 🚀 Cómo Reutilizar esta Librería en Proyectos Futuros

Al tener unificados `libft`, `ft_printf` y `get_next_line` en un único archivo `libft.a`, el proceso para enlazarlo en cualquier proyecto nuevo de la escuela (como *minitalk*, *so_long*, *fract-ol* o *cub3d*) es sumamente sencillo.

### 1. Incluye la cabecera en tus archivos `.c`
Para que tu nuevo código reconozca todas las funciones clásicas de la libft, el formateador y el lector de archivos, solo tienes que añadir esta línea al principio de tus fuentes:
```c
#include "libft/libft.h"
```

### 2. Estructura de carpetas recomendada en tu nuevo proyecto
Cuando empieces un proyecto nuevo, clona o copia esta librería maestra en una carpeta llamada `libft/` en la raíz de tu nuevo repositorio:
```text
📁 tu_nuevo_proyecto/
├── 📁 libft/               <-- Esta librería maestra unificada
├── 📁 srcs/                <-- Los .c de tu nuevo proyecto
├── 📁 inc/                 <-- Los .h de tu nuevo proyecto
└── Makefile                <-- El Makefile de tu nuevo proyecto
```

### 3. Configuración del Makefile de tu nuevo proyecto
Para automatizar la compilación de la librería y enlazarla de forma correcta sin que rompa la norma de 42, debes estructurar el `Makefile` de tu nuevo proyecto siguiendo este esquema de dependencias:

```makefile
NAME        = nuevo_programa

# 📁 Directorios y Rutas
LIBFT_DIR   = libft/
LIBFT       = \$(LIBFT_DIR)libft.a

# ⚙️ Compilación y Flags de Enlace (Linking)
CC          = cc
CFLAGS      = -Wall -Wextra -Werror -I. -I\$(LIBFT_DIR)

# 📄 Archivos de tu nuevo proyecto
SRCS        = srcs/main.c srcs/utils.c
OBJS        = \$(SRCS:.c=.o)

all: \$(NAME)

# 1. Llama primero al Makefile de la libft para compilar solo lo necesario
\$(LIBFT):
	@make -C \$(LIBFT_DIR) lib

# 2. Enlaza tu programa con el archivo .a generado
\$(NAME): (LIBFT) (OBJS)
	@\$(CC) (CFLAGS) (OBJS) (LIBFT) -o (NAME)
	@echo "¡\$(NAME) compilado y enlazado con la Librería Maestra!"

clean:
	@make clean -C \$(LIBFT_DIR)
	@rm -f \$(OBJS)

fclean: clean
	@make fclean -C \$(LIBFT_DIR)
	@rm -f \$(NAME)

re: fclean all

.PHONY: all clean fclean re
```

---

## ⚖️ Descargo de Responsabilidad (Disclaimer)

Este repositorio ha sido creado con fines puramente académicos y como parte de mi proceso de aprendizaje en el plan de estudios de **42**.

* **Uso bajo tu propio riesgo:** No me hago responsable del uso que se le dé al código de este repositorio, ni de las consecuencias derivadas de su copia, modificación o reutilización en tus propias entregas.
* **Política de copia de 42 (Plagio):** Se recuerda a los estudiantes de 42 que el plagio o la copia directa de código sin comprender su funcionamiento infringe las normas de la escuela y puede ser penalizado de forma severa por los sistemas de evaluación automática o manual (*Moulinette* / Evaluadores).
* **Propósito:** El código se comparte con el único objetivo de servir como referencia, consulta técnica o inspiración para resolver arquitecturas de Makefiles complejos y automatización de tests interactivos.

