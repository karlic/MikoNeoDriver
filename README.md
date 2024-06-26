# MikoNeoDriver
Driver (and test harness) for the Miko Neo chess board heavily based on (i.e., copied from) the work of
Khadim Fall and Gerhard Kalab.

Miko took over the SquareOff Now company and have provided an app and new firmware for the Neo board, so it is
herein referred to as the Miko Neo.

Khadim Fall's WhitePawn app and Gerhard Kalab's Chess Dojo app already provide a driver for the SquareOff Pro, but
the Neo is significantly different in that it uses witchcraft (or possibly a magnet under the board) to move the opponent's
pieces around the board. Neither WhitePawn nor Chess Dojo currently have the correct spells to provide this functionality.

The aim is to provide a driver that can be used by the WhitePawn app https://whitepawn.app to provide some of the functionality not provided by the Miko (and SquareOff Now) apps (such as opening training).

## What works?
1. Scans for and finds the Neo board
2. Connects to the Neo board and causes it to beep correctly
3. New Game, Test LEDs, White won, Black won, King in check, Draw and Get Board all appear to work

There is a video sample in Documentation/MikoDriverTesting.mov

## What doesn't work?
1. There is currently no witchcraft for moving the opponent's pieces

## How to capture communication to/from the Neo board
1. Purchase a bluetooth dongle such as https://www.amazon.co.uk/dp/B07TSJHTSY (£21)
2. Follow these instructions https://wiki.makerdiary.com/nrf52840-mdk-usb-dongle/guides/ble-sniffer/
3. If you find you have two interfaces, the capture won't work. The fix seems to be a random combination of unplugging the dongle, restarting Wireshark and doing Capture | Refresh Interfaces
4. Scanning for services advertised by the board can be done with this free app: https://github.com/dmtrKovalenko/blendr

## How to run this app
https://docs.flutter.dev/get-started/install/macos/mobile-ios
