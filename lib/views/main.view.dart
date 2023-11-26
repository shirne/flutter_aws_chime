import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import '../models/attendee.model.dart';
import '../models/meeting.model.dart';
import '../models/meeting.theme.model.dart';
import '../models/video_tile.model.dart';
import 'content_share.view.dart';
import 'videos.view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool isScreenSharing = MeetingModel().isReceivingScreenShare.value;
  int currentIndex = MeetingModel().currentPageIndex.value;

  late StreamSubscription<bool> sub;
  late StreamSubscription<int> subCurrentPageIndex;
  late StreamSubscription<Map<String, AttendeeModel>> subAttendee;
  List<VideoTileModel> tiles = [];
  List<AttendeeModel> attendees = [];

  @override
  void initState() {
    super.initState();
    sub = MeetingModel().isReceivingScreenShare.listen((bool val) {
      if (mounted) {
        setState(() {
          isScreenSharing = val;
          if (val) {
            MeetingModel().currentPageIndex.add(0);
          }
        });
      }
    });

    subCurrentPageIndex = MeetingModel().currentPageIndex.listen((value) {
      setState(() {
        currentIndex = value;
      });
      attendeesListener();
    });
    subAttendee = MeetingModel().currAttendees.listen((_) {
      attendeesListener();
    });
  }

  void attendeesListener() {
    if (mounted) {
      final pageSize = MeetingTheme().pageAttendeeSize;
      final res = MeetingModel().getSortedAttendees();
      setState(() {
        final ind = max(0, currentIndex - (isScreenSharing ? 1 : 0));
        attendees = res
            .getRange(ind * pageSize, min((ind + 1) * pageSize, res.length))
            .toList();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
    subCurrentPageIndex.cancel();
    subAttendee.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isScreenSharing && currentIndex == 0
        ? const ContentShareView()
        : VideosView(
            attendees: attendees,
          );
  }
}
