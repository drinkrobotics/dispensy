/*
 * hw_id.c
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

#include "hardware/watchdog.h"
#include "config.h"
#include "log.h"
#include "hw_id.h"

#define SR_WIDTH 8

#define SR_GPIO_LOAD 20
#define SR_GPIO_CLK 21
#define SR_GPIO_DATA 22

static bool states[SR_WIDTH] = {0};

void hw_id_init(void) {
    gpio_init(SR_GPIO_LOAD);
    gpio_set_dir(SR_GPIO_LOAD, GPIO_OUT);
    gpio_put(SR_GPIO_LOAD, true);

    gpio_init(SR_GPIO_CLK);
    gpio_set_dir(SR_GPIO_CLK, GPIO_OUT);
    gpio_put(SR_GPIO_CLK, true);

    gpio_init(SR_GPIO_DATA);
    gpio_set_dir(SR_GPIO_DATA, GPIO_IN);
}

void hw_id_read(void) {
    gpio_put(SR_GPIO_LOAD, false);
    watchdog_update();
    sleep_us(5);
    gpio_put(SR_GPIO_LOAD, true);
    watchdog_update();
    sleep_us(5);

    for (uint i = 0; i < SR_WIDTH; i++) {
        gpio_put(SR_GPIO_CLK, false);
        watchdog_update();
        sleep_us(5);

        states[i] = gpio_get(SR_GPIO_DATA);

        gpio_put(SR_GPIO_CLK, true);
        watchdog_update();
        sleep_us(5);

        //debug("bit %d is %s", i, states[i] ? "true" : "false");
    }
}

enum hw_type hw_type(void) {
    uint val = 0;
    for (uint i = 4; i < 8; i++) {
        val |= states[i] ? (1 << (i - 4)) : 0;
    }
    return val;
}

uint hw_id(void) {
    uint val = 0;
    for (uint i = 0; i < 4; i++) {
        val |= (!states[i]) ? (1 << (4 - i - 1)) : 0;
    }
    return val;
}
