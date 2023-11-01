import 'dart:io';

Socket? socket;
//需要进行数据库导入
var videoList = [
  'lc-egMQ9Sla.cn-n1.lcfile.com/pjM2CB0zMx2leUHY0crtrnfkAsCVhL1N/820d0fdb11352b5313c0801797927ec9.mp4',
  'lc-egMQ9Sla.cn-n1.lcfile.com/i94DDEpN5lPgNTtkpStDMUqoSQESTq4A/90c1f456f4aa5bf6d117bf1bd02fcc23.mp4',
  'lc-egMQ9Sla.cn-n1.lcfile.com/rpFhyuXW8kuOcLeljCyk8dJVWUKNGVWi/999cdae0f28ba7898ccdb7ad72943df9.mp4',
  'lc-egMQ9Sla.cn-n1.lcfile.com/pjM2CB0zMx2leUHY0crtrnfkAsCVhL1N/820d0fdb11352b5313c0801797927ec9.mp4'
];

class UserVideo {
  final String url;
  final String image;
  final String? desc;//视频介绍

  UserVideo({
    required this.url,
    required this.image,
    this.desc,
  });

  static List<UserVideo> fetchVideo() {
    List<UserVideo> list = videoList
        .map((e) => UserVideo(
            image: '', url: 'https://$e', desc: '#原创  #短视频  #Csgo  #遗憾'))
        .toList();
    return list;
  }

  @override
  String toString() {
    return 'image:$image' '\nvideo:$url';
  }
}
