/*
 * lcd.c
 *
 * Copyright (c) 2023 - 2024 Thomas Buck (thomas@xythobuz.de)
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

#include <stdio.h>
#include <string.h>

#include "hardware/i2c.h"
#include "ssd1306.h"
#include "git.h"

#include "config.h"
#include "hw_id.h"
#include "log.h"
#include "lcd.h"

#define LCD_I2C_ADDR 0x3C

static i2c_inst_t *gpio_inst_i2c = i2c1;
static const uint gpio_num_i2c[2] = { 14, 15 };

static ssd1306_t lcd = {0};
static bool found = false;

void lcd_init(void) {
    i2c_init(gpio_inst_i2c, 2UL * 1000UL * 1000UL);

    for (uint i = 0; i < sizeof(gpio_num_i2c) / sizeof(gpio_num_i2c[0]); i++) {
        gpio_set_function(gpio_num_i2c[i], GPIO_FUNC_I2C);
        gpio_pull_up(gpio_num_i2c[i]);
    }

    found = ssd1306_init(&lcd, LCD_WIDTH, LCD_HEIGHT, LCD_I2C_ADDR, gpio_inst_i2c);

    if (found) {
        debug("SSD1306 OLED is connected");
    } else {
        debug("No SSD1306 OLED found!");
    }
}

void lcd_splash_version(void) {
    if (!found) {
        return;
    }

    ssd1306_clear(&lcd);

    ssd1306_draw_string(&lcd, 0, 0, 2,
                        "Dispensy");

    ssd1306_draw_string(&lcd, 0, FONT_HEIGHT * 2 + 1, 1,
                        "Release: " VERSION_STR);

    ssd1306_draw_string(&lcd, 0, FONT_HEIGHT * 2 + 1 + FONT_HEIGHT + 1, 1,
                        __DATE__ " " __TIME__);

    if (git_IsPopulated()) {
        const char *hash = git_CommitSHA1();
        char short_hash[6 + 7 + 6 + 1] = {0};
        memcpy(short_hash, "Hash: ", 6);
        memcpy(short_hash + 6, hash, 7);
        if (git_AnyUncommittedChanges()) {
            memcpy(short_hash + 6 + 7, " dirty", 6);
        }
        ssd1306_draw_string(&lcd, 0, FONT_HEIGHT * 2 + 1 + (FONT_HEIGHT + 1) * 2, 1,
                            short_hash);
    } else {
        ssd1306_draw_string(&lcd, 0, FONT_HEIGHT * 2 + 1 + (FONT_HEIGHT + 1) * 2, 1,
                            "No Git Repo");
    }

    char hw_id_str[42] = {0};
    snprintf(hw_id_str, sizeof(hw_id_str) - 1,
             "HW type=%X id=%X", hw_type(), hw_id());
    ssd1306_draw_string(&lcd, 0, FONT_HEIGHT * 2 + 1 + (FONT_HEIGHT + 1) * 3, 1,
                        hw_id_str);

    ssd1306_show(&lcd);
}

void lcd_bye(void) {
    ssd1306_clear(&lcd);
    ssd1306_draw_string(&lcd, 6, 5, 3, " Boot-");
    ssd1306_draw_string(&lcd, 8, LCD_HEIGHT / 2 + 5, 3, "loader");
    ssd1306_show(&lcd);
}
