//import 'dart:convert';

class MikoMessage {
  String? _code;
  int? _length;
  String? _message;

  MikoMessage.parse(List<int> buffer, {bool checkParity = true}) {
    List<String> asciiChars =
        buffer.map((n) => String.fromCharCode(n)).toList();

    int end = -1;
    for (var i = 0; i < asciiChars.length; i++) {
      if (asciiChars[i] == "*") {
        end = i;
        break;
      }
    }

    if (end == -1) throw MikoUncompleteMessage();
    if (asciiChars.indexOf("#") < 1) {
      // no code in message
      throw MikoInvalidMessageException(asciiChars.length);
    }

    String message = asciiChars.sublist(0, end + 1).join("");

    _code = message.split("#")[0];
    _length = message.length;
    _message = message;
  }

  String? getCode() {
    return _code;
  }

  int? getLength() {
    return _length;
  }

  String? getMessage() {
    return _message;
  }
}

class MikoUncompleteMessage implements Exception {}

class MikoInvalidMessageException implements Exception {
  final int skipBytes;

  MikoInvalidMessageException(this.skipBytes);
}
