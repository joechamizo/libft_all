# ft_printf

## 👤 General Project Description and AI Collaboration

To keep the project understandable, maintainable, and aligned with the 42 evaluation process, development was structured around efficient variable argument handling, a unified state control system, and an optimized data flushing flow.

- **Unified State Architecture:** Designed and implemented a control mechanism based on a single structure (`t_printf`) to encapsulate the buffer and flag states, removing the need for global variables.
- **Output Optimization:** Implemented a buffering system to mitigate the impact of system calls, accumulating characters in RAM before performing write operations.
- **Advanced Modularity:** Structured the control flow into specific atomic modules to strictly comply with the maximum restriction of 5 functions per file required by the 42 Norm.

---

## 📝 Description

The **ft_printf** project consists of recreating the famous `printf` function from the standard C library (`libc`). The main goal is to learn how to handle variadic functions and to dive deeper into efficient data flow management through the use of an output buffer.

This implementation accurately mimics the original behavior of `printf`, returning the total number of characters printed and managing various types of conversions and format flags under the strict restrictions of the 42 Norm.

---

## 📂 Project Structure

To comply with the maximum restriction of 5 functions per file, the code is meticulously organized as follows:

- **🚀 ft_printf.c:** Main entry point, buffer lifecycle management, and main format parsing loop.
- **🔍 ft_parser.c:** Syntactic analysis and capture of flags (`-`, `0`, `.`, `#`, ` `, `+`), field width, and precision calculation.
- **🛤️ ft_dispatch.c:** Conversion dispatcher in charge of routing control to the appropriate module according to the specifier.
- **🔢 ft_print_nums.c:** Processing and printing logic for integers (`%d`, `%i`, `%u`) with rigorous sign management.
- **⬢ ft_print_hex.c:** Conversion logic for hexadecimal formats (`%x`, `%X`) and memory addresses/pointers (`%p`).
- **🛠️ ft_utils.c:** Base project tools, numerical length calculation, and arithmetic base management.

---

## 📐 Technical Decisions: Algorithm and Data Structure

The project is designed under a modular paradigm where the control structure directs the data flow through memory buffers before interacting with the operating system.

### 💾 Unified Data Structure: `t_printf`

A unified data structure has been designed to act as the "global state" of the function. It contains the character buffer, the current index, the total count of printed bytes, and all boolean and numerical variables for the flags.

- **Justification:** It allows full and safe access to information through a single pointer passed by reference. This completely eliminates the use of forbidden global variables and facilitates modular communication between the different project files.

### ⚡ Output Algorithm: Active Buffer Management

Instead of printing each character individually using repeated primitive calls, the system uses a static 4096-byte buffer in memory.

- **Justification:** System calls (`write`) are computationally expensive operations due to the context switch between user space and kernel space. Minimizing these calls drastically optimizes the overall performance of the function, accumulating data in RAM and flushing the block only when the buffer is full or the function finishes.

### 🎯 Formatting Algorithm: Hierarchical Pre-calculation

To correctly resolve the complex combination of bonus flags, a three-step predictive algorithm is used:

1. **Capture:** The parser extracts the numerical values of the field width and precision, and activates the present flags.
2. **Calculation:** The total size that the final text "box" will occupy is mathematically determined (calculating padding spaces, precision zeros, prefixes like `0x`, or `+`/`-` signs alongside the numerical value).
3. **Flushing:** The components are sent to the buffer in a strict and sequential hierarchical order, ensuring that the final format is identical to that of `libc`.

---

## 🧠 Defense Guide and Edge Cases

To pass the most demanding automated tests in the 42 community, the code implements native solutions for critical scenarios:

- **Null Pointer Management (`%s` and `%p` with NULL):** If a `NULL` pointer is passed to a string specifier, it safely prints `(null)` (or variants depending on the operating system). For `%p` pointers, it manages the correct output as `(nil)` or `0x0`.
- **Integer Overflows:** Handling numbers like `LONG_MIN` or `INT_MIN` is done by using higher-capacity data types (`long long` or `unsigned long long`) during intermediate calculations to avoid undefined behavior.
- **Conflicting Flags Prone to Cancellation:** The code features implicit precedence logic. For example, the `-` flag (left alignment) overrides the effect of the `0` flag (zero padding), and the `+` flag (always show sign) takes priority over the ` ` (blank space) flag.

---

## 🛠️ Usage and Compilation

### Requirements
- `cc`, `clang`, or `gcc`
- `make` automation tool
- Unix-based environment (Linux, macOS)

### Library Compilation

To generate the static library file (`libftprintf.a`), execute the base command in the project root:
```bash
make
```
The Makefile includes the mandatory rules required by the subject: `all`, `clean`, `fclean`, and `re`.

### Linking and Integration

To use `ft_printf` in your own C source code, include its header and link the generated `.a` file during the compilation of your final binary:

```c
#include "ft_printf.h"

int main(void)
{
    ft_printf("Hello %s, the number is %+10.5d\n", "World", 42);
    return (0);
}
```

```bash
gcc main.c libftprintf.a -o my_program
./my_program
```

---

## 📚 Resources and References

### Bibliographical References
- Linux Manual: `printf(3)` function reference.
- ISO/IEC 9899 Standard: Official documentation on variadic types and associated macros (`va_list`, `va_start`, `va_arg`, `va_end`).
- System call optimization guidelines in POSIX systems.

### AI Usage Declaration
Generative artificial intelligence assistance was strictly used as a support and architectural optimization tool during the workflow:
- **Architectural Design:** Conceptualization of the unified `t_printf` control structure for modularity between files.
- **Memory Optimization:** Refactoring of the output buffer logic to ensure the minimum amount of calls to `write()`.
- **Documentation:** Generation and structural formatting of the visual schemes in this README.md file.

The entire implementation was manually audited, adapted, compiled, and approved using the official tool suites, ensuring full compliance with the 42 Norminette and the absolute absence of memory leaks.

---

## ⚖️ Academic Disclaimer

This repository has been created for purely academic purposes as part of my personal learning journey through the **42 network** curriculum.

* **Use at your own risk:** I do not take any responsibility for how the code in this repository is used, nor for any consequences arising from its duplication, modification, or reuse in your own project submissions.
* **42 Plagiarism Policy:** 42 students are heavily reminded that plagiarism or direct code copying without fully understanding its inner workings violates the school rules and can be severely penalized by both automated testing systems (*Moulinette*) and human peer-evaluators.
* **Purpose:** This codebase is shared with the sole purpose of serving as an engineering reference, technical guide, or inspiration for building advanced custom Makefiles and automated interactive test suites.
