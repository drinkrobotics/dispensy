/*
 * util.c
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

#include <string.h>
#include "pico/bootrom.h"
#include "hardware/watchdog.h"

#include "config.h"
#include "log.h"
#include "util.h"

bool str_startswith(const char *str, const char *start) {
    size_t l = strlen(start);
    if (l > strlen(str)) {
        return false;
    }
    return (strncmp(str, start, l) == 0);
}

void reset_to_bootloader(void) {
#ifdef PICO_DEFAULT_LED_PIN
    reset_usb_boot(1 << PICO_DEFAULT_LED_PIN, 0);
#else // ! PICO_DEFAULT_LED_PIN
    reset_usb_boot(0, 0);
#endif // PICO_DEFAULT_LED_PIN
}

void reset_to_main(void) {
    watchdog_enable(1, false);
    while (1);
}

void hexdump(const uint8_t *buff, size_t len) {
    for (size_t i = 0; i < len; i += 16) {
        for (size_t j = 0; (j < 16) && ((i + j) < len); j++) {
            print("0x%02X", buff[i + j]);
            if ((j < 15) && ((i + j) < (len - 1))) {
                print(" ");
            }
        }
        println();
    }
}

float map(float value, float leftMin, float leftMax, float rightMin, float rightMax) {
    float leftSpan = leftMax - leftMin;
    float rightSpan = rightMax - rightMin;
    float valueScaled = (value - leftMin) / leftSpan;
    return rightMin + (valueScaled * rightSpan);
}
