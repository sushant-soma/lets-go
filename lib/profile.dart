import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:letsgo/createprofile.dart';
import 'package:letsgo/edit.dart';
import 'package:letsgo/extraSeat.dart';
import 'package:letsgo/updateprofile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  
  State<Profile> createState() => _ProfileState();
  
}

class _ProfileState extends State<Profile> {

  final user = FirebaseAuth.instance.currentUser;

  String? name;
  String? usn;
  String? email;
  String? address;
  String? image;
  String? vehicle;
  String? number;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Details() async{
    //.orderBy('createdAt',descending: true)
    
      await firestore.collection('users').where('email',isEqualTo: user?.email).get().then((value) {
        //print(user?.email);
        List l = [];
        //print(value.docs);
                value.docs.forEach((element) {
                  l.add(element.data());
                  print(element.data);
                });
                print(l);
                usn = l[0]['usn'];
                print(usn);
                name = l[0]['Name'];
                email = l[0]['email'];
                address = l[0]['address'];
                image = l[0]['image'];
                if(image==null){
                  image = 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
                }
                vehicle = l[0]['vehicle'];
                number = l[0]['number'];
                setState(() {
                  
                });
                //print(image);
              });
   }

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Details();
  }
  
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), actions: [IconButton(onPressed: () {
        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Editprofile(),
                            ),
                          );
      }, icon: Icon(Icons.edit))],),
      body: name==null?Center(child: CircularProgressIndicator(),):SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(image!),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(usn!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Number   :"),
                    trailing: Text("${number}"),
                  ),
                  ListTile(
                    title: Text("Address   :"),
                    trailing: Text("${address}"),
                  ),
                  ListTile(
                    title: Text("Email   :"),
                    trailing: Text("${usn}"),
                  ),
                  ListTile(
                    title: Text("Vehicles   :"),
                    trailing: Expanded(child: Text("${vehicle}")),
                  ),
                  SizedBox(
                  height: 30,
                ),
                // ElevatedButton(onPressed: (){
                //   Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) =>Update(name,usn,address,vehicle,number),
                //             ),
                //           );
                // }, child: Text("Update my Profile"))
                ]),
                
          ),
        ),
      ),
    );
  }
}
