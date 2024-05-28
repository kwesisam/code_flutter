import 'package:flutter/material.dart';

class OrderDetials extends StatefulWidget {
  const OrderDetials({super.key});

  @override
  State<OrderDetials> createState() => _OrderDetialsState();
}

class _OrderDetialsState extends State<OrderDetials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detials'),
      ),
    );
  }
}
