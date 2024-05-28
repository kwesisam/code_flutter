import 'package:flutter/material.dart';

class Dev extends StatefulWidget {
  const Dev({super.key});

  @override
  State<Dev> createState() => _DevState();
}

class _DevState extends State<Dev> {
  List<Map<String, dynamic>> devData = [
    {
      'name': 'Mohammed Amandi Hamza',
      'index': 'BSCIT/NR/02/22/0002',
      'email': 'cyrax1ha@gmail.com',
      'phone': '',
      'image': 'assets/images/moh.jpg',
    },
    {
      'name': 'George Amoako ',
      'index': 'BSCIT/NR/09/22/0006',
      'email': 'amoakogeorge@gmail.com',
      'phone': '054 760 8435',
      'image': 'assets/images/geo.jpg',
    },
    {
      'name': 'Isaac Kwadwo Frimpong',
      'index': 'CD/ITE/AS/09/22/0004',
      'email': 'isaacfk84@gmail.com',
      'phone': '024 972 8661',
      'image': 'assets/images/isa.jpg',
    },
    {
      'name': 'Danso John Junior',
      'index': 'CD/ITE/GA/14/22/0011',
      'email': 'dansojohn@gmail.com',
      'phone': '054 138 1360',
      'image': 'assets/images/dan.jpg',
    },
    {
      'name': 'Nimoah Rockson',
      'index': 'CD/ITE/AS/09/22/0012',
      'email': 'reginaldrockson14@gmail.com',
      'phone': '054 129 6170',
      'image': 'assets/images/nim.jpg',
    },
    {
      'name': 'Kenneth Gabriel Ofosu',
      'index': 'BSCIT/AS/09/23/0005',
      'email': 'kennethofosugabriel@gmail.com',
      'phone': '026 788 3924',
      'image': '',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 27,
          ),
        ),
        title: const Text('Developers Information',
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.brown[400],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Pil Remainder\'s Development Team',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: devData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Column(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 70,
                                  child: devData[index]['image'] == ''
                                      ? const Icon(
                                          Icons.person,
                                          size: 50,
                                        )
                                      : Image.asset(
                                          devData[index]['image'],
                                        ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                devData[index]['name'],
                                style: const TextStyle(fontSize: 19),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                devData[index]['email'],
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                devData[index]['phone'],
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                devData[index]['index'],
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/**
 * const spinkit = DancingSquare(
  color: Colors.white,
  size: 50.0,
);
 */