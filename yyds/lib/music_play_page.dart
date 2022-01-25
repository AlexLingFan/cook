import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MusicPlayPage extends StatefulWidget {
  const MusicPlayPage({Key? key}) : super(key: key);

  @override
  _MusicPlayPageState createState() => _MusicPlayPageState();
}

class _MusicPlayPageState extends State<MusicPlayPage> {
  /// we will need some variables
  /// 是否播放 --at the begining we are not playing any song
  bool playing = false;

  /// the main state of the play button icon
  IconData playBtn = Icons.play_arrow;

  /// Now let's start by creating our music player
  ///  first let's declare some object
  late AudioPlayer _player;
  /// 本地播放
  late AudioCache cache;

  /// 播放起始位置
  Duration position = const Duration();

  /// 播放时长
  Duration musicLength = const Duration();

  /// custom slider
  Widget slider() {
    return Container(
      width: 200,
      child: Slider.adaptive(
          activeColor: Colors.white,
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          max: musicLength.inSeconds.toDouble(),
          onChanged: (value) {
            seekToSec(value.toInt());
          }),
    );
  }

  // let's create the seek function that will allow us to go to a certain position of the music
  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  // Now let's initialize our player
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 初始化
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    //now let's handle the audioplayer time

    /// this function will allow you to get the music duration
    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };

    /// this function will allow us to move the cursor of the slider while we are playing the song
    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };
  }

  @override
  void dispose() async{
    // 退出屏幕时
    await _player.release(); // 不需要时手动释放
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody()
    );
  }

  Widget getBody() {
    // 全屏宽度和高度
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      //设置背景图片
      decoration: new BoxDecoration(
        image: new DecorationImage(
          fit: BoxFit.cover,
          // image: new AssetImage(widget.bgUrl),
          image: new NetworkImage("https://cdn.magdeleine.co/wp-content/uploads/2021/03/50017954247_fbd5187302_o-1400x930.jpg"),
          //这里是从assets静态文件中获取的，也可以new NetworkImage(）从网络上获取
          // centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  //
                },
                child:  Container(
                  width: 100,
                  height: 40,
                  child: Icon(Icons.arrow_back_outlined, size: 40, color: Colors.white,),
                ),
              ),
              Spacer(),
              Container(
                width: 40,
                height: 50,
                child:  Icon(Icons.more_vert_outlined, size: 40, color: Colors.white),
              ),
              SizedBox(width: 4)
            ],
          ),
          const SizedBox(height: 30),
          Padding(
              padding: EdgeInsets.only(
                // left: 0,
              ),
              child: SizedBox(
                child: CircleAvatar(
                  backgroundImage: NetworkImage("https://cdn.magdeleine.co/wp-content/uploads/2021/03/50017954247_fbd5187302_o-1400x930.jpg"),
                ),
                width: width - 80,
                height: width - 80,
              )
          ),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              "夕阳之歌",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            child: Container(
                width: width,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 播放顺序
                          IconButton(
                            iconSize: 20.0,
                            // color: Colors.blue,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${position.inMinutes}:${position.inSeconds.remainder(60)}",
                            style: const TextStyle(
                                fontSize: 13.0, color: Colors.white
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(0),
                                color: Colors.red,
                                // width: 190,
                                alignment: Alignment.center,
                              ),
                              Positioned(
                                child: slider(),
                              )
                            ],
                          ),
                          Text(
                              "${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}",
                              style: const TextStyle(
                                  fontSize: 13.0, color: Colors.white
                              )
                          ),
                          const SizedBox(width: 3),
                          // 播放顺序
                          FlatButton(
                              shape: StadiumBorder(),
                              color: Colors.white24,
                              height: 28,
                              minWidth: 26,
                              onPressed: (){
                                //
                              },
                              child: Text("倍速", style: TextStyle(color: Colors.white, fontSize: 10))),
                          // const SizedBox(width: 10),
                        ]
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 播放顺序
                        IconButton(
                          iconSize: 36.0,
                          color: Colors.blue,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.repeat_one,
                            color: Colors.white,
                          ),
                        ),
                        // 切换上一曲
                        IconButton(
                          iconSize: 45.0,
                          color: Colors.blue,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                          ),
                        ),
                        // 播放/暂停
                        IconButton(
                          iconSize: 62.0,
                          color: Colors.white,
                          onPressed: () async{
                            print("可就是不断开发觉得你饭卡");
                            if (!playing) {
                              //now let's play the song
                              // 播放音乐，此处添加歌曲
                              /*
                                  cache.play("Stargazer.mp3");
                                  setState(() {
                                    playBtn = Icons.pause;
                                    playing = true;
                                  });
                                   */
                              // 搁浅
                              // int result = await _player.play("https://sharefs.ali.kugou.com/202201101528/5fc4e34a7e03f7794ca8f52dae872118/KGTX/CLTX001/c2d42ad2070678122ccfcd9fbf1179d3.mp3");
                              // 夕阳之歌
                              int result = await _player.play("https://sharefs.ali.kugou.com/202201101531/82700acb6afa6b849bdffeba8206d269/G144/M03/01/19/MIcBAFvkfZKAS6llAEkimz4ibk8914.mp3");
                              // // 焚情
                              // int result = await _player.play("https://sharefs.ali.kugou.com/202201101536/29d16445f3b3be68d3aa0ac18f853a6d/KGTX/CLTX001/55dc3f4c5f00cd747f6b8dbb7e07dd4c.mp3");
                              // // 当年情
                              // int result = await _player.play("https://sharefs.ali.kugou.com/202201101536/0b42249d57780f82352f414ec2e53ad2/KGTX/CLTX001/97cbafeeeca40fb07ce11ccf6a00b341.mp3");
                              // 情已逝
                              // int result = await _player.play("https://sharefs.ali.kugou.com/202201101538/9badd6dd4cf8fb8da39207c8562ba552/KGTX/CLTX001/e76ce4f32bd1ba989ef1662cb4c0fc5e.mp3");

                              // int result = await _player.play("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3");
                              if (result == 1) {
                                // success
                                setState(() {
                                  playBtn = Icons.pause;
                                  playing = true;
                                });
                                if (kDebugMode) {
                                  print("play success");
                                }
                              } else {
                                print('play failed');
                              }

                            } else {
                              int result = await _player.pause();
                              if (result == 1) {
                                // success
                                _player.pause();
                                setState(() {
                                  playBtn = Icons.play_arrow;
                                  playing = false;
                                });
                                if (kDebugMode) {
                                  print("pause success");
                                }
                                // print('pause success');
                              } else {
                                print('pause failed');
                              }
                              /*
                                    _player.pause();
                                  setState(() {
                                    playBtn = Icons.play_arrow;
                                    playing = false;
                                  });
                                   */
                            }
                          },
                          icon: Icon(
                            playBtn,
                          ),
                        ),

                        // 切换下一曲
                        IconButton(
                          iconSize: 45.0,
                          color: Colors.blue,
                          onPressed: () async{
                            // await AudioService.skipToNext();
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            color: Colors.white,
                          ),
                        ),
                        // 歌曲列表
                        IconButton(
                          iconSize: 40.0,
                          color: Colors.blue,
                          onPressed: () {},
                          icon: const Icon(
                            // Icons.widgets_outlined,
                            Icons.playlist_play,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                )
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}