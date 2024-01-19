enum VideoType {
  live("실시간 방송", "LIVE"),
  replay("녹화 방송", "REPLAY"),
  video("동영상", "VIDEO");

  final String name;
  final String serverKey;

  const VideoType(this.name, this.serverKey);
}
