import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Rides extends StatelessWidget {
  final List list;
  const Rides({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(title: Text('Available Rides')),
      body: SafeArea(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),
                  SizedBox(
                    
                    
                    width: MediaQuery.of(context).size.width-170,
                    child: Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[index]['rider'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'From: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  list[index]['start'],
                                  style: TextStyle(overflow: TextOverflow.fade),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'To: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  list[index]['to'],
                                  style: TextStyle(overflow: TextOverflow.fade),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Timings: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  list[index]['time'],
                                  style: TextStyle(overflow: TextOverflow.fade),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Confirm Ride'),
                            content: Text(
                                'Are you sure you want to confirm your ride with ${list[index]['rider']}'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.check))
                ],
              ),
            ),
          );
        },
        itemCount: list.length,
      )),
    );
  }
}
