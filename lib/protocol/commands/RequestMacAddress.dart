import 'package:MikoNeoDriver/protocol/Answer.dart';
import 'package:MikoNeoDriver/protocol/Command.dart';
import 'package:MikoNeoDriver/protocol/model/MacAddress.dart';

class RequestMacAddress extends Command<MacAddress> {
  final String code = "1";
  final String body = "";
  final Answer<MacAddress> answer = MacAddressAnswer();
}

class MacAddressAnswer extends Answer<MacAddress> {
  final String code = "1";

  @override
  MacAddress process(String? msg) {
    print(msg);
    return MacAddress(msg!.split("#")[1].replaceAll("*", ""));
  }
}
