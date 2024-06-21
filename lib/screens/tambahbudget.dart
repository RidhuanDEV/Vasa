import 'package:flutter/material.dart';

class AddBudgetScreen extends StatefulWidget {
  const AddBudgetScreen({super.key});

  @override
  _AddBudgetScreenState createState() => _AddBudgetScreenState();
}

class _AddBudgetScreenState extends State<AddBudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedBudget;
  double? _amount;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedAccount;
  bool _repeatEveryMonth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select budget',
                ),
                items: const [
                  DropdownMenuItem(value: 'Transport', child: Text('Transport')),
                  DropdownMenuItem(value: 'Restaurant', child: Text('Restaurant')),
                  DropdownMenuItem(value: 'Grocery', child: Text('Grocery')),
                  DropdownMenuItem(value: 'Medication', child: Text('Medication')),
                  DropdownMenuItem(value: 'Cloth', child: Text('Cloth')),
                  DropdownMenuItem(value: 'Beauty', child: Text('Beauty')),
                  DropdownMenuItem(value: 'Entertainment', child: Text('Entertainment')),
                  DropdownMenuItem(value: 'Bill', child: Text('Bill')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedBudget = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a budget';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _amount = double.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Start date',
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _startDate = pickedDate;
                    });
                  }
                },
                controller: TextEditingController(
                  text: _startDate == null
                      ? ''
                      : "${_startDate!.day}/${_startDate!.month}/${_startDate!.year}",
                ),
                validator: (value) {
                  if (_startDate == null) {
                    return 'Please select a start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'End date',
                ),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _endDate = pickedDate;
                    });
                  }
                },
                controller: TextEditingController(
                  text: _endDate == null
                      ? ''
                      : "${_endDate!.day}/${_endDate!.month}/${_endDate!.year}",
                ),
                validator: (value) {
                  if (_endDate == null) {
                    return 'Please select an end date';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select account',
                ),
                items: const [
                  DropdownMenuItem(value: 'Account 1', child: Text('Account 1')),
                  DropdownMenuItem(value: 'Account 2', child: Text('Account 2')),
                  DropdownMenuItem(value: 'Account 3', child: Text('Account 3')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedAccount = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an account';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: const Text('Repeat for every month'),
                value: _repeatEveryMonth,
                onChanged: (value) {
                  setState(() {
                    _repeatEveryMonth = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle form submission here
                  }
                },
                child: const Text('Add budget'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
