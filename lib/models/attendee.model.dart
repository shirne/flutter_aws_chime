import 'common.dart';
import 'video_tile.model.dart';

class AttendeeModel {
  AttendeeModel(
    this.attendeeId,
    this.externalUserId, {
    DateTime? joinedAt,
  }) : joinedAt = joinedAt ?? DateTime.now();

  AttendeeModel.fromJson(Json json)
      : this(
          as<String>(json["attendeeId"]) ?? '',
          as<String>(json["externalUserId"]) ?? '',
        );

  final String attendeeId;
  final String externalUserId;

  bool muteStatus = true;
  bool isVideoOn = false;

  VideoTileModel? videoTile;
  final DateTime joinedAt;
}
