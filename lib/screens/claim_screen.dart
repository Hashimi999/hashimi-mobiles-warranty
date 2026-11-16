import 'package:flutter/material.dart';

class ClaimScreen extends StatefulWidget {
  const ClaimScreen({super.key});
  @override
  State<ClaimScreen> createState() => _ClaimScreenState();
}

class _ClaimScreenState extends State<ClaimScreen> {
  final _lookup = TextEditingController();
  String? _category;
  final _description = TextEditingController();

  @override
  void dispose() { _lookup.dispose(); _description.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Claims & Tracking')),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Track an existing claim', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      TextField(controller: _lookup, decoration: const InputDecoration(labelText: 'Claim ID or IMEI', border: OutlineInputBorder())),
      const SizedBox(height: 8),
      OutlinedButton.icon(onPressed: () => _message('Tracking will work after the backend is configured.'), icon: const Icon(Icons.search), label: const Text('Track Status')),
      const Divider(height: 32),
      const Text('Submit a new claim', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        value: _category, decoration: const InputDecoration(labelText: 'Problem category', border: OutlineInputBorder()),
        items: ['Screen','Battery','Camera','Charging','Software','Other'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
        onChanged: (v) => setState(() => _category = v),
      ),
      const SizedBox(height: 12),
      TextField(controller: _description, maxLines: 4, decoration: const InputDecoration(labelText: 'Describe the problem', border: OutlineInputBorder())),
      const SizedBox(height: 12),
      FilledButton(onPressed: () => _message('Claim submission will be enabled after customer authentication and warranty verification are connected.'), child: const Text('Submit Claim')),
      const SizedBox(height: 12),
      const Text('Never submit an IMEI or customer claim to an unverified person. Official claim status is shown only after the shop records it.', style: TextStyle(color: Colors.black54)),
    ]),
  );

  void _message(String s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s)));
}
