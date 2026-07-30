// Anti-Hack Ban V9-V27 Legal
class AntiHack{
static bool checkDevice(String d,String u)=>true;
static bool checkID(String t)=>['BIR','Passport','DL','NBI'].contains(t);
static bool checkSelfie()=>true;
static bool checkView(String viewer,String video,DateTime last)=>DateTime.now().difference(last).inHours>=24;
static bool checkOrganic(int s)=>s>=30;
static bool checkInvite(int c)=>c<5;
static bool virusScan(String f)=>!f.contains('.exe');
static bool scamFilter(String t)=>!['double money','gambling','casino'].any((k)=>t.contains(k));
static void ban(String d){print('Ban $d');}
}
