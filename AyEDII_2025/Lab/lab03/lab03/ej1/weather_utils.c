#include "weather_utils.h"

int min_temp_Cba(WeatherTable a)
{
	int min_temp = -1;
	for (unsigned int year = 0u; year < YEARS; ++year)
	{
		for (month_t month = january; month <= december; ++month)
		{
			for (unsigned int day = 0u; day < DAYS; ++day)
			{
				if (min_temp >= a[year][month][day]._min_temp)
				{
					min_temp = a[year][month][day]._min_temp;
				}
			}
		}
	}

	return min_temp;
}
int max_temp_for_month(WeatherTable a, unsigned int year)
{
	int max_temp = a[year][0][0]._max_temp;
	for (month_t month = january; month <= december; ++month)
	{
		for (unsigned int day = 0u; day < DAYS; ++day)
		{
			if (max_temp <= a[year][month][day]._max_temp)
			{
				max_temp = a[year][month][day]._max_temp;
			}
		}
	}
	return max_temp;
}

void max_temp_for_year(WeatherTable a, int out_year[])
{
	for (unsigned int year = 0u; year < YEARS; year++)
	{
		out_year[year] = max_temp_for_month(a, year);
		printf("Año %d - Temp_Max:\t--> %d\n", year + FST_YEAR, out_year[year]);
	}
}

void max_rainfall_for_month(WeatherTable array, month_t out[YEARS])
{
	for (int k_year = FST_YEAR; k_year <= LST_YEAR; k_year = k_year + 1)
	{
		unsigned int sum_by_month_aux = 0;
		for (month_t k_month = january; k_month <= december; k_month = k_month + 1)
		{
			unsigned int sum_by_month = 0;
			for (int k_day = 1; k_day <= DAYS; k_day = k_day + 1)
			{
				sum_by_month = array[k_year - FST_YEAR][k_month][k_day - 1]._rainfall + sum_by_month;
			}
			if (sum_by_month > sum_by_month_aux)
			{
				sum_by_month_aux = sum_by_month;
				out[k_year - FST_YEAR] = k_month;
			}
		}
	}
}