import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService _productService = ProductService();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _productService.fetchProducts();
      setState(() {
        _products = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> _deleteProduct(int id) async {
    try {
      await _productService.deleteProduct(id);
      _fetchProducts();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<void> _addProduct(Product product) async {
    try {
      final newProduct = await _productService.createProduct(product);
      setState(() {
        _products.add(newProduct);
      });
      print('Added product: ${newProduct.name}');
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  void _showAddProductDialog() {
    String name = '';
    String category = '';
    int quantity = 0;
    double price = 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Product', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Name', labelStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Category', labelStyle: TextStyle(color: Colors.white)),
                  onChanged: (value) {
                    category = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Quantity', labelStyle: TextStyle(color: Colors.white)),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    quantity = int.tryParse(value) ?? 0;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Price', labelStyle: TextStyle(color: Colors.white)),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    price = double.tryParse(value) ?? 0.0;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (name.isNotEmpty && category.isNotEmpty && quantity > 0 && price > 0) {
                  _addProduct(Product(
                    id: null,
                    name: name,
                    category: category,
                    quantity: quantity,
                    price: price,
                  ));
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields correctly.')),
                  );
                }
              },
              child: Text('Add', style: TextStyle(color: Colors.green)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management', style: TextStyle(color: Colors.red)),
        backgroundColor: Colors.purple[800], // Slightly darker for better visibility
        elevation: 4, // Increase elevation for more shadow effect
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.blue),
            onPressed: _fetchProducts,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[800]!, Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: _products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              product: _products[index],
              onDelete: () => _deleteProduct(_products[index].id!),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
