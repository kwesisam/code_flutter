import 'package:flutter/material.dart';
import 'package:pils_recommendation/Pages/order_detials.dart';

class Orders extends StatefulWidget {
  final bool order;
  final bool confirmOrder;
  final bool makeOrder;
  const Orders(
      {super.key,
      required this.order,
      required this.confirmOrder,
      required this.makeOrder});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  TextEditingController searchController = TextEditingController();
  TextEditingController medicationNameController = TextEditingController();
  TextEditingController medicationIDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          if (widget.order) orders(),
          if (widget.makeOrder) searchDialog(),
          if (widget.confirmOrder) confirmOrder(),
        ],
      ),
    ));
  }

  Widget orders() {
    return Card(
      child: Column(
        children: [
          const Center(
            child: Text('Your  Orders'),
          ),
          ListBody(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderDetials()),
                  );
                },
                child: const ListTile(
                  title: Text('Order 1'),
                  subtitle: Text('Order 1 Description'),
                ),
              ),
              Divider(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderDetials()),
                  );
                },
                child: ListTile(
                  title: Text('Order 2'),
                  subtitle: Text('Order 2 Description'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget searchDialog() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Search',
              hintText: 'Search for drugs',
              isDense: true,
              suffixIcon: GestureDetector(
                  onTap: () {
                    print('search');
                  },
                  child: const Icon(
                    Icons.search,
                    size: 35,
                  )),
            ),
          ),
          const SizedBox(height: 10),
          const Column(
            children: [
              Center(
                child: Text('Search Results'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget confirmOrder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Center(
            child: Text('Confirm Order'),
          ),
          Form(
              child: Column(
            children: [
              TextFormField(
                controller: medicationNameController,
                decoration: InputDecoration(
                  labelText: 'Medication Name',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medication name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: medicationIDController,
                decoration: InputDecoration(
                  labelText: 'Medication ID',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medication ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    print('Order Confirmed');
                  },
                  child: const Text(
                    'Confirm Order',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ))
        ],
      ),
    );
  }
}
