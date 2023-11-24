import 'package:flutter/material.dart';

import 'package:flutter_aws_chime/models/join_info.model.dart';
import 'package:flutter_aws_chime/views/meeting.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: MeetingView(
            JoinInfo(
              MeetingInfo.fromJson({
                'MeetingId': '',
                'ExternalMeetingId': '',
                'MediaRegion': 'us-east-1',
                'MediaPlacement': {
                  "AudioFallbackUrl": "",
                  "AudioHostUrl": "",
                  "EventIngestionUrl": "",
                  "ScreenDataUrl": "",
                  "ScreenSharingUrl": "",
                  "ScreenViewingUrl": "",
                  "SignalingUrl": "",
                  "TurnControlUrl": ""
                },
              }),
              AttendeeInfo.fromJson(
                  {"AttendeeId": "", "ExternalUserId": "", "JoinToken": ""}),
            ),
          ),
        ),
      ),
    );
  }
}
