// TUNE EARN V27.2 USER - WORLD FEED VIRAL + DM + GIFTS - COPY PASTE SA tune-earn-v27/lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);
  runApp(const TuneEarnV272());
}

class TuneEarnV272 extends StatelessWidget {
  const TuneEarnV272({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'TUNE EARN V27.2', debugShowCheckedModeBanner: false, theme: ThemeData.dark().copyWith(primaryColor: Colors.amber, scaffoldBackgroundColor: const Color(0xFF0F0F0F)), home: const DashboardV272());
  }
}

class DashboardV272 extends StatefulWidget {
  const DashboardV272({super.key});
  @override
  State<DashboardV272> createState() => _DashboardV272State();
}

class _DashboardV272State extends State<DashboardV272> {
  int currentIndex = 0;
  BannerAd? _bannerAd;
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _initUser();
    _loadBanner();
    _loadRewarded();
  }

  Future<void> _initUser() async {
    if (FirebaseAuth.instance.currentUser == null) await FirebaseAuth.instance.signInAnonymously();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (!doc.exists) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({'balance': 0.0, 'createdAt': FieldValue.serverTimestamp(), 'referralCode': 'RACAZA${uid.substring(0,5).toUpperCase()}'});
    }
    var catSnap = await FirebaseFirestore.instance.collection('categories').limit(1).get();
    if (catSnap.docs.isEmpty) {
      await FirebaseFirestore.instance.collection('categories').doc('music').set({'name': 'Music', 'icon': '🎵', 'order': 1});
      await FirebaseFirestore.instance.collection('categories').doc('comedy').set({'name': 'Comedy', 'icon': '😂', 'order': 2});
      await FirebaseFirestore.instance.collection('categories').doc('dance').set({'name': 'Dance', 'icon': '💃', 'order': 3});
      await FirebaseFirestore.instance.collection('categories').doc('gaming').set({'name': 'Gaming', 'icon': '🎮', 'order': 4});
      await FirebaseFirestore.instance.collection('categories').doc('news').set({'name': 'News', 'icon': '📰', 'order': 5});
      await FirebaseFirestore.instance.collection('categories').doc('live').set({'name': 'LIVE', 'icon': '🔴', 'order': 6});
      await FirebaseFirestore.instance.collection('gifts').doc('rose').set({'name': 'Rose', 'price': 10, 'icon': '🌹'});
      await FirebaseFirestore.instance.collection('gifts').doc('car').set({'name': 'Car', 'price': 100, 'icon': '🚗'});
      await FirebaseFirestore.instance.collection('gifts').doc('diamond').set({'name': 'Diamond', 'price': 500, 'icon': '💎'});
    }
  }

  void _loadBanner() {
    _bannerAd = BannerAd(adUnitId: 'ca-app-pub-3940256099942544/6300978111', size: AdSize.banner, request: const AdRequest(), listener: BannerAdListener(onAdLoaded: (_) => setState(() => _isAdLoaded = true)))..load();
  }

  void _loadRewarded() {
    RewardedAd.load(adUnitId: 'ca-app-pub-3940256099942544/5224354917', request: const AdRequest(), rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) => _rewardedAd = ad, onAdFailedToLoad: (e) {}));
  }

  Future<void> _earnWithAd(double amount) async {
    if (_rewardedAd!= null) {_rewardedAd!.show(onUserEarnedReward: (_, __) async { await _addBalance(amount); _loadRewarded(); });} else {await _addBalance(amount);}
  }

  Future<void> _addBalance(double amount) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(uid).update({'balance': FieldValue.increment(amount)});
  }

  Future<void> _updateViral(String postId) async {
    var ref = FirebaseFirestore.instance.collection('world_feeds').doc(postId);
    var snap = await ref.get(); if (!snap.exists) return;
    var d = snap.data()!;
    int likes = d['likes']??0; int views = d['views']??0; int comments = d['comments']??0; int shares = d['shares']??0;
    int viralScore = (likes*10)+(views*2)+(comments*5)+(shares*20);
    await ref.update({'viralScore': viralScore, 'views': FieldValue.increment(1)});
    if (viralScore>=100) await FirebaseFirestore.instance.collection('world_feeds_trending').doc(postId).set({...d,'viralScore':viralScore},SetOptions(merge:true));
    if (viralScore>=1000) await FirebaseFirestore.instance.collection('for_you_global').doc(postId).set({...d,'viralScore':viralScore},SetOptions(merge:true));
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid??'';
    return Scaffold(
      appBar: AppBar(title: const Text('👑 V27.2 VIRAL+DM+GIFTS', style: TextStyle(color: Colors.amber, fontSize:14, fontWeight: FontWeight.bold)), backgroundColor: Colors.black, actions: [StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(), builder: (c,snap){double bal=0; if(snap.hasData&&snap.data!.exists) bal=(snap.data!.data() as Map<String,dynamic>)['balance']?.toDouble()??0; return Container(margin: const EdgeInsets.only(right:10), padding: const EdgeInsets.symmetric(horizontal:12,vertical:6), decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)), child: Text('₱${bal.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));})]),
      body: IndexedStack(index: currentIndex, children: [
        WorldFeed(onEarnAd:_earnWithAd, onViral:_updateViral),
        LivePage(onEarnAd:_earnWithAd),
        ChatsPage(),
        const Center(child: Text('REFER - SHARE CODE = ₱25')),
        WalletPage(),
      ]),
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [if(_isAdLoaded&&_bannerAd!=null) SizedBox(height:50, child: AdWidget(ad:_bannerAd!)), BottomNavigationBar(currentIndex:currentIndex, onTap:(i)=>setState(()=>currentIndex=i), type: BottomNavigationBarType.fixed, backgroundColor: Colors.black, selectedItemColor: Colors.amber, unselectedItemColor: Colors.white54, items: const [BottomNavigationBarItem(icon: Icon(Icons.public), label:'WORLD'), BottomNavigationBarItem(icon: Icon(Icons.live_tv), label:'LIVE'), BottomNavigationBarItem(icon: Icon(Icons.message), label:'DM'), BottomNavigationBarItem(icon: Icon(Icons.group), label:'REFER'), BottomNavigationBarItem(icon: Icon(Icons.wallet), label:'WALLET')])]),
    );
  }
}

class WorldFeed extends StatefulWidget { final Function(double) onEarnAd; final Function(String) onViral; const WorldFeed({super.key, required this.onEarnAd, required this.onViral}); @override State<WorldFeed> createState()=>_WorldFeedState();}
class _WorldFeedState extends State<WorldFeed> with SingleTickerProviderStateMixin { late TabController _tab; final cats=['all','music','comedy','dance','gaming','news','trending','foryou']; @override void initState(){super.initState(); _tab=TabController(length:cats.length,vsync:this);} @override Widget build(BuildContext context){return Column(children:[TabBar(controller:_tab,isScrollable:true,labelColor:Colors.amber,tabs:cats.map((c)=>Tab(text:c.toUpperCase())).toList()),Expanded(child:TabBarView(controller:_tab,children:cats.map((cat){Query q; if(cat=='trending') q=FirebaseFirestore.instance.collection('world_feeds_trending').orderBy('viralScore',descending:true).limit(20); else if(cat=='foryou') q=FirebaseFirestore.instance.collection('for_you_global').orderBy('viralScore',descending:true).limit(20); else if(cat=='all') q=FirebaseFirestore.instance.collection('world_feeds').orderBy('createdAt',descending:true).limit(20); else q=FirebaseFirestore.instance.collection('world_feeds').where('category',isEqualTo:cat).orderBy('viralScore',descending:true).limit(20); return StreamBuilder<QuerySnapshot>(stream:q.snapshots(),builder:(c,snap){if(!snap.hasData) return const Center(child:CircularProgressIndicator()); if(snap.data!.docs.isEmpty) return Center(child:Text('No $cat yet - Be first viral!')); return ListView.builder(itemCount:snap.data!.docs.length,itemBuilder:(c,i){var doc=snap.data!.docs[i]; var d=doc.data() as Map<String,dynamic>; return Card(color: const Color(0xFF1E1E1E), margin: const EdgeInsets.all(8), child: ListTile(leading: CachedNetworkImage(imageUrl: d['thumb']??'https://via.placeholder.com/50', width:50, height:50, fit:BoxFit.cover), title: Text(d['title']??'Video ${d['category']}'), subtitle: Text('Score:${d['viralScore']??0} | ${d['likes']??0} likes'), trailing: ElevatedButton(onPressed:(){widget.onEarnAd(5); widget.onViral(doc.id);}, style: ElevatedButton.styleFrom(backgroundColor:Colors.amber,foregroundColor:Colors.black), child: const Text('WATCH')), onTap:()=>widget.onViral(doc.id)));});});}).toList()))]);}}

class LivePage extends StatelessWidget{final Function(double) onEarnAd; const LivePage({super.key, required this.onEarnAd}); Future<void> _sendGift(String roomId, int price) async {final uid=FirebaseAuth.instance.currentUser!.uid; var uRef=FirebaseFirestore.instance.collection('users').doc(uid); var snap=await uRef.get(); double bal=(snap.data()?['balance']??0).toDouble(); if(bal<price) return; await uRef.update({'balance':FieldValue.increment(-price*1.0)}); await FirebaseFirestore.instance.collection('live_rooms').doc(roomId).update({'gifts':FieldValue.increment(price)}); await FirebaseFirestore.instance.collection('admin').doc('stats').set({'giftCommission':FieldValue.increment(price*0.3)},SetOptions(merge:true)); var roomSnap=await FirebaseFirestore.instance.collection('live_rooms').doc(roomId).get(); String hostId=roomSnap.data()?['hostId']??''; if(hostId.isNotEmpty) await FirebaseFirestore.instance.collection('users').doc(hostId).update({'balance':FieldValue.increment(price*0.7)});} @override Widget build(BuildContext context){return StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection('live_rooms').where('isLive',isEqualTo:true).limit(20).snapshots(),builder:(c,snap){if(!snap.hasData) return const Center(child:CircularProgressIndicator()); if(snap.data!.docs.isEmpty) return Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[const Text('No Live now'),ElevatedButton(onPressed:()async{final uid=FirebaseAuth.instance.currentUser!.uid; await FirebaseFirestore.instance.collection('live_rooms').doc(uid).set({'hostId':uid,'isLive':true,'viewers':0,'gifts':0,'createdAt':FieldValue.serverTimestamp()});}, child:const Text('GO LIVE'))])); return ListView.builder(itemCount:snap.data!.docs.length,itemBuilder:(c,i){var doc=snap.data!.docs[i]; var d=doc.data() as Map<String,dynamic>; return Card(child:ListTile(title:Text('🔴 LIVE: ${d['hostId'].toString().substring(0,6)}'), subtitle:Text('Gifts: ₱${d['gifts']}'), trailing:Row(mainAxisSize:MainAxisSize.min,children:[IconButton(onPressed:()=>_sendGift(doc.id,10), icon:const Text('🌹')),IconButton(onPressed:()=>_sendGift(doc.id,100), icon:const Text('🚗')),IconButton(onPressed:()=>_sendGift(doc.id,500), icon:const Text('💎'))])));});});}}

class ChatsPage extends StatefulWidget{const ChatsPage({super.key}); @override State<ChatsPage> createState()=>_ChatsPageState();}
class _ChatsPageState extends State<ChatsPage>{final _ctrl=TextEditingController(); String? chatId; String? otherId; Future<void> _startChat(String other) async {final my=FirebaseAuth.instance.currentUser!.uid; String id=my.compareTo(other)<0?'${my}_$other':'${other}_$my'; await FirebaseFirestore.instance.collection('chats').doc(id).set({'user1':my,'user2':other,'lastMessage':'','createdAt':FieldValue.serverTimestamp()},SetOptions(merge:true)); setState(()=>{chatId=id,otherId=other});} @override Widget build(BuildContext context){final my=FirebaseAuth.instance.currentUser!.uid; if(chatId==null){return Column(children:[Padding(padding:const EdgeInsets.all(8), child:TextField(onSubmitted:(v)=>_startChat(v.trim()), decoration:const InputDecoration(hintText:'Enter User ID to DM kahit not friend', border:OutlineInputBorder(), prefixIcon:Icon(Icons.search)))),Expanded(child:StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection('chats').where('user1',isEqualTo:my).limit(20).snapshots(), builder:(c,s){var s2=FirebaseFirestore.instance.collection('chats').where('user2',isEqualTo:my).limit(20).snapshots(); return StreamBuilder<QuerySnapshot>(stream:s2,builder:(c2,s2d){List<DocumentSnapshot> all=[]; if(s.hasData) all.addAll(s.data!.docs); if(s2d.hasData) all.addAll(s2d.data!.docs); if(all.isEmpty) return const Center(child:Text('No DM - Search ID above')); return ListView.builder(itemCount:all.length,itemBuilder:(c,i){var d=all[i].data() as Map<String,dynamic>; String other=d['user1']==my?d['user2']:d['user1']; return ListTile(title:Text('DM: ${other.substring(0,6)}'), subtitle:Text(d['lastMessage']??''), onTap:()=>setState(()=>{chatId=all[i].id,otherId=other}));});});}))]);} else {return Column(children:[AppBar(title:Text('Chat ${otherId!.substring(0,6)}'), leading:IconButton(icon:const Icon(Icons.arrow_back), onPressed:()=>setState(()=>chatId=null))),Expanded(child:StreamBuilder<QuerySnapshot>(stream:FirebaseFirestore.instance.collection('messages').where('chatId',isEqualTo:chatId).orderBy('timestamp').limit(50).snapshots(),builder:(c,s){if(!s.hasData) return const Center(child:CircularProgressIndicator()); return ListView.builder(itemCount:s.data!.docs.length,itemBuilder:(c,i){var m=s.data!.docs[i].data() as Map<String,dynamic>; bool me=m['senderId']==my; return Align(alignment:me?Alignment.centerRight:Alignment.centerLeft, child:Container(margin:const EdgeInsets.all(4),padding:const EdgeInsets.all(10), decoration:BoxDecoration(color:me?Colors.amber:Colors.grey[800],borderRadius:BorderRadius.circular(10)), child:Text(m['text'], style:TextStyle(color:me?Colors.black:Colors.white))));});})),Padding(padding:const EdgeInsets.all(8), child:Row(children:[Expanded(child:TextField(controller:_ctrl, decoration:const InputDecoration(hintText:'Message kahit not friend...', border:OutlineInputBorder()))),IconButton(icon:const Icon(Icons.send,color:Colors.amber), onPressed:()async{if(_ctrl.text.trim().isEmpty) return; await FirebaseFirestore.instance.collection('messages').add({'chatId':chatId,'senderId':my,'text':_ctrl.text.trim(),'timestamp':FieldValue.serverTimestamp()}); await FirebaseFirestore.instance.collection('chats').doc(chatId).update({'lastMessage':_ctrl.text.trim()}); _ctrl.clear();})]))]);}}}

class WalletPage extends StatelessWidget{WalletPage({super.key}); final aCtrl=TextEditingController(); final gCtrl=TextEditingController(); @override Widget build(BuildContext context){final uid=FirebaseAuth.instance.currentUser!.uid; return StreamBuilder<DocumentSnapshot>(stream:FirebaseFirestore.instance.collection('users').doc(uid).snapshots(), builder:(c,s){double bal=0; if(s.hasData&&s.data!.exists) bal=(s.data!.data() as Map<String,dynamic>)['balance']?.toDouble()??0; return Padding(padding:const EdgeInsets.all(16), child:Column(children:[Container(width:double.infinity, padding:const EdgeInsets.all(24), decoration:BoxDecoration(gradient:const LinearGradient(colors:[Colors.amber,Colors.orange]),borderRadius:BorderRadius.circular(20)), child:Column(children:[const Text('BALANCE', style:TextStyle(color:Colors.black)),Text('₱${bal.toStringAsFixed(2)}', style:const TextStyle(fontSize:36,fontWeight:FontWeight.bold,color:Colors.black))])), const SizedBox(height:20), TextField(controller:aCtrl, decoration:const InputDecoration(labelText:'Amount',border:OutlineInputBorder()), keyboardType:TextInputType.number), const SizedBox(height:10), TextField(controller:gCtrl, decoration:const InputDecoration(labelText:'GCash Number',border:OutlineInputBorder())), const SizedBox(height:10), SizedBox(width:double.infinity, child:ElevatedButton(onPressed:()async{double amt=double.tryParse(aCtrl.text)??0; if(amt>bal){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Kulang balance!'))); return;} await FirebaseFirestore.instance.collection('withdraws').add({'userId':uid,'amount':amt,'gcash':gCtrl.text,'status':'pending','createdAt':FieldValue.serverTimestamp()}); await FirebaseFirestore.instance.collection('users').doc(uid).update({'balance':FieldValue.increment(-amt)}); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Withdraw sent to CEO!'), backgroundColor:Colors.green));}, style:ElevatedButton.styleFrom(backgroundColor:Colors.amber,foregroundColor:Colors.black,padding:const EdgeInsets.all(16)), child:const Text('WITHDRAW TO CEO')))]));});}}
