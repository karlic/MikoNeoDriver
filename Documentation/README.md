# MikoNeoDriver Documentation and Useful Information
Files in this folder include documentation on how the driver works, how the Miko Neo chess board works
and information that is useful in getting the two to work together.

(I refer to the *Miko* Neo chess board as it is a Square Off Neo board that has been flashed with the 
latest firmware from the Miko iPhone app.)

## Other Useful Sites
https://github.com/mono424/squareoffdriver The inspiration for this driver. Pretty much everything here
as been taken from his work.

https://github.com/mrquincle/squareoff Some information on the protocol used, which partly matches the findings from the Wireshark capture.


## MikoNeoBoardBLETraffic.pcapng
This file is a Wireshark capture of the bluetooth traffic between the Miko iPhone app and a (formerly)
Square Off Neo board flashed with the latest Miko firmware. It can be read by installing Wireshark
and doing File | Open.

There were thousands(?) of empty packets that have been deleted from this capture.

The capture includes traffic from before the app connects to the board. I *think* these can be filtered
out by using the filter btatt in the "Apply a display filter" bar.

## MikoNeoBoard.png
This is a record of the moves made in capturing the file MikoNeoBoardBLETraffic.pcapng, in .png format.
The game was played by a human (White) against the Miko iPhone app. The game can be viewed by uploading
it to a chess app or website such as https://chesstempo.com/pgn-viewer/

## MikoNeoBoard.txt
The same as MikoNeoBoard.png, but just the moves in plain text for humans to read.

## MikoNeoBoardProtocol.md
This is what is known so far about how the Miko app communicates with the Miko Neo board.

