import 'package:flutter/material.dart';
import 'warranties_screen.dart';
import 'claim_screen.dart';
import 'register_warranty_screen.dart';
import 'admin_screen.dart';
import 'support_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _Action('My Warranties', Icons.verified_user_outlined, () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => const WarrantiesScreen()))),
      _Action('Register Warranty', Icons.qr_code_scanner, () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterWarrantyScreen()))),
      _Action('Submit / Track Claim', Icons.track_changes, () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ClaimScreen()))),
      _Action('Customer Support', Icons.support_agent, () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportScreen()))),
      _Action('Staff Admin', Icons.admin_panel_settings, () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminScreen()))),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('HASHIMI MOBILES')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [Color(0xFF102D65), Color(0xFF1C559C)]),
            ),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Warranty & Service', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Buy Smart • Stay Confident', style: TextStyle(color: Colors.white70)),
              SizedBox(height: 12),
              Text('Your warranty details and service updates in one place.', style: TextStyle(color: Colors.white)),
            ]),
          ),
          const SizedBox(height: 18),
          ...actions.map((a) => Card(
            child: ListTile(
              leading: CircleAvatar(backgroundColor: const Color(0xFFE8EFFB), child: Icon(a.icon, color: const Color(0xFF123A78))),
              title: Text(a.title, style: const TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.chevron_right),
              onTap: a.onTap,
            ),
          )),
          const SizedBox(height: 18),
          const Card(child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('HASHIMI MOBILES', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              Text('Mia Aslam Plaza, Jalalabad, Nangarhar, Afghanistan'),
              Text('Call: 0777799150'),
            ]),
          )),
        ],
      ),
    );
  }
}

class _Action {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  _Action(this.title, this.icon, this.onTap);
}
