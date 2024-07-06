import 'package:MikoNeoDriver/protocol/Answer.dart';
import 'package:MikoNeoDriver/protocol/Command.dart';

class GetReady extends Command<bool> {
  final String code = "14";
  final String body = "3";
  final Answer<bool> answer = Ready();
}

class Ready extends Answer<bool> {
  final String code = "14";

  @override
  bool process(String? msg) {
    //We don't actually need this. Neo does NOT send "GO".
    return msg!.split("#")[1] == "GO*";
  }
}
