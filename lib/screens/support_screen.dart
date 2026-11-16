import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Customer Support')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Icon(Icons.support_agent, size: 72, color: Color(0xFF123A78)),
      const Center(child: Text('We are here to help', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
      const SizedBox(height: 18),
      ListTile(leading: const Icon(Icons.call), title: const Text('0777799150'), subtitle: const Text('HASHIMI MOBILES'), onTap: () => Clipboard.setData(const ClipboardData(text: '0777799150'))),
      const ListTile(leading: Icon(Icons.location_on), title: Text('Mia Aslam Plaza'), subtitle: Text('Jalalabad, Nangarhar, Afghanistan')),
      const ListTile(leading: Icon(Icons.language), title: Text('Languages'), subtitle: Text('Pashto • Dari • English (translation rollout required)')),
    ]),
  );
}
