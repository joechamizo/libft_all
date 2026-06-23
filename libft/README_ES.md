Este proyecto ha sido creado como parte del currículo de 42 por joaqumar_

# libft

## 👤 Descripción General del Proyecto y Colaboración con IA

Para mantener el proyecto comprensible, legible y alineado con el riguroso proceso de evaluación de 42, el desarrollo de esta librería estándar personalizada se estructuró en torno a la robustez algorítmica, la seguridad estricta de punteros y una gestión óptima de la memoria en el heap.

- **Arquitectura de funciones base:** Diseñado e implementado un conjunto de funciones esenciales de manipulación de memoria y strings, asegurando un comportamiento idéntico al de las funciones originales de la `libc`.
- **Manejo avanzado de estructuras:** Desarrollo de un módulo independiente para la gestión y manipulación de listas enlazadas dinámicas, garantizando la ausencia de fugas de memoria durante operaciones complejas.
- **Optimización y modularidad:** Organización de las funciones en archivos independientes para garantizar la compilación limpia de la librería estática mediante un Makefile automatizado.

---

## 📝 Descripción

El proyecto **libft** consiste en recrear un conjunto de funciones de la librería estándar de C (`libc`), así como otras utilidades adicionales que servirán como caja de herramientas base para todos los proyectos futuros dentro del currículo de 42.

El objetivo principal es comprender a fondo el funcionamiento interno del comportamiento del sistema, la aritmética de punteros, la asignación dinámica de memoria y la manipulación precisa de tipos de datos sin depender de código externo.

---

## 📂 Estructura del Proyecto

El código está meticulosamente organizado en tres secciones lógicas y funcionales bien diferenciadas:

### 1. Funciones de la Libc (Recreación estándar)
Funciones base destinadas a la manipulación de caracteres, strings y bloques de memoria cruda:
- Gestión de tipos: `ft_isalpha`, `ft_isdigit`, `ft_isalnum`, `ft_isascii`, `ft_isprint`, `ft_toupper`, `ft_tolower`.
- Gestión de strings: `ft_strlen`, `ft_strchr`, `ft_strrchr`, `ft_strncmp`, `ft_strnstr`, `ft_strlcpy`, `ft_strlcat`, `ft_atoi`.
- Gestión de memoria: `ft_memset`, `ft_bzero`, `ft_memcpy`, `ft_memmove`, `ft_memchr`, `ft_memcmp`, `ft_calloc`, `ft_strdup`.

### 2. Funciones Adicionales (Utilidades avanzadas)
Funciones complementarias no presentes en la `libc` original, centradas en la generación y formateo de datos:
- `ft_substr`: Extracción segura de fragmentos de strings.
- `ft_strjoin`: Concatenación dinámica de strings con reserva exacta de memoria.
- `ft_strtrim`: Eliminación selectiva de caracteres al inicio y final de una string.
- `ft_split`: Fragmentación de strings en arrays bidimensionales utilizando caracteres delimitadores.
- `ft_itoa`: Conversión de valores enteros a cadenas numéricas ascii.
- `ft_strmapi` y `ft_striteri`: Aplicación de funciones iterativas a cada carácter de una string.
- Impresión en FD: `ft_putchar_fd`, `ft_putstr_fd`, `ft_putendl_fd`, `ft_putnbr_fd`.

### 3. Funciones de Bonus (Listas Enlazadas)
Módulo dedicado a la gestión y abstracción de datos dinámicos mediante una estructura de nodos (`t_list`):
- `ft_lstnew`, `ft_lstadd_front`, `ft_lstsize`, `ft_lstlast`, `ft_lstadd_back`, `ft_lstdelone`, `ft_lstclear`, `ft_lstiter`, `ft_lstmap`.

---

## 📐 Decisiones Técnicas y Algorítmicas

La librería se construyó bajo un enfoque defensivo, priorizando la estabilidad del sistema frente a valores nulos o entradas fuera de rango.

### 💾 Gestión de Memoria y Punteros Genéricos (`void *`)
Para las funciones de copia e inspección de memoria (`ft_memcpy`, `ft_memmove`, etc.), se utiliza aritmética de punteros mediante transformaciones a `unsigned char *`.
- **Justificación:** Los punteros genéricos `void *` no tienen un tamaño definido, por lo que no permiten la aritmética directa. Al castearlos a `unsigned char *`, se asegura que las evaluaciones y transferencias de datos se realicen byte a byte de forma exacta en cualquier arquitectura de hardware.

### ⚡ Algoritmo Seguros de Strings y Protección de Solapamientos
En la función `ft_memmove`, el código detecta de forma predictiva si la dirección de memoria de origen (src) y la de destino (dest) se solapan.
- **Justificación:** A diferencia de `ft_memcpy` (que asume que las zonas de memoria están separadas), `ft_memmove` garantiza la integridad de los datos realizando la copia de adelante hacia atrás si `dest < src`, o de atrás hacia adelante si `dest > src`, evitando la corrupción de bytes intermedios.

### 🎯 Robustez en la Asignación de Memoria
Todas las funciones que reservan espacio en el heap (`ft_calloc`, `ft_strdup`, `ft_split`, etc.) cuentan con protecciones inmediatas post-asignación.
- **Justificación:** Si un `malloc` falla debido a la falta de memoria del sistema, el puntero devuelto es `NULL`. Acceder a este puntero provocaría un Segmentation Fault. El código valida sistemáticamente cada asignación, abortando la función de manera limpia y segura si el sistema operativo se queda sin recursos.

---

## 🧠 Guía de Defensa y Casos Borde (Edge Cases)

Para superar las pruebas más exhaustivas (como las suites Francinette o libft-testers), se implementaron blindajes contra escenarios extremos:

- **Aritmética Intercalada en `ft_atoi`:** Soporta cadenas con múltiples espacios en blanco iniciales de cualquier tipo (`\t`, `\n`, `\v`, `\f`, `\r`, ` `), seguidos por un único signo opcional (`+` o `-`), abstrayendo el valor entero de forma robusta.
- **Limpieza en Cascada en `ft_split`:** Si la reserva de memoria falla para el nodo número 15 de un array bidimensional, el algoritmo no se limita a abortar; ejecuta un bucle invertido automático para liberar los 14 nodos reservados previamente antes de liberar el contenedor principal, garantizando cero fugas de memoria (`leaks`).
- **El caso `INT_MIN` en `ft_itoa`:** El valor `-2147483648` no puede convertirse simplemente multiplicando por `-1` debido al desbordamiento positivo de los enteros estándar (`INT_MAX` es `2147483647`). Se gestiona de forma aislada o mediante tipos de datos extendidos para evitar fallos de desbordamiento de enteros.

---

## 🛠️ Uso y Compilación

### Requisitos
- `cc`, `clang` o `gcc`
- Herramienta de automatización `make`
- Entorno basado en Unix (Linux, macOS)

### Compilación de la Librería

Para generar el archivo de librería estática (`libft.a`), ejecuta el comando en la raíz del proyecto:
```bash
make
```

Para compilar la librería incluyendo las utilidades de listas enlazadas (Módulo Bonus):
```bash
make bonus
```

El Makefile incluye las reglas de mantenimiento obligatorias: `all`, `clean`, `fclean` y `re`.

### Vinculación e Integración

Para utilizar tu `libft` en cualquier proyecto subsiguiente, incluye su archivo de cabecera en tus fuentes y enlaza el binario estático resultante:

```c
#include "libft.h"

int main(void)
{
    char *str = ft_strdup("Evaluación exitosa en 42");
    ft_putendl_fd(str, 1);
    free(str);
    return (0);
}
```

```bash
gcc main.c libft.a -o ejecutable_prueba
./ejecutable_prueba
```

---

## 📚 Recursos y Referencias

### Referencias Bibliográficas
- Manual de Linux (Sección 3): Referencias de comportamiento de la librería estándar `libc`.
- Directrices oficiales de la Norminette de 42.
- Estándar POSIX para la gestión y asignación de estructuras dinámicas de datos.

### Declaración de Uso de IA
La asistencia de inteligencia artificial generativa se utilizó estrictamente como una herramienta de soporte y optimización estructural durante el flujo de trabajo:
- **Diseño Arquitectónico:** Conceptualización de la lógica del Makefile automatizado y optimización de las dependencias de los archivos objeto.
- **Optimización de Memoria:** Revisión de las rutinas de liberación inversa de memoria dentro del algoritmo `ft_split` para evitar fugas latentes.
- **Documentación:** Generación, traducción y formateo estructural de este archivo README.md.

Toda la implementación fue auditada, adaptada, compilada y aprobada manualmente mediante la suite de herramientas oficiales, garantizando el cumplimiento total de la Norminette de 42 y la ausencia absoluta de fugas de memoria.

---

## ⚖️ Descargo de Responsabilidad (Disclaimer)

Este repositorio ha sido creado con fines puramente académicos y como parte de mi proceso de aprendizaje en el plan de estudios de **42**.

* **Uso bajo tu propio riesgo:** No me hago responsable del uso que se le dé al código de este repositorio, ni de las consecuencias derivadas de su copia, modificación o reutilización en tus propias entregas.
* **Política de copia de 42 (Plagio):** Se recuerda a los estudiantes de 42 que el plagio o la copia directa de código sin comprender su funcionamiento infringe las normas de la escuela y puede ser penalizado de forma severa por los sistemas de evaluación automática o manual (*Moulinette* / Evaluadores).
* **Propósito:** El código se comparte con el único objetivo de servir como referencia, consulta técnica o inspiración para resolver arquitecturas de Makefiles complejos y automatización de tests interactivos.
