import 'package:MikoNeoDriver/protocol/Command.dart';

class MovePiece extends Command<void> {
  final String code = "";
  String? body = "";

  //TODO: IF there's a piece on target square get rid of it!
  MovePiece(List<String> moveFromTo, Map<String, bool> lastData) {
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
    List<double> fromXY = pgnToXy(moveFromTo[0]);
    List<double> toXY = pgnToXy(moveFromTo[1]);
    //We always start moves from the start square
    body = fromXY[0].toString() + "," + fromXY[1].toString() + ":";
    //Knights need to avoid hitting other pieces. They move in an 'L' shape, so
    //the square moved to is 2 squares to the side and 1 above/below or
    //vice versa.
    if (diff(fromXY[0], toXY[0]) == 1 && diff(fromXY[1], toXY[1]) == 2) {
      //Knight is moving in vertical L shape
      print("We got a vertical knight move.");
      print(lastData);
      print(lastData['e4']);
      print(lastData['e5']);

      //if 2 squares above/below end empty move horizontal then end
      //Moves are: x,y:x',y:x',y'
      if (!lastData[xYToPgn([toXY[0], fromXY[1]])]! &&
          !lastData[xYToPgn([toXY[0], (fromXY[1] + toXY[1]) / 2])]!) {
        body = body! + toXY[0].toString() + "," + fromXY[1].toString();
      } else

      //if 2 squares above/below start empty move to 2nd square then end
      //Moves are: x,y:x,y':x',y'
      if (!lastData[xYToPgn([fromXY[0], toXY[1]])]! &&
          !lastData[xYToPgn([fromXY[0], (fromXY[1] + toXY[1]) / 2])]!) {
        body = body! + fromXY[0].toString() + "," + toXY[1].toString();
      } else
      //if 1 square above/below end empty move to it then end
      //Moves are: x,y:x',(y + y') / 2:x',y'
      if (!lastData[xYToPgn([toXY[0], (fromXY[1] + toXY[1]) / 2])]!) {
        body = body! +
            toXY[0].toString() +
            "," +
            ((fromXY[1] + toXY[1]) / 2).toString();
      }
      //else move to corner nearest target then corner then target
      //Moves are x,y:(x + x') / 2,y + (0.5 * sign(y' - y)):(x + x') / 2,y+ (1.5 * sign(y' - y))
      else {
        body = body! +
            ((fromXY[0] + toXY[0]) / 2).toString() +
            "," +
            (fromXY[1] + (0.5 * (toXY[1] - fromXY[1]).sign)).toString() +
            ":" +
            ((fromXY[0] + toXY[0]) / 2).toString() +
            "," +
            (fromXY[1] + (1.5 * (toXY[1] - fromXY[1]).sign)).toString();
      }
    } else if (diff(fromXY[0], toXY[0]) == 2 && diff(fromXY[1], toXY[1]) == 1) {
      //Knight is moving in horizontal L shape
      print("We got a horizontal knight move.");
      //If 2 squares left/right of start empty, 2nd square left/right, then end
      //Moves: x,y:x',(y + y') / 2:x',y'
      if (!lastData[xYToPgn([toXY[0], fromXY[1]])]! &&
          !lastData[xYToPgn([(fromXY[0] + toXY[0]) / 2, fromXY[1]])]!) {
        body = body! +
            toXY[0].toString() +
            "," +
            ((fromXY[1] + toXY[1]) / 2).toString();
      } else
      //If 2 squares left/right of end empty, 1st square left/right, then end
      //Moves: x,y:x,y':x',y'
      if (!lastData[xYToPgn([fromXY[0], toXY[1]])]! &&
          !lastData[xYToPgn([(fromXY[0] + toXY[0]) / 2, toXY[1]])]!) {
        body = body! + fromXY[0].toString() + "," + toXY[1].toString();
      } else
      //If 1 square left/right of end empty, empty square, then end
      //Moves: x,y:(x + x') / 2,y':x',y'
      if (!lastData[xYToPgn([(fromXY[0] + toXY[0]) / 2, toXY[1]])]!) {
        body = body! +
            ((fromXY[0] + toXY[0]) / 2).toString() +
            "," +
            toXY[1].toString();
        //else corner nearest target, then corner, then end
        //Moves: x,y:x + (0.5 * sign(x' - x)),(y + y') / 2:x + (1.5 * sign(x' - x)),(y + y') / 2:x',y'
      } else {
        body = body! +
            (fromXY[0] + (0.5 * (toXY[0] - fromXY[0]).sign)).toString() +
            "," +
            ((fromXY[1] + toXY[1]) / 2).toString() +
            ":" +
            (fromXY[0] + (1.5 * (toXY[0] - fromXY[0]).sign)).toString() +
            "," +
            ((fromXY[1] + toXY[1]) / 2).toString();
      }
    }
    //We always finish moves on the target square
    body = body! + ":" + toXY[0].toString() + "," + toXY[1].toString() + "|";
  }

  //Gets the absolute difference between two numbers. Used to find the distance
  //between two squares to identify knight moves.
  double diff(double a, double b) {
    if (a < b) {
      return b - a;
    }
    return a - b;
  }

  List<double> pgnToXy(String pgn) {
    double x = pgn.codeUnitAt(0) - 97; //converts a to 0; b to 1; ...
    double y = pgn.codeUnitAt(1) - 49; //converts 1 to 0; 2 to 1; ...
    return [x, y];
  }

  String xYToPgn(List<double> xyCoords) {
    return String.fromCharCode(xyCoords[0].round() + 97) +
        String.fromCharCode(xyCoords[1].round() + 49);
  }
}
