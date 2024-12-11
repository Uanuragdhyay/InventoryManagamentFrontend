import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class AddProductScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final product = Product(
                  name: nameController.text,
                  category: categoryController.text,
                  quantity: int.parse(quantityController.text),
                  price: double.parse(priceController.text),
                );
                ProductService().createProduct(product).then((_) {
                  Navigator.pop(context); // Return to the previous screen
                });
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
