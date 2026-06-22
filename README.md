# 📚 Unified Master Library - 42 Barcelona - By joaqumar

This project centralizes the compilation of an extended **Libft** (which includes `ft_printf` and `get_next_line`) along with automation support for the **Push_Swap** project. It features a powerful, menu-driven interactive `Makefile` utilizing ANSI escape sequences and animated green progress bars to streamline compilation, cleanup, and strict testing for 42 evaluations.

---

## 📁 Repository Structure

The repository maintains a clean, flat modular architecture at its root. Each submodule preserves its logical independence to prevent filename collisions or duplicate objects, and contains its own specific documentation:

```text
├── 📁 libft/             # Base functions of the standard Libft (Contains its own README.md)
├── 📁 ft_printf/         # Custom text formatter (Standard & Bonus) (Contains its own README.md)
├── 📁 get_next_line/     # Line-by-line file reader (Standard & Bonus) (Contains its own README.md)
├── 📁 push_swap/         # Stack sorting algorithm folder (Contains its own README.md)
├── Makefile              # Unified interactive Master Makefile
├── main_test.c           # Comprehensive testing suite for the entire library
└── README.md             # Global repository documentation
```

> 💡 **Note:** For deep implementation details, prototypes, and specific algorithms for each sub-project, please refer to the local `README.md` file located inside each module's directory.

---

## 🛠️ Interactive Control Panel

To simplify environment management, the main `Makefile` launches an interactive visual terminal panel by default using native Bash commands.

To deploy the control panel, run the following command at the root directory:
```bash
make
```

### 📑 Navigation Tree and Menus

#### 1. Main Menu
Upon startup, a welcome interface will display the following numbered workspace routes:
* `1) ⚙️  Compilation and Cleanup Menu`
* `2) 📂 Run Standard Tests (All 3 Projects)`
* `3) 🎖️  Run BONUS Version Tests`
* `0) ❌ Cancel and exit`

#### 2. Submenu 1: Compilation and Cleanup (`1`)
Generates production binaries directly without running test scripts:
* `1) Compile standard library only (make)` -> Generates the traditional `libft.a`.
* `2) Compile all BONUS modules (Library + Checker)` -> Builds `ft_printf` bonus, `gnl` bonus, and the `checker` executable.
* `3) Run object file cleanup (clean)` -> Silently removes `.o` files from all directories.
* `4) Run total cleanup (fclean)` -> Removes `.o` objects, `.a` archive libraries, and temporary executables.
* `5) Recompile the entire workspace (re)` -> Forces a full `fclean` + `make` cycle.
* `0) ⬅️  Return to main menu`

#### 3. Submenu 2: Standard Tests (`2`)
Compiles and triggers specific blocks inside `main_test.c` to validate standard functions:
* `1) Test base LIBFT`
* `2) Test standard FT_PRINTF`
* `3) Test standard GET_NEXT_LINE`
* `0) ⬅️  Return to main menu`

#### 4. Submenu 3: Bonus Tests (`3`)
Compiles bonus dependencies and executes corresponding stress tests:
* `1) Test FT_PRINTF BONUS` -> Validates combined flag management (`#`, `+`, ` `).
* `2) Test GET_NEXT_LINE BONUS` -> Validates concurrent, interleaved reading from multiple FDs in parallel.
* `0) ⬅️  Return to main menu`

---

## ⚙️ Direct Terminal Commands

If you wish to bypass the interactive visual panel to automate compilation scripts or integrate the workspace with automated evaluation checkers (*moulinette*), you can call these rules directly from the shell:

```bash
make lib           # Silently compiles the standard version of the unified library
make bonus         # Compiles all bonus modules along with the push_swap 'checker' executable
make clean         # Deletes all object files (.o) across the four subdirectories
make fclean        # Deletes all objects, compiled '.a' files, and residual executables
make re            # Recompiles the entire repository from scratch
```

---

## ⚠️ Engineering Considerations & Anti-Relink Controls

1. **Strict Dependency Tracking**: The master `Makefile` actively tracks any structural modifications within the main configuration or header files (`libft.h`, `ft_printf.h`, `get_next_line.h`). If a prototype changes, the system intelligently updates. If no files are modified, **nothing recompiles**, strictly respecting the 42 school evaluation guidelines.
2. **Flat Modularity**: Keeping `ft_printf` and `get_next_line` files isolated from the `libft` core ensures that no helper function redefinitions (such as duplicate `ft_putchar` or `ft_strlen` files) corrupt the library archive indexing during the final `libft.a` packaging.
3. **Pausas and Screen Clearing**: Submenus clean up the graphical buffer with the `clear` instruction before rendering. Additionally, every single software test or standalone compilation rule freezes upon completion with a prompt (`Press [ENTER] to continue`), preventing compilation warnings or test results from slipping by unnoticed before the screen changes.

---

## 🚀 Reusing This Library in Future Projects

Since `libft`, `ft_printf`, and `get_next_line` are consolidated into a single `libft.a` file, linking this unified master library into any future 42 school project (such as *minitalk*, *so_long*, *fract-ol*, or *cub3d*) is extremely simple.

### 1. Include the header in your `.c` source files
To make your new project recognize all the classic libft string functions, the text formatter, and the file reader, add this single include at the top of your source files:
```c
#include "libft/libft.h"
```

### 2. Recommended directory tree for your new repository
When starting a new project, clone or copy this master library folder as a `libft/` subdirectory inside your new repository's root:
```text
📁 your_new_project/
├── 📁 libft/               <-- This unified master library
├── 📁 srcs/                <-- Your new project's .c source files
├── 📁 inc/                 <-- Your new project's .h header files
└── Makefile                <-- Your new project's Makefile
```

### 3. Makefile configuration for your new project
To automate the compilation of the library and link it properly without breaking the 42 relink rule, structure your new project's `Makefile` using this explicit dependency architecture:

```makefile
NAME        = new_program

# 📁 Directories and Paths
LIBFT_DIR   = libft/
LIBFT       = \$(LIBFT_DIR)libft.a

# ⚙️ Compilation and Linking Flags
CC          = cc
CFLAGS      = -Wall -Wextra -Werror -I. -I\$(LIBFT_DIR)

# 📄 New Project Source Files
SRCS        = srcs/main.c srcs/utils.c
OBJS        = \$(SRCS:.c=.o)

all: \$(NAME)

# 1. First trigger the master library Makefile compiling only what is necessary
\$(LIBFT):
	@make -C \$(LIBFT_DIR) lib

# 2. Link your program directly using the generated compiled .a archive
\$(NAME): (LIBFT) (OBJS)
	@\$(CC) (CFLAGS) (OBJS) (LIBFT) -o (NAME)
	@echo "¡\$(NAME) compiled and linked with the Master Library!"

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

## ⚖️ Academic Disclaimer

This repository has been created for purely academic purposes as part of my personal learning journey through the **42 network** curriculum.

* **Use at your own risk:** I do not take any responsibility for how the code in this repository is used, nor for any consequences arising from its duplication, modification, or reuse in your own project submissions.
* **42 Plagiarism Policy:** 42 students are heavily reminded that plagiarism or direct code copying without fully understanding its inner workings violates the school rules and can be severely penalized by both automated testing systems (*Moulinette*) and human peer-evaluators.
* **Purpose:** This codebase is shared with the sole purpose of serving as an engineering reference, technical guide, or inspiration for building advanced custom Makefiles and automated interactive test suites.

