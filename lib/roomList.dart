import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RoomList extends StatelessWidget {
  final map,id;
   RoomList({super.key, required this.map, required this.id});

  
  final user = FirebaseAuth.instance.currentUser;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Waiting Room')),
      body: Column(
        children: [
          Image.asset('assets/auto.png', height: 250,),
          Divider(),
          SizedBox(
            height: MediaQuery.of(context).size.height-500,
            child: StreamBuilder(stream: firestore.collection('waitingRooms').doc(id).snapshots(), builder: (context, snapshot) {
              if(snapshot.hasData){
                print(snapshot.data?.data()!['people']);
                final list = snapshot.data?.data()!['people'];
                return ListView.builder(itemBuilder: (context, index) {
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
                              Column(children: [
                                Text(list![index])
                              ],)
                      ],
                    ),
                  ),
                );
              },itemCount: list?.length,);
              }
              return CircularProgressIndicator();
            },),
          ),
        ],
      ),
    );
  }
}