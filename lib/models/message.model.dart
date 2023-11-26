import 'common.dart';

class MessageModel {
  MessageModel(
    this.attendeeId,
    this.externalUserId,
    this.message,
    this.topic,
    this.timestampMs, {
    this.throttled,
  });

  MessageModel.fromJson(Json json)
      : this(
          json["attendeeId"],
          json["externalUserId"],
          json['message'],
          json['topic'],
          json['timestampMs'],
          throttled: json['throttled'],
        );

  final String attendeeId;
  final String externalUserId;
  final String message;
  final bool? throttled;
  final String topic;
  final num timestampMs;
}

class MessageSendModel {
  MessageSendModel(this.topic, this.message, {this.lifetimeMs});

  MessageSendModel.fromJson(Json json)
      : this(
          json["topic"],
          json["message"],
          lifetimeMs: json['lifetimeMs'],
        );

  final String topic;
  final String message;
  final num? lifetimeMs;
}
