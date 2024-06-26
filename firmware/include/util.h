/*
 * util.h
 *
 * Copyright (c) 2022 - 2024 Thomas Buck (thomas@xythobuz.de)
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * See <http://www.gnu.org/licenses/>.
 */

#ifndef __UTIL_H__
#define __UTIL_H__

bool str_startswith(const char *str, const char *start);

void reset_to_bootloader(void);
void reset_to_main(void);

void hexdump(const uint8_t *buff, size_t len);

float map(float value, float leftMin, float leftMax, float rightMin, float rightMax);

#endif // __UTIL_H__
