import 'package:MikoNeoDriver/Miko.dart';
import 'package:MikoNeoDriver/protocol/Answer.dart';
import 'package:MikoNeoDriver/protocol/Command.dart';

class GetBoard extends Command<Map<String, bool>> {
  final String code = "30";
  final String body = "R";
  final Answer<Map<String, bool>> answer = BoardStateMessage();
}

class BoardStateMessage extends Answer<Map<String, bool>> {
  final String code = "30";

  @override
  Map<String, bool> process(String? msg) {
    List<bool> rawBoard =
        msg!.split("#")[1].split("").map((e) => e == "1").toList();
    Map<String, bool> board = {};
    for (var i = 0; i < Miko.squares.length; i++) {
      board[Miko.squares[i]] = rawBoard[i];
    }
    return board;
  }
}
