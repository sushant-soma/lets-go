import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Available rides',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                      //<-- SEE HERE
                      side: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    leading: const Icon(Icons.face),
                    trailing: Column(
                      children: [
                        const Icon(Icons.call),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: SizedBox(
                            width: 60,
                            height: 30,
                            child: ElevatedButton(onPressed: (){}, child: Text("GO"))),
                        )
                      ],
                    ),
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(
                        children: [
                          Text("Person ${index + 1}"),
                          Text("Destination ${index + 1}"),
                          Text("Time : 18.00")
                        ],
                      ),
                    )),

              );
            }),
      ),
    );
  }
}
