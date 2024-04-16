/*
 * hw_id.h
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

#ifndef __HW_ID_H__
#define __HW_ID_H__

#include "pico/stdlib.h"

enum hw_type {
    HW_TYPE_MAINBOARD = 0,
};

void hw_id_init(void);
void hw_id_read(void);

enum hw_type hw_type(void);
uint hw_id(void);

#endif // __HW_ID_H__
