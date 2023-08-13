import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Previous extends StatefulWidget {
  const Previous({super.key});

  @override
  State<Previous> createState() => _PreviousState();
}

class _PreviousState extends State<Previous> {
  @override
  final user = FirebaseAuth.instance.currentUser;

  String? name;
  String? usn;
  String? email;
  String? address;
  String? image;
  String? vehicle;
  String? number;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List? l = [];



  Details() async{
  await firestore.collection('rides').where('rider',isEqualTo: user?.email).get().then((value) {
    //print(user?.email);
    List l = [];
    //print(value.docs);
    value.docs.forEach((element) {
      l.add(element.data());
      print(element.data);
    });
    setState(() {
      this.l = l;
    });
    print(l);
    //print(image);
    print(l.length);
  });
}

   @override
   void initState() {
    // TODO: implement initState
    super.initState();

    Details();
    print(l);
    print("hello");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Previous Rides')),
      body: l==[]?Center(child: Text("No rides found!"),):SafeArea(
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
                           
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'From: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  l![index]['start'],
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
                                  l![index]['to'],
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
                                  l![index]['time'],
                                  style: TextStyle(overflow: TextOverflow.fade),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: l?.length,
        
      )),
    );
  }
}