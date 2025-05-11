#ifndef STRFUNCS_H_
#define STRFUNCS_H_
#include <stdbool.h>

/**
 * @brief Calcula la longitud de una cadena de caracteres.
 * @details
 * Recorre la cadena apuntada por `str` hasta encontrar el carácter nulo '\0',
 * y devuelve la cantidad de caracteres antes de él.
 *
 * @param[in] str Puntero a la cadena de caracteres terminada en '\0'.
 * @return Tamaño de la cadena (cantidad de caracteres, sin contar el '\0').
 */
size_t string_length(const char *str);

/**
 * @brief Crea una nueva cadena excluyendo un carácter específico.
 * @details
 * Recorre la cadena apuntada por `str` y copia todos los caracteres
 * distintos del carácter `c` a una nueva cadena en memoria dinámica.
 * La nueva cadena está terminada en '\0' y debe ser liberada con `free`.
 *
 * @param[in] str Cadena de entrada terminada en '\0'.
 * @param[in] c Carácter que se desea eliminar de la cadena.
 * @return Puntero a una nueva cadena sin las ocurrencias de `c`.
 *         Si no hay caracteres válidos, retorna una cadena vacía ("").
 */
char *string_filter(const char *str, char c);

/**
 * @brief Verifica si una cadena es simétrica (palíndroma).
 * @details
 * Determina si la cadena apuntada por `str` es simétrica, es decir, si
 * el primer carácter coincide con el último, el segundo con el penúltimo, y así
 * sucesivamente. Se consideran cadenas simétricas, por ejemplo: "", "a", "aba", "abcba".
 *
 * @param[in] str Puntero a una cadena de caracteres terminada en '\0'.
 * @return `1` si la cadena es simétrica, `0` en caso contrario.
 */
bool string_is_symmetric(const char *str); 

#endif