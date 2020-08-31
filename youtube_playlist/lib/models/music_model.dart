// To parse this JSON data, do
//
//     final musicModel = musicModelFromJson(jsonString);

import 'dart:convert';

List<MusicModel> musicModelFromJson(String str) => List<MusicModel>.from(json.decode(str).map((x) => MusicModel.fromJson(x)));

String musicModelToJson(List<MusicModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MusicModel {
  MusicModel({
    this.kind,
    this.etag,
    this.id,
    this.snippet,
    this.contentDetails,
    this.status,
  });

  final MusicModelKind kind;
  final String etag;
  final String id;
  final Snippet snippet;
  final ContentDetails contentDetails;
  final Status status;

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
    kind: musicModelKindValues.map[json["kind"]],
    etag: json["etag"],
    id: json["id"],
    snippet: Snippet.fromJson(json["snippet"]),
    contentDetails: ContentDetails.fromJson(json["contentDetails"]),
    status: Status.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": musicModelKindValues.reverse[kind],
    "etag": etag,
    "id": id,
    "snippet": snippet.toJson(),
    "contentDetails": contentDetails.toJson(),
    "status": status.toJson(),
  };
}

class ContentDetails {
  ContentDetails({
    this.videoId,
    this.videoPublishedAt,
  });

  final String videoId;
  final DateTime videoPublishedAt;

  factory ContentDetails.fromJson(Map<String, dynamic> json) => ContentDetails(
    videoId: json["videoId"],
    videoPublishedAt: DateTime.parse(json["videoPublishedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "videoId": videoId,
    "videoPublishedAt": videoPublishedAt.toIso8601String(),
  };
}

enum MusicModelKind { YOUTUBE_PLAYLIST_ITEM }

final musicModelKindValues = EnumValues({
  "youtube#playlistItem": MusicModelKind.YOUTUBE_PLAYLIST_ITEM
});

class Snippet {
  Snippet({
    this.publishedAt,
    this.channelId,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.playlistId,
    this.position,
    this.resourceId,
  });

  final DateTime publishedAt;
  final ChannelId channelId;
  final String title;
  final String description;
  final Thumbnails thumbnails;
  final ChannelTitle channelTitle;
  final PlaylistId playlistId;
  final int position;
  final ResourceId resourceId;

  factory Snippet.fromJson(Map<String, dynamic> json) => Snippet(
    publishedAt: DateTime.parse(json["publishedAt"]),
    channelId: channelIdValues.map[json["channelId"]],
    title: json["title"],
    description: json["description"],
    thumbnails: Thumbnails.fromJson(json["thumbnails"]),
    channelTitle: channelTitleValues.map[json["channelTitle"]],
    playlistId: playlistIdValues.map[json["playlistId"]],
    position: json["position"],
    resourceId: ResourceId.fromJson(json["resourceId"]),
  );

  Map<String, dynamic> toJson() => {
    "publishedAt": publishedAt.toIso8601String(),
    "channelId": channelIdValues.reverse[channelId],
    "title": title,
    "description": description,
    "thumbnails": thumbnails.toJson(),
    "channelTitle": channelTitleValues.reverse[channelTitle],
    "playlistId": playlistIdValues.reverse[playlistId],
    "position": position,
    "resourceId": resourceId.toJson(),
  };
}

enum ChannelId { UCBR8_60_B28_HP2_BM_D_PDNTC_Q }

final channelIdValues = EnumValues({
  "UCBR8-60-B28hp2BmDPdntcQ": ChannelId.UCBR8_60_B28_HP2_BM_D_PDNTC_Q
});

enum ChannelTitle { YOU_TUBE }

final channelTitleValues = EnumValues({
  "YouTube": ChannelTitle.YOU_TUBE
});

enum PlaylistId { R_DM_T_MA_L2_ZK_GAS }

final playlistIdValues = EnumValues({
  "RDmTMaL2zkGas": PlaylistId.R_DM_T_MA_L2_ZK_GAS
});

class ResourceId {
  ResourceId({
    this.kind,
    this.videoId,
  });

  final ResourceIdKind kind;
  final String videoId;

  factory ResourceId.fromJson(Map<String, dynamic> json) => ResourceId(
    kind: resourceIdKindValues.map[json["kind"]],
    videoId: json["videoId"],
  );

  Map<String, dynamic> toJson() => {
    "kind": resourceIdKindValues.reverse[kind],
    "videoId": videoId,
  };
}

enum ResourceIdKind { YOUTUBE_VIDEO }

final resourceIdKindValues = EnumValues({
  "youtube#video": ResourceIdKind.YOUTUBE_VIDEO
});

class Thumbnails {
  Thumbnails({
    this.thumbnailsDefault,
    this.medium,
    this.high,
    this.standard,
    this.maxres,
  });

  final Default thumbnailsDefault;
  final Default medium;
  final Default high;
  final Default standard;
  final Default maxres;

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
    thumbnailsDefault: Default.fromJson(json["default"]),
    medium: Default.fromJson(json["medium"]),
    high: Default.fromJson(json["high"]),
    standard: Default.fromJson(json["standard"]),
    maxres: json["maxres"] == null ? null : Default.fromJson(json["maxres"]),
  );

  Map<String, dynamic> toJson() => {
    "default": thumbnailsDefault.toJson(),
    "medium": medium.toJson(),
    "high": high.toJson(),
    "standard": standard.toJson(),
    "maxres": maxres == null ? null : maxres.toJson(),
  };
}

class Default {
  Default({
    this.url,
    this.width,
    this.height,
  });

  final String url;
  final int width;
  final int height;

  factory Default.fromJson(Map<String, dynamic> json) => Default(
    url: json["url"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "width": width,
    "height": height,
  };
}

class Status {
  Status({
    this.privacyStatus,
  });

  final PrivacyStatus privacyStatus;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    privacyStatus: privacyStatusValues.map[json["privacyStatus"]],
  );

  Map<String, dynamic> toJson() => {
    "privacyStatus": privacyStatusValues.reverse[privacyStatus],
  };
}

enum PrivacyStatus { PUBLIC }

final privacyStatusValues = EnumValues({
  "public": PrivacyStatus.PUBLIC
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
