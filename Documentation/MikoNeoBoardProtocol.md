# Miko Neo protocol

This is an incomplete, unofficial description of the protocol used between the Miko Neo and the Miko Chess app. Use at your own risk.  

BLE: uses Nordic UART service UUID and characteristics:  
https://developer.nordicsemi.com/nRF_Connect_SDK/doc/1.5.1/nrf/include/bluetooth/services/nus.html

The advertised device name is "Square Off Neo - xxx", where xxx is that last three characters of the board's bluetooth MAC address.

## Data structure

The data is sent/received as strings using the following structure:

<commandId>#<data>*

## Game start

To start a game some form of handshake is performed between the app and the board, when the game is started from the standard position:

app->board: 14#1*
board->app: 14#GO*

I did not see this handshake with custom positions (see below).

## Moving pieces on the board

Data received *from* the board is pretty simple, there's "piece up" and "piece down".

Piece up:
board->app: 0#<square>u*

Piece down:
board->app: 0#<square>d*

For example:
	board->app: 0#e2u*
	board->app: 0#e4d*
would announce that the piece on square e2 has moved to e4.
NOTE that no information on which piece (King, pawn, etc. has moved).

Data sent to the board when playing against the app is a little more complicated.

<!-- 

## Set occupied squares (set custom position)

To continue a game at a predefined position or to set up a custom position the app sends to the board which squares should be occupied (1) or not (0):
There is a 1 or 0 for each square, in the following order: a1-a8, b1-b8, c1-c8, ...

# example position after resuming d2-d4, d7-d5:
app->board: 30#1100001111000011110000111001100111000011110000111100001111000011*

TODO: I don't know if the board sends anything back after this command.

## Read board command

This command is sent by the app after receiving a "piece down". Not sure if this clears the LEDs, or what happens if this command is omitted.
app->board: 30#R*

The board then sends the occupied squares back.
The format is the same as the set occupied squares command above.
Example after e4, e5:
board->app: 30#1100001111000011110000111100001110011001110000111100001111000011*

If the returned squares represent the board representation of the app then the app sends the following back to the board:

app->board: 26#ISG*

This can be omitted, I don't know what the board does with this information.

## LED control

It seems that the LEDs for the players' moves are controlled by the board itself, at least I did not see any command on the BLE interface.

Otherwise the following command can be sent to light up LEDs:

app->board: 25#<square><square><square...>*
Example:
app->board: 25#c8d7e6f5*

### King in check

This command makes a sound on the board when the King is in check.

app->board: 27#ck*

### Game result

When the game ends the app sends the result to the board, presumably so the board can light up some LEDs.

#### White wins

app->board: 27#wt*

#### Black wins

app->board: 27#bl*

#### Draw

app->board: 27#dw*

## Battery status request?

The app periodically sends the following command to the board, the first one right after the initial handshake command:

app->board: 4#*

The board answers with some value:
board->app: 22#3.52*

I've seen various other values, with lower values over time, so I presume this is some kind of battery status, although I have found nothing in the app to indicate this.
board->app: 22#3.67*
board->app: 22#3.65*
board->app: 22#3.60*


## Example game sequence (taken from Chess Dojo <-> board interaction)

->:14#1*
->:4#*
->:30#R*
<-:14#GO*
<-:30#1100001111000011110000111100001111000011110000111100001111000011*
->:26#ISG*
<-:0#e2u*
<-:0#e4d*
->:30#R*
<-:30#1100001111000011110000111100001110010011110000111100001111000011*
->:26#ISG*
->:25#e7e5*
<-:0#e7u*
<-:0#e5d*
<-:0#f1u*
<-:0#c4d*
->:30#R*
<-:30#1100001111000011110100111100001110011001010000111100001111000011*
->:26#ISG*
->:25#g8f6*
<-:0#g8u*
<-:0#f6d*
<-:0#d2u*
<-:0#d3d*
->:30#R*
<-:30#1100001111000011110100111010001110011001010001111100001011000011*
->:26#ISG*
->:25#c7c6*
<-:0#c7u*
<-:0#c6d*
<-:0#b1u*
<-:0#c3d*
->:30#R*
<-:30#1100001101000011111101011010001110011001010001111100001011000011*
->:26#ISG*
->:25#d7d5*
<-:0#d7u*
<-:0#d5d*
<-:0#d5u*
<-:0#e4u*
<-:0#d5d*
->:30#R*
<-:30#1100001101000011111101011010100110001001010001111100001011000011*
->:26#ISG*
->:25#c6d5*
<-:0#d5u*
<-:0#c6u*
<-:0#d5d*
<-:0#c4u*
<-:0#b5d*
->:30#R*
<-:30#1100001101001011111000011010100110001001010001111100001011000011*
->:26#ISG*
->:25#b8c6*
<-:0#b8u*
<-:0#c6d*
<-:0#g1u*
<-:0#f3d*
->:30#R*
<-:30#1100001101001010111001011010100110001001011001110100001011000011*
->:26#ISG*
->:25#c8g4*
<-:0#c8u*
<-:0#g4d*
<-:0#h2u*
<-:0#h3d*
->:30#R*
<-:30#1100001101001010111001001010100110001001011001110101001010100011*
->:26#ISG*
->:25#g4f3*
<-:0#f3u*
<-:0#g4u*
<-:0#f3d*
<-:0#f3u*
<-:0#d1u*
<-:0#f3d*
->:30#R*
<-:30#1100001101001010111001000010100110001001011001110100001010100011*
->:26#ISG*
->:25#f8b4*
<-:0#f8u*
<-:0#b4d*
<-:0#c1u*
<-:0#g5d*
->:30#R*
<-:30#1100001101011010011001000010100110001001011001100100101010100011*
->:26#ISG*
->:25#b4c3*
<-:0#c3u*
<-:0#b4u*
<-:0#c3d*
<-:0#c3u*
<-:0#b2u*
<-:0#c3d*
->:30#R*
<-:30#1100001100001010011001000010100110001001011001100100101010100011*
->:26#ISG*
->:25#a8c8*
<-:0#a8u*
<-:0#c8d*
<-:0#e1u*
<-:0#g1d*
<-:0#h1u*
<-:0#f1d*
->:30#R*
<-:30#1100001000001010011001010010100100001001111001101100101000100011*
->:26#ISG*
->:25#h7h6*
<-:0#h7u*
<-:0#h6d*
<-:0#g5u*
<-:0#h4d*
->:30#R*
<-:30#1100001000001010011001010010100100001001111001101100001000110101*
->:26#ISG*
->:25#g7g5*
<-:0#g7u*
<-:0#g5d*
<-:0#h4u*
<-:0#g3d*
->:30#R*
<-:30#1100001000001010011001010010100100001001111001101110100000100101*
->:26#ISG*
->:25#d8d6*
<-:0#d8u*
<-:0#d6d*
<-:0#f1u*
<-:0#e1d*
->:30#R*
<-:30#1100001000001010011001010010110010001001011001101110100000100101*
->:26#ISG*
->:25#f6d7*
<-:0#f6u*
<-:0#d7d*
<-:0#c6u*
<-:0#b5u*
<-:0#c6d*
->:30#R*
<-:30#1100001000000010011001010010111010001001011000101110100000100101*
->:26#ISG*
->:25#c8c6*
<-:0#c6u*
<-:0#c8u*
<-:0#c6d*
<-:0#d3u*
<-:0#d4d*
->:30#R*
<-:30#1100001000000010011001000001111010001001011000101110100000100101*
->:26#ISG*
-->