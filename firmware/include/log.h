/*
 * log.h
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

#ifndef __LOG_H__
#define __LOG_H__

#include <stdarg.h>
#include <stdbool.h>
#include <inttypes.h>
#include "pico/stdlib.h"

// for output that is stored in the debug log.
// will be re-played from buffer when terminal connects
#define debug(fmt, ...) debug_log(true, \
        "%08" PRIu32 " %s:%d: " fmt "\r\n", \
        to_ms_since_boot(get_absolute_time()), \
        __func__, __LINE__, \
        ##__VA_ARGS__)

// for interactive output. is not stored or re-played.
#define print(fmt, ...) debug_log(false, fmt, ##__VA_ARGS__)
#define println(fmt, ...) debug_log(false, fmt "\r\n", ##__VA_ARGS__)

void debug_log(bool log, const char *format, ...) __attribute__((format(printf, 2, 3)));
void debug_wait_input(const char *format, ...) __attribute__((format(printf, 1, 2)));
void debug_log_va(bool log, const char *format, va_list args);

void log_dump_to_usb(void);

void debug_handle_input(const void *buff, size_t len);

#include "ring.h"
struct ring_buffer *log_get(void);

#endif // __LOG_H__
