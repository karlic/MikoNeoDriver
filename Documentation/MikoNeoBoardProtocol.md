# Miko Neo communication protocol

This is an incomplete, unofficial description of the protocol used between the Miko Neo and the Miko Chess app. Use at your own risk.

Communication takes place over Bluetooth Low Energy (BLE) network technology. In addition to the [Nordic UART service UUID and characteristics] (https://developer.nordicsemi.com/nRF_Connect_SDK/doc/1.5.1/nrf/include/bluetooth/services/nus.html) used by the Square Off Pro, the Neo uses several other characteristics detailed in the table below.

The advertised device name is "Square Off Neo - xxx", where xxx is the last three characters of the board's bluetooth MAC address.

The services and characteristics offered by the board. (Those in **bold** are known to be used.)

|Service|Characteristic|Descriptor|UUID                                    |Information                       |
|-------|--------------|----------|----------------------------------------|----------------------------------|
|Service|              |          |6e400001-b5a3-f393-e0a9-e50e24dcca9e    |(Handle: 40): Nordic UART Service|
|       |Characteristic|          |**6e400003-b5a3-f393-e0a9-e50e24dcca9e**|(Handle: 41): Nordic UART TX (notify)|
|       |              |Descriptor|00002902-0000-1000-8000-00805f9b34fb    |(Handle: 43): Client Characteristic Configuration, Value: bytearray(b'')|
|       |Characteristic|          |**6e400002-b5a3-f393-e0a9-e50e24dcca9e**|(Handle: 44): Nordic UART RX (write)|
|Service|              |          |0000180f-0000-1000-8000-00805f9b34fb    |(Handle: 55): Battery Service|
|       |Characteristic|          |00002a19-0000-1000-8000-00805f9b34fb    |(Handle: 56): Battery Level (read,notify), Value: bytearray(b'S')|
|       |              |Descriptor|00002901-0000-1000-8000-00805f9b34fb    |(Handle: 58): Characteristic User Description, Value: bytearray(b'Percentage 0 - 100')|
|       |              |Descriptor|00002902-0000-1000-8000-00805f9b34fb    |(Handle: 59): Client Characteristic Configuration, Value: bytearray(b'')|
|Service|              |          |0000180a-0000-1000-8000-00805f9b34fb    |(Handle: 70): Device Information|
|       |Characteristic|          |00002a27-0000-1000-8000-00805f9b34fb    |(Handle: 71): Hardware Revision String (read), Value: bytearray(b'1A1')|
|       |Characteristic|          |00002a26-0000-1000-8000-00805f9b34fb    |(Handle: 73): Firmware Revision String (read), Value: bytearray(b'3.1.1')|
|       |Characteristic|          |00002a25-0000-1000-8000-00805f9b34fb    |(Handle: 75): Serial Number String (read), Value: bytearray(b'NS-XXXXXX')|
|Service|              |          |d804b643-6ce7-4e81-9f8a-ce0f699085eb    |(Handle: 85): Unknown|
|       |Characteristic|          |d804b644-6ce7-4e81-9f8a-ce0f699085eb    |(Handle: 86): Unknown (read,write), Value: bytearray(b'100111')|
|       |Characteristic|          |d804b649-6ce7-4e81-9f8a-ce0f699085eb    |(Handle: 88): Unknown (read,write), Value: bytearray(b'11')|
|       |Characteristic|          |d804b645-6ce7-4e81-9f8a-ce0f699085eb    |(Handle: 90): Unknown (read,write), Value: bytearray(b'2000,2400')|
|       |Characteristic|          |d804b646-6ce7-4e81-9f8a-ce0f699085eb    |(Handle: 92): Unknown (write)|
|       |Characteristic|          |d804b651-6ce7-4e81-9f8a-ce0f699085eb    |(Handle: 94): Unknown (read,write), Value: bytearray(b'500,100,5,3,10,20,100,500,30,20,15,10,60,40,25,15,20,15,10,5')|
|       |Characteristic|          |d804b647-6ce7-4e81-9f8a-ce0f699085eb    |(Handle: 96): Unknown (write)|
|       |Characteristic|          |d804b650-6ce7-4e81-9f8a-ce0f699085eb    |(Handle: 98): Unknown (read,write), Value: bytearray(b'{"manufacturingconfig":["Neo",1,1,1,1,1,1],"buzzerconfig":[1,0,0,1,1,1],"lightconfig":[1,1],"speedConfigSetting":[500,100,5,3,10,20,100,500,30,20,15,10,60,40,25,15,20,15,10,5],"miscellaneousConfig":[0,0,0,0,0],"batteryConfig":[2000,2400],"boardinformation":["XX:XX:XX:XX:XX:XX",1,"A",1,"v3.3.5-1-g85c43024c","NS-XXXXXX"]}')|
|Service|              |          |c8659210-af91-4ad3-a995-a58d6fd26145    |(Handle: 100): Unknown|
|       |Characteristic|          |c8659212-af91-4ad3-a995-a58d6fd26145    |(Handle: 101): Unknown (read), Value: bytearray(b'\x01\x00\x03\x01\x01')|
|       |Characteristic|          |d804b648-6ce7-4e81-9f8a-ce0f699085eb    |(Handle: 103): Unknown (read,write), Value: bytearray(b'')|
|       |Characteristic|          |c8659211-af91-4ad3-a995-a58d6fd26145    |(Handle: 105): Unknown (write,notify)|
|       |              |Descriptor|00002902-0000-1000-8000-00805f9b34fb    |(Handle: 107): Client Characteristic Configuration, Value: bytearray(b'')|
|Service|              |          |3d0869ef-e8a4-4088-9459-5454e16820ac    |(Handle: 115): Unknown|
|       |Characteristic|          |**4496994f-2600-4e7e-81d5-e0f7b67ebd48**|(Handle: 116): Unknown (notify)|
|       |              |Descriptor|00002902-0000-1000-8000-00805f9b34fb    |(Handle: 118): Client Characteristic Configuration, Value: bytearray(b'')|
|       |Characteristic|          |**f9664d70-93ff-4cfe-9bfe-b5866aa5bef2**|(Handle: 119): Unknown (write)|
|       |Characteristic|          |**777ac5a4-6fa8-474b-841d-091bd57d28c4**|(Handle: 121): Unknown (notify)|
|       |              |Descriptor|00002902-0000-1000-8000-00805f9b34fb    |(Handle: 123): Client Characteristic Configuration, Value: bytearray(b'')|
|       |Characteristic|          |**c7d64c44-42f0-11ec-81d3-0242ac130003**|(Handle: 124): Unknown (write)|
|       |Characteristic|          |**c7d64c45-42f0-11ec-81d3-0242ac130003**    |(Handle: 126): Unknown (read,write), Value: bytearray(b'0:500,10,15,5')|
|       |Characteristic|          |c7d64c46-42f0-11ec-81d3-0242ac130003    |(Handle: 128): Unknown (read,write), Value: bytearray(b'0')|

## Characteristic 6e400002-b5a3-f393-e0a9-e50e24dcca9e
Appears to be used by the Miko app to send high level (UTF8) requests to the board.
The structure of requests is: `<commandId>#<data>*`.

Known commands
<->|Command |Purpose             |Output                    |Notes           |
---|--------|--------------------|--------------------------|----------------|
-> |1#*     |                    |                          |                |
-> |14#1*   |Start new game      |                          |                |
-> |14#3*   |UNKNOWN             |                          |                |
-> |30#2000*|UNKNOWN             |                          |                |
-> |27#ck*  |Notify king in check|Board beeps 3 times      	|**Deprecated??**|
-> |27#wt*  |White has won       |White's 2 home ranks flash|**Deprecated??**|
-> |27#bl*  |Black has won       |Black's 2 home ranks flash|**Deprecated??**|
-> |27#dw*  |The game is drawn   |All 4 home ranks flash    |**Deprecated??**|

## Characteristic c7d64c44-42f0-11ec-81d3-0242ac130003
It seems that this characteristic has replaced some of the functionality of **6e400002-b5a3-f393-e0a9-e50e24dcca9e**.

Known commands
<->|Command |Purpose                     |Output                    |Notes|
---|--------|----------------------------|--------------------------|-----|
-> |S:po    |UNKNOWN                     |                          |     |
-> |M:c8    |UNKNOWN                     |                          |     |
-> |R:ISG   |                            |                          |     |
-> |S:ck    |Notify king in **c**hec**k**|Board beeps 3 times      	|     |
-> |S:wt    |**W**hi**t**e has won       |White's 2 home ranks flash|     |
-> |S:bl    |**Bl**ack has won           |Black's 2 home ranks flash|     |
-> |S:dw    |The game is **d**ra**w**n   |All 4 home ranks flash    |     |

## Characteristic 6e400003-b5a3-f393-e0a9-e50e24dcca9e
Appears to be used by the board to send high level (UTF8) responses to the Miko app.
The structure of reponses is: `<commandId>#<data>*`.

Known commands
<->|Command             |Purpose                |Output                    |Notes|
---|--------------------|-----------------------|--------------------------|-----|
<- |1#XX:XX:XX:XX:XX:XX*|Provides MAC address   |                          |     |
<- |4#XXXX.XX*          |Provides battery status|                          |     |

## Characteristic 4496994f-2600-4e7e-81d5-e0f7b67ebd48
Is used by the board to send "piece up" and "piece down" (UTF8) information to the Miko app.

The format is pretty simple. Piece up is `<square>u` and piece down is `<square>d`.
Clearly, `u` signifies up and `d` signifies down. `square` is in standard algebraic notation (a1 to h8).

For example:  
	board->app: `d2u`  
	board->app: `d4d`  
	would announce that the piece on square d2 was lifted and put down on d4.
	**NOTE** that no information is given on which piece (king, pawn, etc.) has moved.

**Note:** that the moves are sent "raw" i.e., without the prefix `0#` or the suffix `*` used by the Square Off Pro.
(In fact, including them causes errors.)

## Characteristic f9664d70-93ff-4cfe-9bfe-b5866aa5bef2
Data sent **to** the board when playing against the Miko app are a little more complicated.
(It has to be more complicated since the Neo actually moves the pieces on the board itself.)
Rather than "piece up" and "piece down", the start and end coordinates for the move are sent. 

**NOTE** though that the coordinates are given as x,y coordinates followed by `|`, such that square a1 is 0,0 and h8 is 7,7.

**NOTE ALSO** that some coordinates (only the end ones??) are offset by 0.08 for reasons unknown.

**NOTE FURTHER** that Knights (and other pieces??) have to make more than one move to get to their destination.

For example:
	`2,6:2,4.92|`
	would cause the piece on square 2,6 to move to square 2,5 (that is c7 to c6)
	`6,7:5.5,6.5:5.5,5.5:4.92,4.92|`
	would cause the piece (a knight) on square 6,7 to move to square 5,5 via 5.5,6.5 and 5.5,5.5 (that is g8 to f6 via the corner of g6/h7 and the corner of f6/g7).

The seemingly convoluted move means that the knight avoids hitting a piece on the square in front of it.

## Characteristic 777ac5a4-6fa8-474b-841d-091bd57d28c4
Is used by the board to send information about the occupancy of the squares on the board. That is, whether a square has a piece on it or not.
Each square is either occupied, `1` or unoccupied `0`. There is **no** information about which piece (king, bishop, pawn, etc. is on the square).
The occupancy is sent as a UTF8 string of 64 ones and zeroes, denoting a1--a8, b1--b8, ..., h1--h8.

For example, `1100001111000011110000101100001111000011110000111100001111000011` would be the occupany of the board at the start of a new game.


## Game start

To start a game some form of handshake is performed between the app and the board, when the game is started from the standard position:

app->board: `14#1*`

<!-- board->app: 14#GO* THIS DOES NOT APPEAR TO HAPPEN ON THE MIKO NEO -->

<!-- I did not see this handshake with custom positions (see below). -->



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
**NOTE: a lot of the interaction is not yet listed below. (Even the commands are not complete.) If you need it, open MikoNeoBoardBLETraffic.pcapng in Wireshark**

The Portable Game Notation (PGN) for the example game:
1.d4 c6 2.Bf4 c5 3.e3 d5 4.Nf3 Nf6 5.Nbd2 Bd7 6.Ne5 c4 7.Be2 Be6 8.c3 Nh5 9.Qa4+ Qd7 10.Nxd7 g6 11.Nf6+ Kd8 12.Qe8# {1-0}

Connection seems to be from frame 1618 onwards.
**TODO: Fill in the rest of the frames**

|<->|Charac.  |Frame| PGN |Communication                                                   |Purpose     |Notes |
|---|---------|-----|-----|----------------------------------------------------------------|------------|------|
|<- |777ac5a4-|1700 |     |1100001111000011110000101100001111000011110000111100001111000011|Board status|      |
|-> |6e400002-|1703 |     |1#*                                                             |            |      |
|<- |6e400003-|1705 |     |1#XX:XX:XX:XX:XX:XX*                                            |            |      |
|<- |777ac5a4-|1706 |     |1100001111000011110000101100001111000011110000111100001111000011|Board status|      |
|-> |c7d64c44-|1707 |     |S:po                                                            |UNKNOWN     |      |
|<- |c7d64c44-|1708 |     |                                                                |Got 1707    |      |
|-> |6e400002-|1709 |     |14#3*                                                           |            |      |
|<- |777ac5a4-|1712 |     |1100001111000011110000101100001111000011110000111100001111000011|Board status|      |
|<- |777ac5a4-|1713 |     |1100001111000011110000101100001111000011110000111100001111000011|Board status|      |
|<- |777ac5a4-|1714 |     |1100001111000011110000101100001111000011110000111100001111000011|Board status|      |
|-> |c7d64c44-|1715 |     |M:c8                                                            |UNKNOWN     |      |
|<- |c7d64c44-|1716 |     |                                                                |Got 1715    |      |
|-> |6e400002-|1717 |     |30#2000*                                                        |            |      |
|-> |6e400002-|1719 |     |14#1*                                                           |New game    |      |
|<- |777ac5a4-|1721 |     |1100001111000011110000101100001111000011110000111100001111000011|Board status|      |
|-> |c7d64c44-|1722 |     |M:c8                                                            |UNKNOWN     |      |
|<- |c7d64c44-|1723 |     |                                                                |Got 1722    |      |
|<- |777ac5a4-|1724 |     |1100001111000011110000111100001111000011110000111100001111000011|Board status|      |
|-> |c7d64c44-|1725 |     |S:po                                                            |UNKNOWN     |      |
|<- |c7d64c44-|1726 |     |                                                                |Got 1725    |      |
|-> |c7d64c44-|1727 |     |R:ISG                                                           |            |      |
|<- |c7d64c44-|1728 |     |                                                                |Got 1727    |      |
|<- |777ac5a4-|1729 |     |1100001111000011110000111100001111000011110000111100001111000011|Board status|      |
|<- |777ac5a4-|1732 |     |1100001111000011110000111100001111000011110000111100001111000011|Board status|      |
|<- |777ac5a4-|1733 |     |1100001111000011110000111100001111000011110000111100001111000011|Board status|      |
|<- |4496994f-|1734 |e4   |d2u                                                             |Piece up    |      |
|<- |4496994f-|1735 |e4   |d4d                                                             |Piece down  |      |
|<- |777ac5a4-|1736 |     |1100001111000011110000111001001111000011110000111100001111000011|Board status|      |
|-> |f9664d70-|1737 |c6   |2,6:2,4.92\|                                                    |Move piece  |      |
|<- |f9664d70-|1738 |     |                                                                |Got 1737    |      |
|<- |4496994f-|1739 |     |OK                                                              |            |      |
|<- |777ac5a4-|1740 |     |1100001111000011110001011001001111000011110000111100001111000011|Board status|      |
|<- |777ac5a4-|1741 |     |1100001111000011110001011001001111000011110000111100001111000011|Board status|      |
|<- |777ac5a4-|1742 |     |1100001111000011110001011001001111000011110000111100001111000011|Board status|      |
|<- |4496994f-|1743 |Bf4  |c1u                                                             |Piece up    |      |
|<- |777ac5a4-|1744 |     |1100001111000011010001011001001111000011110000111100001111000011|Board status|      |
|<- |4496994f-|1745 |Bf4  |f4d                                                             |Piece down  |      |
|<- |777ac5a4-|1746 |     |1100001111000011010001011001001111000011110100111100001111000011|Board status|      |
|-> |f9664d70-|1747 |c5   |2,5:2,3.92\|                                                    |Move piece  |      |
|<- |f9664d70-|1748 |     |                                                                |Got 1747    |      |
|<- |4496994f-|1749 |     |OK                                                              |            |      |
|<- |777ac5a4-|1750 |     |1100001111000011010010011001001111000011110100111100001111000011|Board status|      |
|<- |777ac5a4-|1751 |     |1100001111000011010010011001001111000011110100111100001111000011|Board status|      |
|<- |777ac5a4-|1752 |     |1100001111000011010010011001001111000011110100111100001111000011|Board status|      |
|<- |777ac5a4-|1753 |     |1100001111000011010010011001001111000011110100111100001111000011|Board status|      |
|<- |777ac5a4-|1754 |     |1100001111000011010010011001001111000011110100111100001111000011|Board status|      |
|<- |777ac5a4-|1756 |     |1100001111000011010010011001001111000011110100111100001111000011|Board status|      |
|<- |777ac5a4-|1758 |     |1100001111000011010010011001001111000011110100111100001111000011|Board status|      |
|<- |777ac5a4-|1759 |     |1100001111000011010010011001001111000011110100111100001111000011|Board status|      |
|<- |4496994f-|1760 |e3   |e2u                                                             |Piece up    |      |
|<- |777ac5a4-|1761 |     |1100001111000011010010011001001110000011110100111100001111000011|Board status|      |
|<- |4496994f-|1762 |e3   |e3d                                                             |Piece down  |      |
|<- |777ac5a4-|1763 |     |1100001111000011010010011001001110100011110100111100001111000011|Board status|      |
|-> |f9664d70-|1764 |d5   |3,6:3,3.92\|                                                    |Move piece  |      |
|<- |f9664d70-|1765 |     |                                                                |Got 1764    |      |
|<- |4496994f-|1766 |     |OK                                                              |            |      |
|<- |777ac5a4-|1767 |     |1100001111000011010010011001100110100011110100111100001111000011|Board status|      |
|<- |777ac5a4-|1768 |     |1100001111000011010010011001100110100011110100111100001111000011|Board status|      |
|<- |777ac5a4-|1769 |     |1100001111000011010010011001100110100011110100111100001111000011|Board status|      |
|<- |777ac5a4-|1770 |     |1100001111000011010010011001100110100011110100111100001111000011|Board status|      |
|<- |4496994f-|1771 |Nf3  |g1u                                                             |Piece up    |      |
|<- |777ac5a4-|1772 |     |1100001111000011010010011001100110100011110100110100001111000011|Board status|      |
|<- |4496994f-|1773 |Nf3  |f3d                                                             |Piece down  |      |
|-> |f9664d70-|1774 |Nf6  |6,7:5.5,6.5:5.5,5.5:4.92,4.92\|                                 |Move piece  |      |
|<- |f9664d70-|1775 |     |                                                                |Got 1774    |      |
|<- |4496994f-|1776 |     |OK                                                              |            |      |
|<- |777ac5a4-|1777 |     |1100001111000011010010011001100110100011111101110100000011000011|Board status|      |
|<- |777ac5a4-|1778 |     |1100001111000011010010011001100110100011111101110100000011000011|Board status|      |
|<- |777ac5a4-|1779 |     |1100001111000011010010011001100110100011111101110100000011000011|Board status|      |
|<- |777ac5a4-|1780 |     |1100001111000011010010011001100110100011111101110100000011000011|Board status|      |
|<- |4496994f-|1781 |Nbd2 |b1u                                                             |Piece up    |      |
|<- |4496994f-|1782 |Nbd2 |d2d                                                             |Piece down  |      |
|<- |777ac5a4-|1783 |     |1100001101000011010010011101100110100011111101110100000011000011|Board status|      |
|-> |f9664d70-|1784 |Bd7  |2,7:3.08,5.92\|                                                 |Move piece  |      |
|<- |f9664d70-|1785 |     |                                                                |Got 1784    |      |
|<- |4496994f-|1786 |     |OK                                                              |            |      |
|<- |777ac5a4-|1787 |     |1100001101000011010010001101101110100011111100110100000011000011|Board status|      |
|<- |777ac5a4-|1788 |     |1100001101000011010010001101101110100011111100110100000011000011|Board status|      |
|<- |777ac5a4-|1789 |     |1100001101000011010010001101101110100011111100110100000011000011|Board status|      |
|<- |777ac5a4-|1790 |     |1100001101000011010010001101101110100011111100110100000011000011|Board status|      |
|<- |4496994f-|1791 |Ne5  |f3u                                                             |Piece up    |      |
|<- |777ac5a4-|1792 |     |1100001101000011010010001101101110100011110100110100000011000011|Board status|      |
|<- |4496994f-|1793 |Ne5  |e5d                                                             |Piece down  |      |
|-> |f9664d70-|1794 |c4   |2,4:2,2.92\|                                                    |Move piece  |      |
|<- |f9664d70-|1795 |     |                                                                |Got 1794    |      |
|<- |4496994f-|1796 |     |OK                                                              |            |      |
|<- |777ac5a4-|1797 |     |1100001101000011010100001101100110101011110100110100000011000011|Board status|      |
|<- |4496994f-|1798 |     |d7u                                                             |Piece       |Adjust|
|<- |777ac5a4-|1799 |     |1100001101000011010100001101100110101011110100110100000011000011|Board status|      |
|<- |4496994f-|1800 |     |d7d                                                             |Piece down  |Adjust|
|<- |4496994f-|1801 |     |d7u                                                             |Piece up    |Adjust|
|<- |4496994f-|1802 |     |d7d                                                             |Piece down  |Adjust|
|<- |4496994f-|1803 |     |d7u                                                             |Piece up    |Adjust|
|<- |4496994f-|1804 |     |d7d                                                             |Piece down  |Adjust|
|<- |777ac5a4-|1805 |     |1100001101000011010100001101101110101011110100110100000011000011|Board status|      |
|<- |777ac5a4-|1806 |     |1100001101000011010100001101101110101011110100110100000011000011|Board status|      |
|<- |777ac5a4-|1807 |     |1100001101000011010100001101101110101011110100110100000011000011|Board status|      |
|<- |777ac5a4-|1808 |     |1100001101000011010100001101101110101011110100110100000011000011|Board status|      |
|<- |777ac5a4-|1809 |     |1100001101000011010100001101101110101011110100110100000011000011|Board status|      |
|<- |6e400003-|1810 |     |4#3752.50*                                                      |            |      |
|<- |777ac5a4-|1812 |     |1100001101000011010100001101101110101011110100110100000011000011|Board status|      |
|<- |777ac5a4-|1813 |     |1100001101000011010100001101101110101011110100110100000011000011|Board status|      |
|<- |777ac5a4-|1815 |     |1100001101000011010100001101101110101011110100110100000011000011|Board status|      |
|<- |777ac5a4-|1816 |     |1100001101000011010100001101101110101011110100110100000011000011|Board status|      |
|<- |4496994f-|1817 |Be2  |f1u                                                             |Piece up    |      |
|<- |4496994f-|1818 |Be2  |e2d                                                             |Piece down  |      |
|<- |777ac5a4-|1819 |     |1100001101000011010100001101101111101011010100110100000011000011|Board status|      |
|-> |f9664d70-|1820 |Be6  |3,6:4.08,4.92\|                                                 |Move piece  |      |
|<- |f9664d70-|1821 |     |                                                                |Got 1820    |      |
|<- |4496994f-|1822 |     |OK                                                              |            |      |
|<- |777ac5a4-|1823 |     |1100001101000011010100001101100111101111010100110100000011000011|Board status|      |
|<- |777ac5a4-|1824 |     |1100001101000011010100001101100111101111010100110100000011000011|Board status|      |
|<- |777ac5a4-|1825 |     |1100001101000011010100001101100111101111010100110100000011000011|Board status|      |
|<- |4496994f-|1826 |c3   |c2u                                                             |Piece up    |      |
|<- |4496994f-|1827 |c3   |c3d                                                             |Piece down  |      |
|<- |777ac5a4-|1828 |     |1100001101000011001100001101100111101111010100110100000011000011|Board status|      |
|-> |f9664d70-|1829 |Nh5  |5,5:6,5:7.08,3.92\|                                             |Move piece  |      |
|<- |f9664d70-|1830 |     |                                                                |Got 1829    |      |
|<- |4496994f-|1831 |     |OK                                                              |            |      |
|<- |777ac5a4-|1832 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1833 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1834 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1835 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1837 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1838 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1839 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1840 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1841 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1842 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1843 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1844 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1845 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1846 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1847 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1848 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1849 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1850 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1851 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1852 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1853 |     |1100001101000011001100001101100111101111010100110100000011001011|Board status|      |
|<- |4496994f-|1854 |Qa4+ |d1u                                                             |Piece up    |      |
|<- |4496994f-|1855 |Qa4+ |a4d                                                             |Piece down  |      |
|<- |777ac5a4-|1856 |     |1101001101000011001100000101100111101111010100110100000011001011|Board status|      |
|-> |f9664d70-|1857 |Qd7  |3,7:3,5.92\|                                                    |Move piece  |      |
|<- |f9664d70-|1858 |     |                                                                |Got 1857    |      |
|<- |4496994f-|1859 |     |OK                                                              |            |      |
|<- |777ac5a4-|1860 |     |1101001101000011001100000101101011101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1861 |     |1101001101000011001100000101101011101111010100110100000011001011|Board status|      |
|<- |777ac5a4-|1862 |     |1101001101000011001100000101101011101111010100110100000011001011|Board status|      |
|<- |4496994f-|1863 |Nxd7 |e5u                                                             |Piece up    |      |
|<- |4496994f-|1864 |Nxd7 |d7u                                                             |Piece up    |      |
|<- |777ac5a4-|1865 |     |1101001101000011001100000101100011100111010100110100000011001011|Board status|      |
|<- |4496994f-|1866 |Nxd7 |d7d                                                             |Piece down  |      |
|<- |777ac5a4-|1867 |     |1101001101000011001100000101101011100111010100110100000011001011|Board status|      |
|-> |f9664d70-|1868 |g6   |6,6:6,4.92\|                                                    |Move piece  |      |
|<- |f9664d70-|1869 |     |                                                                |Got 1868    |      |
|<- |4496994f-|1871 |     |OK                                                              |            |      |
|<- |777ac5a4-|1872 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1873 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1874 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1875 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1876 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1877 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1878 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1879 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1880 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1881 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1882 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1883 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1884 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1885 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |777ac5a4-|1886 |     |1101001101000011001100000101101011100111010100110100010011001011|Board status|      |
|<- |4496994f-|1887 |Nf6+ |d7u                                                             |Piece up    |      |
|<- |777ac5a4-|1888 |     |1101001101000011001100000101100011100111010100110100010011001011|Board status|      |
|<- |4496994f-|1889 |Nf6+ |f6d                                                             |Piece down  |      |
|<- |777ac5a4-|1890 |     |1101001101000011001100000101100011100111010101110100010011001011|Board status|      |
|-> |f9664d70-|1891 |Kd8  |4,7:2.92,7\|                                                    |Move piece  |      |
|<- |f9664d70-|1892 |     |                                                                |Got 1891    |      |
|<- |4496994f-|1893 |     |OK                                                              |            |      |
|<- |777ac5a4-|1894 |     |1101001101000011001100000101100111100110010101110100010011001011|Board status|      |
|<- |6e400003-|1895 |     |4#3792.00*                                                      |            |      |
|<- |777ac5a4-|1897 |     |1101001101000011001100000101100111100110010101110100010011001011|Board status|      |
|<- |777ac5a4-|1898 |     |1101001101000011001100000101100111100110010101110100010011001011|Board status|      |
|<- |777ac5a4-|1899 |     |1101001101000011001100000101100111100110010101110100010011001011|Board status|      |
|<- |4496994f-|1900 |Qe8# |a4u                                                             |Piece up    |      |
|<- |4496994f-|1901 |Qe8# |e8d                                                             |Piece down  |      |
|<- |777ac5a4-|1902 |     |1100001101000011001100000101100111100111010101110100010011001011|Board status|      |
|<- |4496994f-|1903 |     |e8u                                                             |Piece up    |Adjust|
|-> |c7d64c44-|1904 |     |S:wt                                                            |            |      |
|<- |c7d64c44-|1905 |     |                                                                |Got 1904    |      |
|<- |777ac5a4-|1908 |     |1100001101000011001100000101100111100110010101110100010011001011|Board status|      |
|<- |777ac5a4-|1909 |     |1100001101000011001100000101100111100110010101110100010011001011|Board status|      |
|-> |6e400002-|1910 |     |14#3*                                                           |            |      |
|<- |4496994f-|1912 |     |e8d                                                             |Piece down  |Adjust|
|<- |4496994f-|1913 |     |e8u                                                             |Piece up    |Adjust|
|<- |777ac5a4-|1914 |     |1100001101000011001100000101100111100110010101110100010011001011|Board status|      |
|<- |4496994f-|1915 |     |e8d                                                             |Piece down  |Adjust|
|<- |777ac5a4-|1916 |     |1100001101000011001100000101100111100111010101110100010011001011|Board status|      |
|<- |4496994f-|1917 |     |e8u                                                             |Piece up    |Adjust|
|<- |4496994f-|1918 |     |e8d                                                             |Piece down  |Adjust|
|<- |4496994f-|1919 |     |e8u                                                             |Piece up    |Adjust|
|<- |777ac5a4-|1920 |     |1100001101000011001100000101100111100110010101110100010011001011|Board status|      |
|<- |777ac5a4-|1922 |     |1100001101000011001100000101100111100110010101110100010011001011|Board status|      |
|<- |777ac5a4-|1923 |     |1100001101000011001100000101100111100110010101110100010011001011|Board status|      |



