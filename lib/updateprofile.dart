import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Update extends StatelessWidget {
  String? usn;

  String? name;

  String? address;

  String? vehicle;

  String? number;

  Update(
      {super.key,
      required this.name,
      required this.usn,
      required this.address,
      required this.vehicle,
      required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    //backgroundImage: NetworkImage(image!),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  ListTile(
                      title: Text("Name   :"),
                      trailing: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: name,
                        ),
                      )),
                  ListTile(
                      title: Text("Usn    :"),
                      trailing: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: usn,
                        ),
                      )),
                  ListTile(
                      title: Text("Address :"),
                      trailing: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: address,
                        ),
                      )),
                  ListTile(
                      title: Text("Vehicle   :"),
                      trailing: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: vehicle,
                        ),
                      )),
                      ListTile(
                      title: Text("Number   :"),
                      trailing: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: number,
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
