import 'package:MikoNeoDriver/protocol/Command.dart';

class MovePiece extends Command<void> {
  final String code = "";
  String? body = "";

  MovePiece(List<String> moveFromTo, bool isKnight) {
    //We receive two (and only two) strings in the list: the start (or "up")
    //square and the end (or "down") square in PGN format (a1--h8).
    //(In the WhitePawn app these may be suffixed with "u" and "d" respectively
    //and this will need to be accounted for.)
    //The two squares need to be converted to x,y format (0,0--7,7), separated
    //by a colon and suffixed with a pipe symbol.
    //E.g., ["c7,"c6"] in becomes "2,6:2,4.92|" out
    //For some reason the y coord of the "down" square is reduced by 0.08 in
    //the Miko app. I assume this is allow for deceleration of the piece??

    //Knight moves have to be more complicated to avoid bumping into other
    //pieces.

    //TODO: if length of moveFromTo > 2 throw an exception
    String moveFrom = moveFromTo[0]; //First in list is the "up" square
    String moveTo = moveFromTo[1]; //Second in list is the "down" square
    double fromX = moveFrom.codeUnitAt(0) - 97; //converts a to 0; b to 1; ...
    double fromY = moveFrom.codeUnitAt(1) - 49; //converts 1 to 0; 2 to 1; ...
    double toX = moveTo.codeUnitAt(0) - 97; //converts a to 0; b to 1; ...
    double toY =
        moveTo.codeUnitAt(1) - 49 - 0.08; //converts 1 to 0; 2 to 1; ...
    //Knights need to avoid hitting other pieces.
    if (isKnight) {
      //Do some clever stuff.
    }
    body = fromX.toString() +
        "," +
        fromY.toString() +
        ":" +
        toX.toString() +
        "," +
        toY.toString() +
        "|";
  }
}
