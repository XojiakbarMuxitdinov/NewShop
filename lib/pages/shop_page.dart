import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../components/shoe_tile.dart';
import '../models/cart.dart';
import '../models/shoe.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Shoe> _filteredShoes = [];
  String? _selectedCategory;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredShoes = Provider.of<Cart>(context, listen: false).getShoeList();
  }

  void addShoeToCart(Shoe shoe) {
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);

    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Muvafaqiyatli qoshildi!'),
        content: Text('Savatingizni tekshiring'),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _filteredShoes = Provider.of<Cart>(context, listen: false).getShoeList();
      _applyFilter();
    });
  }

  void _applyFilter() {
    List<Shoe> shoes = Provider.of<Cart>(context, listen: false).getShoeList();

    if (_selectedCategory != null && _selectedCategory!.isNotEmpty) {
      shoes = shoes.where((shoe) => shoe.category == _selectedCategory).toList();
    }

    if (_searchController.text.isNotEmpty) {
      shoes = shoes.where((shoe) =>
          shoe.name.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    }

    setState(() {
      _filteredShoes = shoes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          // search bar
          Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => _applyFilter(),
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Icon(
                  Icons.search,
                  color: Colors.grey[600],
                ),
              ],
            ),
          ),

          // message
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Text(
              'everyone flies.. some fly longer than others',
              style: TextStyle(color: Colors.blue[600]),
            ),
          ),

          // filter options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Hot pics 🔥',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                DropdownButton<String>(
                  hint: const Text('Catigory'),
                  value: _selectedCategory,
                  items: <String>['Sneakers', 'Boots', 'Sandals', 'Formal']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                    _applyFilter();
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // list of shoes for sale
          Expanded(
            child: LiquidPullToRefresh(
              onRefresh: _handleRefresh,
              child: ListView.builder(
                itemCount: _filteredShoes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Shoe shoe = _filteredShoes[index];
                  return ShoeTile(
                    shoe: shoe,
                    onTap: () => addShoeToCart(shoe),
                  );
                },
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(
              top: 25.0,
              left: 25.0,
              right: 25.0,
            ),
            child: Divider(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
