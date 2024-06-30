import 'package:MikoNeoDriver/protocol/Command.dart';

class MovePiece extends Command<void> {
  final String code = "";
  String? body = "";

  MovePiece(List<String> moveFromTo) {
    body = "2,6:2,4.92|";
  }
}
