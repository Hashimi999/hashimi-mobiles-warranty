import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Staff Admin Preview')),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Dashboard preview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      const Text('Illustrative figures only — not live business data. Admin login and role checks must be enabled before deployment.'),
      const SizedBox(height: 16),
      const Wrap(spacing: 10, runSpacing: 10, children: [
        _Metric('Registered warranties','0'),
        _Metric('Pending claims','0'),
        _Metric('Completed claims','0'),
        _Metric('Expiring soon','0'),
      ]),
      const SizedBox(height: 18),
      const ListTile(leading: Icon(Icons.verified_user), title: Text('Warranty verification'), subtitle: Text('Match IMEI, invoice and policy before activation')),
      const ListTile(leading: Icon(Icons.assignment), title: Text('Claims management'), subtitle: Text('Review claims and record status changes')),
      const ListTile(leading: Icon(Icons.people), title: Text('Staff & permissions'), subtitle: Text('Owner, manager and service staff roles')),
    ]),
  );
}

class _Metric extends StatelessWidget {
  final String label, value;
  const _Metric(this.label, this.value);
  @override
  Widget build(BuildContext context) => SizedBox(width: 155, child: Card(child: Padding(padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)), Text(label)]))));
}
