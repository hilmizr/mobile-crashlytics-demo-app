import 'package:flutter/material.dart';
import '../services/crash_service.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String _selectedCoffee = 'Espresso';
  int _quantity = 1;
  final int _pricePerCup = 25000; // Rp 25.000

  int get _total => _pricePerCup * _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Coffee'),
        backgroundColor: Colors.brown.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Aha! Screen: Try ordering 0 cups to see enriched reports.',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            DropdownButtonFormField<String>(
              value: _selectedCoffee,
              items: ['Espresso', 'Latte', 'Cappuccino']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedCoffee = val!),
              decoration: const InputDecoration(labelText: 'Coffee Type', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'Quantity', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() => _quantity = int.tryParse(val) ?? 0),
              controller: TextEditingController(text: _quantity.toString())..selection = TextSelection.fromPosition(TextPosition(offset: _quantity.toString().length)),
            ),
            const SizedBox(height: 24),
            Text(
              'Total: Rp $_total',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
              onPressed: _placeOrder,
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }

  void _placeOrder() async {
    // In a normal app, a crash report is just a stack trace.
    // Here, we add context to the report before the crash happens.
    // 1. Log Breadcrumb: What was the user doing?
    CrashService.logBreadcrumb('User tapped Place Order for $_selectedCoffee');

    // 2. Set Custom Keys: What was the exact state of the app?
    // Note: We await these to make sure they are saved *before* the app dies.
    await CrashService.setCustomKey('coffee_type', _selectedCoffee);
    await CrashService.setCustomKey('quantity', _quantity);
    await CrashService.setCustomKey('total_price', _total);

    // 3. The Planted Bug: Division by zero.
    // If quantity is 0, this line will crash the app instantly.
    // Because we added the keys above, the dashboard will tell us
    // exactly which coffee and quantity caused the disaster.
    final pricePerCupCheck = _total ~/ _quantity;

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order placed! Check per cup: Rp $pricePerCupCheck')),
      );
    }
  }
}
