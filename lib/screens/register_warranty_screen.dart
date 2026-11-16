import 'package:flutter/material.dart';

class RegisterWarrantyScreen extends StatefulWidget {
  const RegisterWarrantyScreen({super.key});
  @override
  State<RegisterWarrantyScreen> createState() => _RegisterWarrantyScreenState();
}

class _RegisterWarrantyScreenState extends State<RegisterWarrantyScreen> {
  final _form = GlobalKey<FormState>();
  final _imei = TextEditingController();
  final _invoice = TextEditingController();
  final _model = TextEditingController();
  String _brand = 'Apple';

  @override
  void dispose() { _imei.dispose(); _invoice.dispose(); _model.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Register Warranty')),
    body: Form(key: _form, child: ListView(padding: const EdgeInsets.all(18), children: [
      const Text('Register a phone purchased from HASHIMI MOBILES. Staff verification is required before a warranty becomes active.'),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(
        value: _brand, decoration: const InputDecoration(labelText: 'Brand', border: OutlineInputBorder()),
        items: ['Apple','Samsung','vivo','OPPO','Xiaomi','Other'].map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
        onChanged: (v) => setState(() => _brand = v ?? 'Other'),
      ),
      const SizedBox(height: 12),
      TextFormField(controller: _model, decoration: const InputDecoration(labelText: 'Model', border: OutlineInputBorder()), validator: _required),
      const SizedBox(height: 12),
      TextFormField(controller: _imei, decoration: const InputDecoration(labelText: 'IMEI 1 (15 digits)', border: OutlineInputBorder()), keyboardType: TextInputType.number, validator: (v) => (v == null || !RegExp(r'^\\d{15}$').hasMatch(v.trim())) ? 'Enter a valid 15-digit IMEI' : null),
      const SizedBox(height: 12),
      TextFormField(decoration: const InputDecoration(labelText: 'IMEI 2 (optional)', border: OutlineInputBorder()), keyboardType: TextInputType.number),
      const SizedBox(height: 12),
      TextFormField(controller: _invoice, decoration: const InputDecoration(labelText: 'Invoice number', border: OutlineInputBorder()), validator: _required),
      const SizedBox(height: 18),
      FilledButton(onPressed: () {
        if (_form.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo form validated. Connect Supabase and staff verification before accepting real registrations.')));
        }
      }, child: const Text('Submit for Verification')),
      const SizedBox(height: 8),
      const Text('Customer self-registration is a request, not automatic warranty activation. Staff must match the IMEI to the shop invoice.', style: TextStyle(color: Colors.black54)),
    ])),
  );

  String? _required(String? v) => (v == null || v.trim().isEmpty) ? 'This field is required' : null;
}
