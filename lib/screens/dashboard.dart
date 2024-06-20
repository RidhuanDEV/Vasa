import 'package:flutter/material.dart';
import 'package:vasa/screens/tambahbudget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thu, Nov 19'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(), // Add your drawer widget here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircularBudget(),
            SizedBox(height: 20),
            BudgetSection(),
            SizedBox(height: 20),
            TransactionSection(),
          ],
        ),
      ),
    );
  }
}

class CircularBudget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          child: Center(
            child: Text(
              'Budget\n\$00.0',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300, width: 8),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Indicator(text: 'Grocery'),
            Indicator(text: 'Medication'),
            Indicator(text: 'Transport'),
            Indicator(text: 'Cloth'),
            Indicator(text: 'Beauty'),
          ],
        ),
      ],
    );
  }
}

class Indicator extends StatelessWidget {
  final String text;

  Indicator({required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 5,
          backgroundColor: Colors.grey,
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class BudgetSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Budgets',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddBudgetScreen()),
                );
              },
              child: Text('+ Add new'),
            ),
          ],
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              BudgetCard(icon: Icons.restaurant, label: 'Restaurant'),
              BudgetCard(icon: Icons.directions_bus, label: 'Transport'),
              BudgetCard(icon: Icons.shopping_cart, label: 'Grocery'),
              BudgetCard(icon: Icons.medical_services, label: 'Medication'),
              BudgetCard(icon: Icons.brush, label: 'Beauty'),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.shade200,
          ),
          child: Center(
            child: Text('Budgets details will be displayed here'),
          ),
        ),
      ],
    );
  }
}

class BudgetCard extends StatelessWidget {
  final IconData icon;
  final String label;

  BudgetCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey.shade200,
            child: Icon(icon, color: Colors.black),
          ),
          SizedBox(height: 8),
          Text(label),
          Text('\$0'),
        ],
      ),
    );
  }
}

class TransactionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () {},
              child: Text('+ Add new'),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.shade200,
          ),
          child: Center(
            child: Text('Transactions details will be displayed here'),
          ),
        ),
      ],
    );
  }
}
