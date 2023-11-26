import 'common.dart';

class VideoTileModel {
  VideoTileModel(
    this.tileId,
    this.videoStreamContentWidth,
    this.videoStreamContentHeight,
    this.isLocalTile,
    this.isContentShare,
  );

  VideoTileModel.fromJson(Json json)
      : this(
          json["tileId"],
          json["videoStreamContentWidth"],
          json["videoStreamContentHeight"],
          json["isLocalTile"],
          json["isContent"],
        );

  final int tileId;
  int videoStreamContentWidth;
  int videoStreamContentHeight;
  bool isLocalTile;
  bool isContentShare;
}
