import 'package:flutter/material.dart';

import '../models/meeting.model.dart';
import 'video_tile.view.dart';
import 'pinch_view.dart';

class ContentShareView extends StatelessWidget {
  const ContentShareView({super.key});

  @override
  Widget build(BuildContext context) {
    final videoTile = MeetingModel()
        .currAttendees
        .value[MeetingModel().contentAttendeeId.value]
        ?.videoTile;
    if (videoTile == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: Text(
            'Error: cannot get shared screen content.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return PinchView(
      contentRatio: videoTile.videoStreamContentWidth /
          videoTile.videoStreamContentHeight,
      child: VideoTileView(paramsVT: videoTile.tileId),
    );
  }
}
