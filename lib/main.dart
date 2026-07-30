import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AdminV2());
}

class AdminV2 extends StatelessWidget {
  const AdminV2({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'CEO V27.2', debugShowCheckedModeBanner: false, theme: ThemeData.dark().copyWith(primaryColor: Colors.amber), home: const CEODashboardV2());
  }
}

class CEODashboardV2 extends StatefulWidget {
  const CEODashboardV2({super.key});
  @override
  State<CEODashboardV2> createState() => _CEODashboardV2State();
}

class _CEODashboardV2State extends State<CEODashboardV2> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('👑 CEO V27.2 - VIRAL + LIVE + GIFTS + DM'), backgroundColor: Colors.amber[800]),
      body: IndexedStack(index: idx, children: const [StatsV2(), ViralPostsPage(), LiveMonitorPage(), GiftsPage(), ChatsMonitorPage()]),
      bottomNavigationBar: BottomNavigationBar(currentIndex: idx, onTap: (i) => setState(() => idx = i), type: BottomNavigationBarType.fixed, selectedItemColor: Colors.amber, items: const [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'STATS'),
        BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: 'VIRAL'),
        BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'LIVE'),
        BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'GIFTS'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'CHATS'),
      ]),
    );
  }
}

class StatsV2 extends StatelessWidget {
  const StatsV2({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('admin').doc('stats').snapshots(), builder: (c, snap) {
      var d = snap.data?.data() as Map<String, dynamic>??? {};
      return ListView(padding: const EdgeInsets.all(16), children: [
        _card('TOTAL USERS', '${d['totalUsers']?? 0}'),
        _card('VIRAL POSTS', '${d['viralPosts']?? 0}'),
        _card('GIFT COMMISSION 30% SAYO', '₱${d['giftCommission']?? 0}'),
        _card('PENDING WITHDRAW', '₱${d['pendingWithdraw']?? 0}'),
      ]);
    });
  }
  Widget _card(String t, String v) => Card(child: ListTile(title: Text(t), subtitle: Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber))));
}

class ViralPostsPage extends StatelessWidget {
  const ViralPostsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('world_feeds').orderBy('viralScore', descending: true).limit(20).snapshots(), builder: (c, snap) {
      if (!snap.hasData) return const Center(child: CircularProgressIndicator());
      return ListView.builder(itemCount: snap.data!.docs.length, itemBuilder: (c, i) {
        var data = snap.data!.docs[i].data() as Map<String, dynamic>;
        return ListTile(title: Text('${data['category']} - Score: ${data['viralScore']}'), subtitle: Text(data['title']?? ''), trailing: Icon(data['viralScore'] > 1000? Icons.whatshot : Icons.trending_up, color: Colors.red));
      });
    });
  }
}

class LiveMonitorPage extends StatelessWidget {
  const LiveMonitorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('live_rooms').where('isLive', isEqualTo: true).snapshots(), builder: (c, snap) {
      if (!snap.hasData) return const Center(child: CircularProgressIndicator());
      return ListView.builder(itemCount: snap.data!.docs.length, itemBuilder: (c, i) {
        var d = snap.data!.docs[i].data() as Map<String, dynamic>;
        return Card(child: ListTile(title: Text('LIVE: ${d['hostId']}'), subtitle: Text('Viewers: ${d['viewers']} - Gifts: ₱${d['gifts']} - CEO 30%: ₱${(d['gifts']?? 0) * 0.3}')));
      });
    });
  }
}

class GiftsPage extends StatelessWidget {
  const GiftsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('gifts').snapshots(), builder: (c, snap) {
      if (!snap.hasData) return const Center(child: CircularProgressIndicator());
      return ListView(children: snap.data!.docs.map((doc) { var d = doc.data() as Map<String, dynamic>; return ListTile(leading: Text(d['icon'], style: const TextStyle(fontSize: 30)), title: Text(d['name']), subtitle: Text('Price ₱${d['price']} - CEO ₱${d['ceoCut']}')); }).toList());
    });
  }
}

class ChatsMonitorPage extends StatelessWidget {
  const ChatsMonitorPage({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('chats').orderBy('createdAt', descending: true).limit(20).snapshots(), builder: (c, snap) {
      if (!snap.hasData) return const Center(child: CircularProgressIndicator());
      return ListView.builder(itemCount: snap.data!.docs.length, itemBuilder: (c, i) {
        var d = snap.data!.docs[i].data() as Map<String, dynamic>;
        return ListTile(title: Text('${d['user1']} <-> ${d['user2']}'), subtitle: Text('Last: ${d['lastMessage']}'));
      });
    });
  }
}
