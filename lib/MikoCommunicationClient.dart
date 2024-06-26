import 'dart:async';

class MikoCommunicationClient {
  final Future<void> Function(List<int>) send;
  final StreamController<List<int>> _inputStreamController =
      StreamController<List<int>>();

  Stream<List<int>>? _receiveStream;
  Stream<List<int>>? get receiveStream {
    if (_receiveStream == null) {
      _receiveStream = _inputStreamController.stream.asBroadcastStream();
    }
    return _receiveStream;
  }

  MikoCommunicationClient(this.send);

  void handleReceive(List<int> message) {
    _inputStreamController.add(message);
  }
}
