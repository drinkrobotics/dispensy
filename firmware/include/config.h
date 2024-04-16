/*
 * config.h
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

#ifndef __CONFIG_H__
#define __CONFIG_H__

#define VERSION_MAJOR 0
#define VERSION_MINOR 1

#define WATCHDOG_PERIOD_MS 10

// ASCII 0x18 = CAN (cancel)
#define ENTER_BOOTLOADER_MAGIC 0x18

//#define DISABLE_CDC_DTR_CHECK
#define DEBOUNCE_DELAY_MS 5

// ----------------------------------------------------------------------------

#define STR_HELPER(x) #x
#define STR(x) STR_HELPER(x)

#define VERSION_STR "V" STR(VERSION_MAJOR) "." STR(VERSION_MINOR)

#endif // __CONFIG_H__
