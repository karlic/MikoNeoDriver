import 'dart:async';
import 'package:MikoNeoDriver/MikoCommunicationClient.dart';
import 'package:MikoNeoDriver/MikoMessage.dart';
import 'package:MikoNeoDriver/protocol/commands/FieldUpdate.dart';
import 'package:MikoNeoDriver/protocol/commands/GetBoard.dart';
import 'package:MikoNeoDriver/protocol/commands/RequestMacAddress.dart';
import 'package:MikoNeoDriver/protocol/commands/NewGame.dart';
import 'package:MikoNeoDriver/protocol/commands/GetReady.dart';
import 'package:MikoNeoDriver/protocol/commands/RequestBattery.dart';
import 'package:MikoNeoDriver/protocol/commands/SetLeds.dart';
import 'package:MikoNeoDriver/protocol/commands/MovePiece.dart';
import 'package:MikoNeoDriver/protocol/commands/TriggerGameEvent.dart';
import 'package:MikoNeoDriver/protocol/commands/TriggerGameEventColon.dart';
import 'package:MikoNeoDriver/protocol/model/BatteryStatus.dart';
import 'package:MikoNeoDriver/protocol/model/GameEvent.dart';
import 'package:MikoNeoDriver/protocol/model/MacAddress.dart';
import 'package:MikoNeoDriver/protocol/model/PieceUpdate.dart';
import 'package:MikoNeoDriver/protocol/model/RequestConfig.dart';

class Miko {
  MikoCommunicationClient? _client;
  MikoCommunicationClient? _clientPM;
  MikoCommunicationClient? _clientColonBS;

  StreamController? _inputStreamController;
  StreamController? _inputStreamControllerPM;
  StreamController? _inputStreamControllerColonBS;
  Stream<MikoMessage>? _inputStream;
  Stream<MikoMessage>? _inputStreamPM;
  Stream<MikoMessage>? _inputStreamColonBS;
  List<int>? _buffer;
  List<int>? _bufferPM;
  List<int>? _bufferColonBS;
  String? _version;

  static List<String> squares = [
    'a1',
    'a2',
    'a3',
    'a4',
    'a5',
    'a6',
    'a7',
    'a8',
    'b1',
    'b2',
    'b3',
    'b4',
    'b5',
    'b6',
    'b7',
    'b8',
    'c1',
    'c2',
    'c3',
    'c4',
    'c5',
    'c6',
    'c7',
    'c8',
    'd1',
    'd2',
    'd3',
    'd4',
    'd5',
    'd6',
    'd7',
    'd8',
    'e1',
    'e2',
    'e3',
    'e4',
    'e5',
    'e6',
    'e7',
    'e8',
    'f1',
    'f2',
    'f3',
    'f4',
    'f5',
    'f6',
    'f7',
    'f8',
    'g1',
    'g2',
    'g3',
    'g4',
    'g5',
    'g6',
    'g7',
    'g8',
    'h1',
    'h2',
    'h3',
    'h4',
    'h5',
    'h6',
    'h7',
    'h8'
  ];

  String? get version => _version;

  Miko();

  Future<void> init(MikoCommunicationClient client,
      MikoCommunicationClient clientPM, MikoCommunicationClient clientColonBS,
      {Duration initialDelay = const Duration(milliseconds: 300)}) async {
    _client = client;
    _clientPM = clientPM;
    _clientColonBS = clientColonBS;

    _client?.receiveStream?.listen(_handleInputStream);
    _clientPM?.receiveStream?.listen(_handleInputStreamPM);
    _clientColonBS?.receiveStream?.listen(_handleInputStreamColonBS);
    _inputStreamController = new StreamController<MikoMessage>();
    _inputStreamControllerPM = new StreamController<MikoMessage>();
    _inputStreamControllerColonBS = new StreamController<MikoMessage>();
    _inputStream = _inputStreamController?.stream.asBroadcastStream()
        as Stream<MikoMessage>?;
    _inputStreamPM = _inputStreamControllerPM?.stream.asBroadcastStream()
        as Stream<MikoMessage>?;
    _inputStreamColonBS = _inputStreamControllerColonBS?.stream
        .asBroadcastStream() as Stream<MikoMessage>?;
    await Future.delayed(initialDelay);
  }

  void _handleInputStream(List<int> chunk) {
    print("R > " + chunk.map((n) => String.fromCharCode(n & 127)).toString());
    if (_buffer == null) {
      _buffer = chunk.toList();
    } else {
      _buffer?.addAll(chunk);
    }

    if (_buffer!.length > 1000) {
      _buffer?.removeRange(0, _buffer!.length - 1000);
    }

    do {
      try {
        MikoMessage message = MikoMessage.parse(_buffer!);
        _buffer?.removeRange(0, message.getLength()! - 1);
        _inputStreamController?.add(message);
        // print("[IMessage] valid (" + message.getCode() + ")");
      } on MikoInvalidMessageException catch (e) {
        skipBadBytes(e.skipBytes, _buffer!);
        // print("[IMessage] invalid");
      } on MikoUncompleteMessage {
        // wait longer
        break;
      } catch (err) {
        print("Unknown parse-error: " + err.toString());
        _buffer = [];
        break;
      }
    } while (_buffer!.length > 0);
  }

  void _handleInputStreamPM(List<int> chunk) {
    print("R > " + chunk.map((n) => String.fromCharCode(n & 127)).toString());
    if (_bufferPM == null) {
      _bufferPM = chunk.toList();
    } else {
      _bufferPM?.addAll(chunk);
    }

    if (_bufferPM!.length > 1000) {
      _bufferPM?.removeRange(0, _bufferPM!.length - 1000);
    }

    do {
      try {
        MikoMessage message = MikoMessage.parse(_bufferPM!);
        _bufferPM?.removeRange(0, message.getLength()! - 1);
        _inputStreamControllerPM?.add(message);
        // print("[IMessage] valid (" + message.getCode() + ")");
      } on MikoInvalidMessageException catch (e) {
        skipBadBytes(e.skipBytes, _bufferPM!);
        // print("[IMessage] invalid");
      } on MikoUncompleteMessage {
        // wait longer
        break;
      } catch (err) {
        print("Unknown parse-error: " + err.toString());
        _bufferPM = [];
        break;
      }
    } while (_bufferPM!.length > 0);
  }

  void _handleInputStreamColonBS(List<int> chunk) {
    print("R > " + chunk.map((n) => String.fromCharCode(n & 127)).toString());
    if (_bufferColonBS == null) {
      _bufferColonBS = chunk.toList();
    } else {
      _bufferColonBS?.addAll(chunk);
    }

    if (_bufferColonBS!.length > 1000) {
      _bufferColonBS?.removeRange(0, _bufferColonBS!.length - 1000);
    }

    do {
      try {
        MikoMessage message = MikoMessage.parse(_bufferColonBS!);
        _bufferColonBS?.removeRange(0, message.getLength()! - 1);
        _inputStreamControllerColonBS?.add(message);
        // print("[IMessage] valid (" + message.getCode() + ")");
      } on MikoInvalidMessageException catch (e) {
        skipBadBytes(e.skipBytes, _bufferColonBS!);
        // print("[IMessage] invalid");
      } on MikoUncompleteMessage {
        // wait longer
        break;
      } catch (err) {
        print("Unknown parse-error: " + err.toString());
        _bufferColonBS = [];
        break;
      }
    } while (_bufferColonBS!.length > 0);
  }

  Stream<MikoMessage>? getInputStream() {
    return _inputStream;
  }

  Stream<MikoMessage>? getInputStreamPM() {
    return _inputStreamPM;
  }

  Stream<MikoMessage>? getInputStreamColonBS() {
    return _inputStreamColonBS;
  }

  void skipBadBytes(int start, List<int> buffer) {
    buffer.removeRange(0, start);
  }

  Stream<FieldUpdate> getFieldUpdateStream() {
    return getInputStream()!
        .where((MikoMessage msg) => msg.getCode() == FieldUpdateAnswer().code)
        .map((MikoMessage msg) =>
            FieldUpdateAnswer().process(msg.getMessage()!));
  }

  Stream<Map<String, bool>> getBoardUpdateStream() {
    return getInputStream()!
        .where((MikoMessage msg) => msg.getCode() == BoardStateMessage().code)
        .map((MikoMessage msg) =>
            BoardStateMessage().process(msg.getMessage()!));
  }

  Future<bool?> newGame(
      {RequestConfig config =
          const RequestConfig(0, const Duration(seconds: 5))}) {
    return NewGame().request(_client!, _inputStream!, config);
  }

  Future<bool?> getReady(
      {RequestConfig config =
          const RequestConfig(0, const Duration(seconds: 5))}) {
    return GetReady().request(_client!, _inputStream!, config);
  }

  Future<Map<String, bool>?> getBoard(
      {RequestConfig config =
          const RequestConfig(0, const Duration(seconds: 5))}) {
    return GetBoard().request(_client!, _inputStream!, config);
  }

  Future<MacAddress?> getMacAddress(
      {RequestConfig config =
          const RequestConfig(0, const Duration(seconds: 5))}) {
    return RequestMacAddress().request(_client!, _inputStream!, config);
  }

  Future<BatteryStatus?> getBatteryStatus(
      {RequestConfig config =
          const RequestConfig(0, const Duration(seconds: 5))}) {
    return RequestBattery().request(_client!, _inputStream!, config);
  }

  Future<void> setLeds(List<String> squares) {
    return SetLeds(squares).send(_client!);
  }

  Future<void> triggerGameEvent(GameEvent event) {
    return TriggerGameEvent(event).send(_client!);
  }

  Future<void> triggerGameEventColon(GameEvent event) {
    return TriggerGameEventColon(event).send(_clientColonBS!);
  }

  Future<void> movePiece(List<String> moveFromTo, bool isKnight) {
    return MovePiece(moveFromTo, isKnight).request(_clientPM!, _inputStreamPM!);
  }
}
