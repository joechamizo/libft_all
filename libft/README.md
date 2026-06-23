*This project was created as part of the 42 curriculum by joaqumar.*

# libft

## 👤 Project Overview and AI Collaboration

To keep the project understandable, readable, and aligned with the rigorous 42 evaluation process, the development of this custom standard library was structured around algorithmic robustness, strict pointer safety, and optimized heap memory management.

- **Core function architecture:** Designed and implemented a vital set of memory and string manipulation utilities, ensuring behavior identical to the original functions of the `libc`.
- **Advanced structure handling:** Developed an independent module for managing dynamic singly linked lists, guaranteeing the complete absence of memory leaks during complex node operations.
- **Optimization and modularity:** Organized functions into individual source files to ensure a clean compilation of the static library using an automated Makefile system.

---

## 📝 Description

The **libft** project consists of recreating an extensive set of functions from the standard C library (`libc`), as well as other complementary utilities that will serve as the core toolkit for all future projects within the 42 curriculum.

The primary objective is to deeply understand system behavior, pointer arithmetic, dynamic memory allocation, and precise data type manipulation without relying on external third-party dependencies.

---

## 📂 Project Structure

The source code is meticulously organized into three distinct logical and functional sections:

### 1. Libc Functions (Standard Recreation)
Core functions aimed at character verification, string transformations, and raw memory block inspections:
- **Type management:** `ft_isalpha`, `ft_isdigit`, `ft_isalnum`, `ft_isascii`, `ft_isprint`, `ft_toupper`, `ft_tolower`.
- **String management:** `ft_strlen`, `ft_strchr`, `ft_strrchr`, `ft_strncmp`, `ft_strnstr`, `ft_strlcpy`, `ft_strlcat`, `ft_atoi`.
- **Memory management:** `ft_memset`, `ft_bzero`, `ft_memcpy`, `ft_memmove`, `ft_memchr`, `ft_memcmp`, `ft_calloc`, `ft_strdup`.

### 2. Additional Functions (Advanced Utilities)
Complementary functions not present in the original `libc`, heavily focused on safe string creation, trimming, and formatting:
- `ft_substr`: Secure extraction of specific string segments.
- `ft_strjoin`: Dynamic string concatenation with exact heap memory reservations.
- `ft_strtrim`: Selective trimming of specified prefix and suffix character sets from strings.
- `ft_split`: Tokenization of strings into separate two-dimensional arrays using specified delimiters.
- `ft_itoa`: Transformation of integer values into ascii numerical string formats.
- `ft_strmapi` & `ft_striteri`: Iterative function mapping over individual character addresses in strings.
- **File descriptor writing:** `ft_putchar_fd`, `ft_putstr_fd`, `ft_putendl_fd`, `ft_putnbr_fd`.

### 3. Bonus Functions (Linked Lists)
A dedicated abstraction module designed to handle dynamic data containers via a custom node framework (`t_list`):
- `ft_lstnew`, `ft_lstadd_front`, `ft_lstsize`, `ft_lstlast`, `ft_lstadd_back`, `ft_lstdelone`, `ft_lstclear`, `ft_lstiter`, `ft_lstmap`.

---

## 📐 Technical Decisions and Algorithms

The library was engineered following defensive programming principles, prioritizing data stream stability over null parameters or out-of-bounds arguments.

### 💾 Memory Management and Generic Pointers (`void *`)
For raw byte operations and memory comparisons (`ft_memcpy`, `ft_memmove`, etc.), internal tracking is achieved by casting variables into `unsigned char *`.
- **Justification:** Generic pointers (`void *`) lack a defined data size, preventing direct address arithmetic. Casting them specifically to `unsigned char *` guarantees exact byte-by-byte inspection and manipulation paths regardless of hardware architecture.

### ⚡ Safe String Copying and Overlap Protection
Inside the `ft_memmove` execution path, the algorithm dynamically checks whether the memory addresses of the source (`src`) and destination (`dest`) parameters overlap.
- **Justification:** Unlike `ft_memcpy` (which assumes completely separate memory areas), `ft_memmove` prevents data corruption by adjusting copy direction: it processes bytes forward if `dest < src`, and backward if `dest > src`, safely preserving intermediate values.

### 🎯 Heap Allocation Robustness
Every utility function responsible for reserving memory space on the heap (`ft_calloc`, `ft_strdup`, `ft_split`, etc.) contains immediate post-allocation safeguards.
- **Justification:** If a `malloc` call fails due to system exhaustion, it yields a `NULL` pointer. Dereferencing this pointer triggers a fatal Segmentation Fault. The code systematically validates each allocation, cleanly aborting execution paths if the operating system runs out of resources.

---

## 🧠 Defense Guide and Edge Cases

To smoothly pass rigorous automated validation scripts (such as Francinette or libft-testers), native defenses were implemented against edge cases:

- **Interleaved Spacing in `ft_atoi`:** Correctly strips any leading whitespace characters (`\t`, `\n`, `\v`, `\f`, `\r`, ` `), parses a single optional mathematical sign character (`+` or `-`), and extracts numerical segments smoothly.
- **Cascading Garbage Collection in `ft_split`:** If memory allocation fails midway (e.g., at the 15th word of a massive string array), the program does not simply leak memory. It triggers an automated reverse loop that cleanly frees all 14 previously assigned string tokens before releasing the main double-pointer anchor container, ensuring zero lingering `leaks`.
- **The `INT_MIN` Boundary Case in `ft_itoa`:** The value `-2147483648` cannot be transformed by simply multiplying by `-1` because its positive absolute value exceeds standard signed boundaries (`INT_MAX` is `2147483647`). This case is handled in isolation or using expanded registers to safeguard against integer overflow vulnerabilities.

---

## 🛠️ Usage and Compilation

### Requirements
- `cc`, `clang`, or `gcc` compiler
- `make` utility
- Unix-based environment (Linux, macOS)

### Compilation

To generate the standard static library binary file (`libft.a`), run the following command at the root directory:
```bash
make
```

To compile the library expanding its structures to include the linked list handling tools (Bonus Module):
```bash
make bonus
```

The Makefile features the standard workspace maintenance paths required by the evaluation sheet: `all`, `clean`, `fclean`, and `re`.

### Linking and Project Integration

To reference `libft` inside any of your subsequent software modules, include its header mapping in your files and link the target `.a` binary payload:

```c
#include "libft.h"

int main(void)
{
    char *str = ft_strdup("Successful evaluation at 42");
    ft_putendl_fd(str, 1);
    free(str);
    return (0);
}
```

```bash
gcc main.c libft.a -o testing_program
./testing_program
```

---

## 📚 Resources and References

### References
- Linux Programmer's Manual (Section 3): Behavioral rules for standard `libc` features.
- Official 42 Norminette guideline books.
- POSIX standards for system memory configurations and dynamic structure handling.

### AI Usage Statement
Generative artificial intelligence tools were strictly used as architectural structure and formatting support aids during the workflow for:
- **Architectural Layouts:** Conceptualizing automated Makefile hierarchies and streamlining object dependency tracking.
- **Memory Safety Enhancements:** Auditing the deep cleanup recursive structures inside the `ft_split` utility array to prevent edge-case memory leaks.
- **Documentation Layouts:** Drafting, translating, and styling this unified README.md structural file.

The entire source implementation was manually validated, compiled, refactored, and audited against leak check tools, guaranteeing 100% compliance with the 42 Norminette and total memory leak immunity.

---

## ⚠️ Disclaimer of Liability

**THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. USE AT YOUR OWN RISK.**
