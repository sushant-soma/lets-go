import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:letsgo/createprofile.dart';
import 'package:letsgo/firstpage.dart';

class LoadingPage extends StatelessWidget {
  LoadingPage({super.key});
  
  final user = FirebaseAuth.instance.currentUser;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firestore.collection('users').where('email', isEqualTo: user?.email).get(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          print(snapshot.data?.docs);
        if(snapshot.data?.size!=0){
          
          return First();
        }
        else{
          return CreateProfile();
        }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}