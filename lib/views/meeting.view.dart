import 'package:flutter/material.dart';

import '../models/join_info.model.dart';
import '../models/meeting.model.dart';
import 'main.view.dart';
import 'title.view.dart';
import 'actions.view.dart';
import 'control_visible.view.dart';
import 'messages.view.dart';
import 'page_indicator.view.dart';

class MeetingView extends StatefulWidget {
  final JoinInfo joinData;
  final void Function(bool didStop)? onLeave;

  const MeetingView(this.joinData, {this.onLeave, super.key});

  @override
  State<MeetingView> createState() => _MeetingViewState();
}

class _MeetingViewState extends State<MeetingView> {
  MeetingModel meeting = MeetingModel();
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    meeting.config(meetingData: widget.joinData);
    final res = await meeting.join();
    debugPrint("join res: $res");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: GestureDetector(
        onTap: () {
          try {
            MeetingModel().hideControlInSeconds();
            // ignore: empty_catches
          } catch (e) {
            debugPrint("Error hide $e");
          }
        },
        child: Container(
          child: Stack(
            children: [
              const MainView(),
              ControlVisibleView(
                child: TitleView(
                  title: widget.joinData.meeting.externalMeetingId,
                  onLeave: widget.onLeave,
                ),
              ),
              const ControlVisibleView(
                child: MessagesView(),
              ),
              ControlVisibleView(
                child: ActionsView(),
              ),
              const ControlVisibleView(
                child: PageIndicatorView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
