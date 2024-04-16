/*
 * main.c
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
#include "console.h"
#include "log.h"
#include "usb.h"
#include "buttons.h"
#include "lcd.h"
#include "main.h"

void main_loop_hw(void) {
    watchdog_update();
    usb_run();
}

int main(void) {
    watchdog_enable(WATCHDOG_PERIOD_MS, 1);

    // detect hardware type
    // TODO

    // required for debug console
    cnsl_init();
    usb_init();
    debug("init");

    if (watchdog_caused_reboot()) {
        debug("reset by watchdog");
    }

    buttons_init();
    lcd_init();
    lcd_splash_version();

    debug("go");

    while (1) {
        main_loop_hw();
        buttons_run();
        cnsl_run();
    }

    return 0;
}
