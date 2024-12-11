import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;

  ProductCard({required this.product, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black38,
      elevation: 4,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          product.name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category: ${product.category}',
              style: TextStyle(color: Colors.grey[400]),
            ),
            Text(
              'Quantity: ${product.quantity}',
              style: TextStyle(color: Colors.grey[400]),
            ),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
