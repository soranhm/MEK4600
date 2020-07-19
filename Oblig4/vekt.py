from __future__ import print_function
import serial
import time

# note: find the usb port to use with (in terminal):
# dmesg | grep tty
# and take the last line
usb_port_name = '/dev/ttyUSB0'

baudrate = 18200

usb_port = serial.Serial(usb_port_name, baudrate=baudrate, timeout=0.5)
usb_port.flushInput()


def look_if_message():

    list_chars = []

    while usb_port.inWaiting() > 0:
        crrt_char = usb_port.read()
        list_chars.append(crrt_char)

    if len(list_chars) > 0:
        crrt_string = "".join(list_chars)
        print(crrt_string)


start_time = time.time()
duration_s = 2 * 60
reading_period_s = 2

while time.time() - start_time < duration_s:
    look_if_message()
    usb_port.write('SI\n')
    time.sleep(reading_period_s)
