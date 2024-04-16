# ----------------------------------------------------------------------------
# Copyright (c) 2024 Thomas Buck (thomas@xythobuz.de)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# See <http://www.gnu.org/licenses/>.
# ----------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.5)

# initialize pico-sdk from submodule
include(pico-sdk/pico_sdk_init.cmake)

project(dispensy C CXX)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# initialize the Raspberry Pi Pico SDK
pico_sdk_init()

add_executable(dispensy)

target_sources(dispensy PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/src/main.c
    ${CMAKE_CURRENT_LIST_DIR}/src/console.c
    ${CMAKE_CURRENT_LIST_DIR}/src/log.c
    ${CMAKE_CURRENT_LIST_DIR}/src/util.c
    ${CMAKE_CURRENT_LIST_DIR}/src/usb.c
    ${CMAKE_CURRENT_LIST_DIR}/src/usb_cdc.c
    ${CMAKE_CURRENT_LIST_DIR}/src/usb_descriptors.c
    ${CMAKE_CURRENT_LIST_DIR}/src/buttons.c
    ${CMAKE_CURRENT_LIST_DIR}/src/lcd.c
    ${CMAKE_CURRENT_LIST_DIR}/src/ring.c
)

target_include_directories(dispensy PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include)

# enable generous warnings
target_compile_options(dispensy PUBLIC
    -Wall
    -Wextra
    -Werror
    -Wshadow
)

# suppress some warnings for borked 3rd party files in Pico SDK
set_source_files_properties(pico-sdk/lib/btstack/src/ble/sm.c PROPERTIES COMPILE_FLAGS -Wno-unused-parameter)
set_source_files_properties(pico-sdk/lib/btstack/src/btstack_hid_parser.c PROPERTIES COMPILE_FLAGS -Wno-maybe-uninitialized)
set_source_files_properties(pico-sdk/src/rp2_common/pico_cyw43_driver/cyw43_driver.c PROPERTIES COMPILE_FLAGS -Wno-unused-parameter)
set_source_files_properties(pico-sdk/lib/btstack/src/classic/avdtp_util.c PROPERTIES COMPILE_FLAGS -Wno-unused-parameter)
set_source_files_properties(pico-sdk/lib/btstack/src/classic/goep_client.c PROPERTIES COMPILE_FLAGS -Wno-unused-parameter)
set_source_files_properties(pico-sdk/lib/btstack/src/classic/goep_server.c PROPERTIES COMPILE_FLAGS -Wno-unused-parameter)
set_source_files_properties(pico-sdk/src/rp2_common/hardware_flash/flash.c PROPERTIES COMPILE_FLAGS -Wno-shadow)

# pull in common dependencies
target_link_libraries(dispensy
    pico_stdlib
    pico_unique_id
    tinyusb_device
    tinyusb_board
    hardware_adc
    hardware_gpio
    hardware_pwm
)

# fix for Errata RP2040-E5 (the fix requires use of GPIO 15)
target_compile_definitions(dispensy PUBLIC PICO_RP2040_USB_DEVICE_ENUMERATION_FIX=1)

pico_add_extra_outputs(dispensy)
