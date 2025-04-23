import 'package:flutter/material.dart';



class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<String> _data = [
    'nike',
    'nike',
    'nike',
    'nike',
    'nike',
    'nike',
  ];

  List<String> _filteredData = [];

  String _filter = '';

  @override
  void initState() {
    super.initState();
    _filteredData.addAll(_data);
  }

  void _applyFilter() {
    setState(() {
      _filteredData = _data.where((item) => item.toLowerCase().contains(_filter.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _filter = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Filter',
                hintText: 'Enter filter text...',
                prefixIcon: Icon(Icons.filter_list),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _applyFilter,
            child: const Text('Apply Filter'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredData[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
