# RPi Automotive Black Box

Using an RPi Camera Module and ELM327 BT OBDII Reader, the RPi AutoBB is a helpful device for centralizing OBDII Car diagnostics and Dashcam video all in one.

## Features

### Dashcam
* Driving Mode (Default) - Records Video at length specified by user
* Parked Mode - Activates Motion Detection which takes a snapshot at each trigger

### OBDII Reader
* Accesses and Logs Car Diagnostic Information

## Getting Started

### Things You'll Need

* [RPi Camera Module](<https://www.amazon.com/dp/B07QNSJ32M/ref=cm_sw_r_cp_api_i_ukwzEbFKVCS40>)
* [ELM327 BT OBDII Reader](<https://www.amazon.com/dp/B074DWH8JR/ref=cm_sw_r_cp_api_i_8iuzEb95CGZB7>)
* [RPi3](<https://www.adafruit.com/product/3055>), [RPi4](<https://www.adafruit.com/product/4296>), or [RPi Zero W](<https://www.adafruit.com/product/3400>)

To begin, run ``` ./Black_Box_Install ``` or ``` python3 Black_Box_Install.py ``` to install all necessary libraries and configure PATH usage. (You will need a WiFi connection for setup)
Simply follow all instructions in the installer.

### Usage

To access the help menu type ``` BB info ``` and execute in terminal. 


## Built With

* RPi 3B+ - Micro-Computer Developed by the Raspberry Pi Foundation
* RPi Camera Module - Dashcam for recording and motion detection
* ELM327 BT OBDII Reader - OBDII Reader for Diagnostic Information
* Kali Linux - Pentesting OS Developed by Offensive Security
* GitHub - This Website!

## Authors

* **Cisc0-gif** - *Main Contributor/Author*: Ecorp7@protonmail.com

## License

This project is licensed under the MIT License - see the LICENSE.txt file for details


## Acknowledgments

All credits are given to the authors and contributors to tools used in this software
