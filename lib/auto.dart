import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:letsgo/roomList.dart';

class Auto extends StatelessWidget {
  Auto({super.key});

  final user = FirebaseAuth.instance.currentUser;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List? map;

  List? arr;

  SelectRoom(BuildContext context)async{
    await firestore.collection('waitingRooms').where('status', whereIn: ['waiting','ready']).get().then((value) {
      if(value.size==0){
        firestore.collection('waitingRooms').add({
          'people':[user?.email],
          'status':'waiting'
        }).then((value) {
          print(value.id);
          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomList(map: [user?.email],id: value.id),
                            ),
                          );
        });
      }else{
        final room = firestore.collection('waitingRooms').doc(value.docs[0].id).get().then((value) {
          print(value.data());
        });
        final id = value.docs[0].id;
        firestore.collection('waitingRooms').doc(id).get().then((value) {
          var status = 'waiting';
           map =value.data()!['people'];
          if(map?.length==2){
            status='completed';
          }
          if(!map!.contains(user?.email)){
          map!.add(user?.email);}
             print(map);
             print(arr);
            firestore.collection('waitingRooms').doc(id).set({
          'people':map,
          'status':status

        }).then((value) {
          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomList(map: map,id: id),
                            ),
                          );
        });
        });

        
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    SelectRoom(context);
    return Scaffold(
      body: Center(child: CircularProgressIndicator())
    );
  }
}