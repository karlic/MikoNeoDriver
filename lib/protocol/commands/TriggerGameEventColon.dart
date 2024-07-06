import 'package:MikoNeoDriver/protocol/Command.dart';
import 'package:MikoNeoDriver/protocol/model/GameEvent.dart';

class TriggerGameEventColon extends Command<void> {
  final String code = "";
  String? body;

  TriggerGameEventColon(GameEvent event) {
    switch (event) {
      case GameEvent.kingInCheck:
        body = "S:ck";
        return;
      case GameEvent.blackWins:
        body = "S:bl";
        return;
      case GameEvent.whiteWins:
        body = "S:wt";
        return;
      case GameEvent.draw:
        body = "S:dw";
        return;
      case GameEvent.po:
        body = "S:po";
        return;
      default:
        throw new ArgumentError("Unknown event: $event");
    }
  }
}
