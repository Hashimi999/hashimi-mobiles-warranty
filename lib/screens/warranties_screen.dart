import 'package:flutter/material.dart';

class WarrantiesScreen extends StatelessWidget {
  const WarrantiesScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('My Warranties')),
    body: ListView(padding: const EdgeInsets.all(16), children: const [
      _WarrantyCard(brand: 'Apple', model: 'iPhone (example record)', provider: 'Distributor / brand policy'),
      _WarrantyCard(brand: 'Samsung', model: 'Galaxy (example record)', provider: 'Brand policy'),
      _WarrantyCard(brand: 'vivo', model: 'Y Series (example record)', provider: 'Brand policy'),
      SizedBox(height: 12),
      Text('These are sample display records only. Real warranty records appear after backend setup and verified registration.',
        style: TextStyle(color: Colors.black54)),
    ]),
  );
}

class _WarrantyCard extends StatelessWidget {
  final String brand, model, provider;
  const _WarrantyCard({required this.brand, required this.model, required this.provider});
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: const Icon(Icons.verified_user, color: Colors.green),
      title: Text('$brand • $model'),
      subtitle: Text('Provider: $provider\\nStatus: Sample only — not a verified warranty'),
      isThreeLine: true,
    ),
  );
}
