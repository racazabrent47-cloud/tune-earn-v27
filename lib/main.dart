import 'package:flutter/material.dart';
void main()=>runApp(TuneEarn());
class TuneEarn extends StatelessWidget{
@override Widget build(BuildContext c)=>MaterialApp(home:Home(),debugShowCheckedModeBanner:false);
}
class Home extends StatefulWidget{@override _H createState()=>_H();}
class _H extends State<Home>{
int i=0;
final t=[
Text('WorldFeeds Worldwide\nViral Cat->WorldFeed\nAuto AdSense \$0.05\nV9-V27'),
Text('Mall 10K\n500 Core+9500 AI Auto\nCOLD WARM HOT VIRAL'),
Text('Post Video\nCategory->WorldFeed\nAI Assistant'),
Text('Battle 1v1\nSing Karaoke Rap Dance\nSplit Gifts Rose Crown'),
Text('Earnings\nGCash PayPal USDT Wise\nBIR Valid ID\nAuto Sahod')
];
@override Widget build(BuildContext c)=>Scaffold(
appBar:AppBar(title:Text('TUNE EARN V27 LEGAL'),backgroundColor:Color(0xFFFFD60A)),
body:Center(child:t[i]),
bottomNavigationBar:BottomNavigationBar(
currentIndex:i,onTap:(x)=>setState(()=>i=x),type:BottomNavigationBarType.fixed,
items:[
BottomNavigationBarItem(icon:Icon(Icons.public),label:'WorldFeeds'),
BottomNavigationBarItem(icon:Icon(Icons.store),label:'Mall 10K'),
BottomNavigationBarItem(icon:Icon(Icons.add),label:'Post'),
BottomNavigationBarItem(icon:Icon(Icons.music_note),label:'Battle'),
BottomNavigationBarItem(icon:Icon(Icons.person),label:'Earn'),
]));
}
