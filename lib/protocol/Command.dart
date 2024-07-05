import 'package:MikoNeoDriver/MikoMessage.dart';
import 'package:MikoNeoDriver/MikoCommunicationClient.dart';
import 'package:MikoNeoDriver/protocol/Answer.dart';
import 'package:MikoNeoDriver/protocol/model/RequestConfig.dart';

abstract class Command<T> {
  String? code;
  String? body;
  Answer<T>? answer;

  Future<String> messageBuilder() async {
    if (body!.contains("|") | body!.contains(":")) {
      return body!;
    }
    return code! + "#" + body! + "*";
  }

  Future<void> send(MikoCommunicationClient client) async {
    String messageString = await messageBuilder();
    List<int> message = messageString.codeUnits;
    await client.send(message);
  }

  Future<T?> request(
      MikoCommunicationClient client, Stream<MikoMessage> inputStream,
      [RequestConfig config = const RequestConfig()]) async {
    Future<T?> result = getReponse(inputStream);
    try {
      await send(client);
      T? resultValue = await result.timeout(config.timeout);
      return resultValue;
    } catch (e) {
      if (config.retries <= 0) {
        throw e;
      }
      await Future.delayed(config.retryDelay);
      return request(client, inputStream, config.withDecreasedRetry());
    }
  }

  Future<T?> getReponse(Stream<MikoMessage> inputStream) async {
    if (answer == null) return null;
    MikoMessage message = await inputStream
        .firstWhere((MikoMessage msg) => msg.getCode() == answer?.code);
    return answer!.process(message.getMessage());
  }
}
