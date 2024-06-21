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
<!-- board->app: 14#GO* THIS DOES NOT APPEAR TO HAPPEN ON THE MIKO NEO -->

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
-->

## Example game sequence (taken from Miko iPhone app <-> board interaction)
1.d4 c6 2.Bf4 c5 3.e3 d5 4.Nf3 Nf6 5.Nbd2 Bd7 6.Ne5 c4 7.Be2 Be6 8.c3 Nh5 9.Qa4+ Qd7 10.Nxd7 g6 11.Nf6+ Kd8 12.Qe8# {1-0}

|App<->Board|PKT No.| PGN |Command                      |Purpose   |
|-----------|-------|-----|-----------------------------|----------|
|Connection seems to be from pkt 1618 onwards.                     |
|->         |1719   |     |14#1*                        |Start game|
|<-         |1734   |e4   |d2u                          |Piece up  |
|<-         |1735   |e4   |d4d                          |Piece down|
|->         |1736   |c6   |2,6:2,4.92                   |Move piece|
|<-         |1743   |Bf4  |c1u                          |Piece up  |
|<-         |1745   |Bf4  |f4d                          |Piece down|
|->         |1747   |c5   |2,5:2,3.92                   |Move piece|
|<-         |1760   |e3   |e2u                          |Piece up  |
|<-         |1762   |e3   |e3d                          |Piece down|
|->         |1764   |d5   |3,6:3,3.92                   |Move piece|
|<-         |1771   |Nf3  |g1u                          |Piece up  |
|<-         |1773   |Nf3  |f3d                          |Piece down|
|->         |1774   |Nf6  |6,7:5.5,6.5:5.5,5.5:4.92,4.92|Move piece|
|<-         |1781   |Nbd2 |b1u                          |Piece up  |
|<-         |1782   |Nbd2 |d2d                          |Piece down|
|->         |1784   |Bd7  |2,7:3.08,5.92                |Move piece|
|<-         |1791   |Ne5  |f3u                          |Piece up  |
|<-         |1793   |Ne5  |e5d                          |Piece down|
|->         |1794   |c4   |2,4:2,2.92                   |Move piece|
|<-         |1817   |Be2  |f1u                          |Piece up  |
|<-         |1818   |Be2  |e2d                          |Piece down|
|->         |1820   |Be6  |3,6:4.08,4.92                |Move piece|
|<-         |1826   |c3   |c2u                          |Piece up  |
|<-         |1827   |c3   |c3d                          |Piece down|
|->         |1829   |Nh5  |5,5:6,5:7.08,3.92            |Move piece|
|<-         |1854   |Qa4+ |d1u                          |Piece up  |
|<-         |1855   |Qa4+ |a4d                          |Piece down|
|->         |1857   |Qd7  |3,7:3,5.92                   |Move piece|
|<-         |1863   |Nxd7 |e5u                          |Piece up  |
|<-         |1866   |Nxd7 |d7d                          |Piece down|
|->         |1868   |g6   |6,6:6,4.92                   |Move piece|
|<-         |1887   |Nf6+ |d7u                          |Piece up  |
|<-         |1889   |Nf6+ |f6d                          |Piece down|
|->         |1891   |Kd8  |4,7:2.92,7                   |Move piece|
|<-         |1900   |Qe8# |a4u                          |Piece up  |
|<-         |1901   |Qe8# |e8d                          |Piece down|



