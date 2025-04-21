#ifndef _WEATHER_UTILS_H
#define _WEATHER_UTILS_H
#include "weather_table.h"
/*
	Una función que obtenga la menor temperatura mínima histórica registrada en la ciudad de Córdoba
	según los datos del arreglo
 */
/**
 * @brief Obtiene la menor temperatura minima historica registrada en la ciudad de Cordoba
 * @param[in] a table which will contain read file
 */
int min_temp_Cba(WeatherTable a);

int max_temp_for_month(WeatherTable a, unsigned int year);
/*
	Un  “procedimiento” que registre para cada año entre 1980 y 2016 la mayor temperatura máxima
	registrada durante ese año
*/
/**
 * @brief Obtiene la mayor temperatura maxima de cada año entre 1980 y 2016
 * @param[in] a table which will contain read file
 */
void max_temp_for_year(WeatherTable a, int out_year[]);

/*
	Implementar un procedimiento que registre para cada año entre 1980 y 2016 el mes de ese año en
	que  se  registró  la  mayor  cantidad  mensual  de  precipitaciones
*/
/**
 * @brief Obtiene la mayor temperatura maxima de cada año entre 1980 y 2016
 * @param[in] a table which will contain read file
 */
void max_rainfall_for_month(WeatherTable a, month_t out[YEARS]);
#endif