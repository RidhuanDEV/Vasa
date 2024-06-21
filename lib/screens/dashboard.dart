// import 'package:flutter/material.dart';
// import 'package:vasa/screens/tambahbudget.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Thu, Nov 19'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       drawer: const Drawer(), // Add your drawer widget here
//       body: const Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CircularBudget(),
//             SizedBox(height: 20),
//             BudgetSection(),
//             SizedBox(height: 20),
//             TransactionSection(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CircularBudget extends StatelessWidget {
//   const CircularBudget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           height: 200,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(color: Colors.grey.shade300, width: 8),
//           ),
//           child: const Center(
//             child: Text(
//               'Budget\n\$00.0',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 24),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Indicator(text: 'Grocery'),
//             Indicator(text: 'Medication'),
//             Indicator(text: 'Transport'),
//             Indicator(text: 'Cloth'),
//             Indicator(text: 'Beauty'),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class Indicator extends StatelessWidget {
//   final String text;

//   const Indicator({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const CircleAvatar(
//           radius: 5,
//           backgroundColor: Colors.grey,
//         ),
//         const SizedBox(height: 4),
//         Text(
//           text,
//           style: const TextStyle(fontSize: 12),
//         ),
//       ],
//     );
//   }
// }

// class BudgetSection extends StatelessWidget {
//   const BudgetSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('Budgets',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             TextButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const AddBudgetScreen()),
//                 );
//               },
//               child: const Text('+ Add new'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         const SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               BudgetCard(icon: Icons.restaurant, label: 'Restaurant'),
//               BudgetCard(icon: Icons.directions_bus, label: 'Transport'),
//               BudgetCard(icon: Icons.shopping_cart, label: 'Grocery'),
//               BudgetCard(icon: Icons.medical_services, label: 'Medication'),
//               BudgetCard(icon: Icons.brush, label: 'Beauty'),
//             ],
//           ),
//         ),
//         const SizedBox(height: 20),
//         Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.0),
//             color: Colors.grey.shade200,
//           ),
//           child: const Center(
//             child: Text('Budgets details will be displayed here'),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class BudgetCard extends StatelessWidget {
//   final IconData icon;
//   final String label;

//   const BudgetCard({super.key, required this.icon, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 24,
//             backgroundColor: Colors.grey.shade200,
//             child: Icon(icon, color: Colors.black),
//           ),
//           const SizedBox(height: 8),
//           Text(label),
//           const Text('\$0'),
//         ],
//       ),
//     );
//   }
// }

// class TransactionSection extends StatelessWidget {
//   const TransactionSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('Transactions',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             TextButton(
//               onPressed: () {},
//               child: const Text('+ Add new'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         Container(
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.0),
//             color: Colors.grey.shade200,
//           ),
//           child: const Center(
//             child: Text('Transactions details will be displayed here'),
//           ),
//         ),
//       ],
//     );
//   }
// }
