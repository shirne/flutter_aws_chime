import 'common.dart';

class JoinInfo {
  JoinInfo(this.meeting, this.attendee);

  JoinInfo.fromJson(Json json)
      : this(
          MeetingInfo.fromJson(json['meeting']),
          AttendeeInfo.fromJson(json['attendee']),
        );

  final MeetingInfo meeting;

  final AttendeeInfo attendee;

  Map<String, dynamic> toJson() => {
        "MeetingId": meeting.meetingId,
        "ExternalMeetingId": meeting.externalMeetingId,
        "MediaRegion": meeting.mediaRegion,
        "AudioHostUrl": meeting.mediaPlacement.audioHostUrl,
        "AudioFallbackUrl": meeting.mediaPlacement.audioFallbackUrl,
        "SignalingUrl": meeting.mediaPlacement.signalingUrl,
        "TurnControlUrl": meeting.mediaPlacement.turnControllerUrl,
        "ExternalUserId": attendee.externalUserId,
        "AttendeeId": attendee.attendeeId,
        "JoinToken": attendee.joinToken,
      };
}

class MeetingInfo {
  MeetingInfo(
    this.meetingId,
    this.externalMeetingId,
    this.mediaRegion,
    this.mediaPlacement,
  );

  MeetingInfo.fromJson(Json json)
      : this(
          json['MeetingId'],
          json['ExternalMeetingId'],
          json['MediaRegion'],
          MediaPlacement.fromJson(json['MediaPlacement']),
        );

  final String meetingId;
  final String externalMeetingId;
  final String mediaRegion;
  final MediaPlacement mediaPlacement;
}

class AttendeeInfo {
  AttendeeInfo(this.externalUserId, this.attendeeId, this.joinToken);

  AttendeeInfo.fromJson(Map<String, dynamic> json)
      : this(
          json['ExternalUserId'],
          json['AttendeeId'],
          json['JoinToken'],
        );

  final String externalUserId;
  final String attendeeId;
  final String joinToken;
}

class MediaPlacement {
  MediaPlacement(
    this.audioHostUrl,
    this.audioFallbackUrl,
    this.signalingUrl,
    this.turnControllerUrl,
  );

  MediaPlacement.fromJson(Map<String, dynamic> json)
      : this(
          json['AudioHostUrl'],
          json['AudioFallbackUrl'],
          json['SignalingUrl'],
          json['TurnControlUrl'],
        );

  final String audioHostUrl;
  final String audioFallbackUrl;
  final String signalingUrl;
  final String turnControllerUrl;
}
