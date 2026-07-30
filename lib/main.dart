import 'package:flutter/material.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

void main() { runApp(const TuneEarnV27Ultimate()); }

class TuneEarnV27Ultimate extends StatelessWidget {
  const TuneEarnV27Ultimate({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TUNE EARN V27 ULTIMATE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      home: const SplashV27(),
    );
  }
}

class SplashV27 extends StatefulWidget { const SplashV27({super.key}); @override State<SplashV27> createState() => _SplashV27State(); }
class _SplashV27State extends State<SplashV27> {
  @override
  void initState() { super.initState(); Future.delayed(const Duration(seconds: 3), () { if(mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AntiHackCheck())); }); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.deepPurple, body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.music_note, size: 100, color: Colors.white), SizedBox(height: 20), Text('TUNE EARN', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)), Text('V27 ULTIMATE', style: TextStyle(fontSize: 20, color: Colors.white70)), SizedBox(height: 30), CircularProgressIndicator(color: Colors.white), SizedBox(height: 10), Text('BIR Legal | 1 Device 1 Account', style: TextStyle(color: Colors.white70)), Text('Anti-Hack Active', style: TextStyle(color: Colors.greenAccent)) ])));
  }
}

class AntiHackCheck extends StatelessWidget {
  const AntiHackCheck({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Padding(padding: EdgeInsets.all(20), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.security, size: 80, color: Colors.green),
      SizedBox(height: 20),
      Text('V27 ANTI-HACK SYSTEM', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SizedBox(height: 20),
      Card(child: ListTile(leading: Icon(Icons.phone_android, color: Colors.green), title: Text('Device Check'), subtitle: Text('1 Device 1 Account Verified'), trailing: Icon(Icons.check_circle, color: Colors.green))),
      Card(child: ListTile(leading: Icon(Icons.shield, color: Colors.green), title: Text('Root/Emulator Check'), subtitle: Text('No Root / No Emulator Detected'), trailing: Icon(Icons.check_circle, color: Colors.green))),
      Card(child: ListTile(leading: Icon(Icons.gavel, color: Colors.green), title: Text('BIR Legal Compliance'), subtitle: Text('DTI Registered - Legal'), trailing: Icon(Icons.check_circle, color: Colors.green))),
      SizedBox(height: 30),
      SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, padding: EdgeInsets.all(15)), onPressed: (){ Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardV27())); }, child: Text('CONTINUE TO V27 ULTIMATE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
      SizedBox(height: 10),
      Text('Auto Ban: Multi-account | VPN | Hack Tools', style: TextStyle(fontSize: 11, color: Colors.red))
    ]))));
  }
}

class DashboardV27 extends StatefulWidget { const DashboardV27({super.key}); @override State<DashboardV27> createState() => _DashboardV27State(); }
class _DashboardV27State extends State<DashboardV27> {
  double balance = 1250.75;
  int todayEarn = 350;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TUNE EARN V27 ULTIMATE'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white, actions: [IconButton(onPressed: (){}, icon: Icon(Icons.notifications)), Padding(padding: EdgeInsets.only(right: 10), child: CircleAvatar(child: Text('BR')))]),
      body: SingleChildScrollView(padding: EdgeInsets.all(15), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: EdgeInsets.all(20), decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple, Colors.purpleAccent]), borderRadius: BorderRadius.circular(15)), child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Total Balance', style: TextStyle(color: Colors.white70)), Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)), child: Text('BIR LEGAL', style: TextStyle(color: Colors.white, fontSize: 10)))]),
          SizedBox(height: 5),
          Align(alignment: Alignment.centerLeft, child: Text('₱ ${balance.toStringAsFixed(2)}', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white))),
          SizedBox(height: 10),
          Row(children: [Icon(Icons.trending_up, color: Colors.greenAccent, size: 16), SizedBox(width: 5), Text('+$todayEarn Today', style: TextStyle(color: Colors.greenAccent))]),
          SizedBox(height: 15),
          Row(children: [
            Expanded(child: ElevatedButton(onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (_) => WithdrawV27(balance: balance))); }, child: Text('WITHDRAW'))),
            SizedBox(width: 10),
            Expanded(child: OutlinedButton(style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.white)), onPressed: (){}, child: Text('HISTORY'))),
          ])
        ])),
        SizedBox(height: 20),
        Text('EARN METHODS - AUTO ALL', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 10),
        GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: NeverScrollableScrollPhysics(), childAspectRatio: 1.3, children: [
          _earnCard(Icons.play_circle_fill, 'Watch & Earn', '₱5 / video', Colors.red),
          _earnCard(Icons.music_note, 'Listen & Earn', '₱3 / song', Colors.blue),
          _earnCard(Icons.task, 'Daily Tasks', '₱50 / task', Colors.orange),
          _earnCard(Icons.group, 'Referral', '₱100 / invite', Colors.green),
        ]),
        SizedBox(height: 20),
        Text('WITHDRAW METHODS', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Row(children: [
          _withdrawMethod('GCash', Icons.account_balance_wallet, Colors.blue),
          _withdrawMethod('PayPal', Icons.payment, Colors.lightBlue),
          _withdrawMethod('USDT', Icons.currency_bitcoin, Colors.orange),
        ]),
        SizedBox(height: 20),
        Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.red.shade200)), child: Row(children: [Icon(Icons.warning, color: Colors.red), SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('ANTI-HACK V27 ACTIVE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 12)), Text('1 Device = 1 Account | Auto Ban Multi-Account, VPN, Emulator, Hack Tools | BIR Legal', style: TextStyle(fontSize: 10, color: Colors.red.shade700))]))])),
        SizedBox(height: 10),
        Center(child: Text('TUNE EARN V27 ULTIMATE - Version 27.0 - Legal & Secure', style: TextStyle(fontSize: 10, color: Colors.grey))),
      ])),
      bottomNavigationBar: BottomNavigationBar(selectedItemColor: Colors.deepPurple, items: [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'), BottomNavigationBarItem(icon: Icon(Icons.earnings), label: 'Earn'), BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')]),
    );
  }
  Widget _earnCard(IconData icon, String title, String earn, Color color) {
    return Card(child: Padding(padding: EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: color, size: 30), SizedBox(height: 8), Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text(earn, style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)), Spacer(), Container(padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)), child: Text('START', style: TextStyle(color: Colors.white, fontSize: 10)))])));
  }
  Widget _withdrawMethod(String name, IconData icon, Color color) {
    return Expanded(child: Card(child: Padding(padding: EdgeInsets.all(10), child: Column(children: [Icon(icon, color: color), SizedBox(height: 5), Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)), Text('Auto', style: TextStyle(fontSize: 9, color: Colors.green))]))));
  }
}

class WithdrawV27 extends StatelessWidget {
  final double balance;
  const WithdrawV27({super.key, required this.balance});
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Withdraw V27'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white), body: Padding(padding: EdgeInsets.all(20), child: Column(children: [
      Card(color: Colors.deepPurple.shade50, child: Padding(padding: EdgeInsets.all(15), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Available'), Text('₱ ${balance.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))]))),
      SizedBox(height: 20),
      TextField(decoration: InputDecoration(labelText: 'Amount (Min ₱100)', border: OutlineInputBorder(), prefixText: '₱ ')),
      SizedBox(height: 15),
      DropdownButtonFormField(decoration: InputDecoration(labelText: 'Withdraw Method', border: OutlineInputBorder()), items: [DropdownMenuItem(value: 'gcash', child: Text('GCash - Auto (1-2 hrs)')), DropdownMenuItem(value: 'paypal', child: Text('PayPal - Auto (24 hrs)')), DropdownMenuItem(value: 'usdt', child: Text('USDT TRC20 - Auto (30 mins)'))], onChanged: (v){}),
      SizedBox(height: 15),
      TextField(decoration: InputDecoration(labelText: 'GCash/PayPal/USDT Address', border: OutlineInputBorder())),
      SizedBox(height: 20),
      SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, padding: EdgeInsets.all(15)), onPressed: (){ ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Withdraw Requested! Auto Processing V27'))); }, child: Text('WITHDRAW NOW - AUTO', style: TextStyle(color: Colors.white)))),
      SizedBox(height: 15),
      Text('BIR Legal: 10% tax auto deduct above ₱10,000 - DTI Registered', style: TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center),
    ])));
  }
}
