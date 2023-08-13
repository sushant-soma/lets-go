import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'firstpage.dart';

class CreateProfile extends StatelessWidget {
  const CreateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Create());
  }
}

class Create extends StatefulWidget {
  const Create({Key? key}) : super(key: key);

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController name = TextEditingController();

  TextEditingController usn = TextEditingController();

  TextEditingController address = TextEditingController();

  TextEditingController vehicle = TextEditingController();

  TextEditingController number = TextEditingController();

  File? imageFile;
String? downUrl;
  String? error = "";

  final user = FirebaseAuth.instance.currentUser;
  

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    //print(pickedFile);

    if (pickedFile != null) {
      cropImage(pickedFile);
    }
  }

  void cropImage(XFile file) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: file.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 20);
    print("$croppedImage,3");
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
        uploadData(imageFile!);
      });
    }
  }

  void showPhotoOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.gallery);
                  },
                  leading: Icon(Icons.photo_album),
                  title: Text("Select from Gallery"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage(ImageSource.camera);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text("Take a photo"),
                ),
              ],
            ),
          );
        });
  }

  void uploadData(File image) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
  print("----------------");
  print(user?.email);
  print(downUrl);
  print(imageFile);
  print("----------------");
 
    //UIHelper.showLoadingDialog(context, "Uploading image..");
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("profilePictures/${user?.email}")
        .putFile(image);

    TaskSnapshot snapshot = await uploadTask;
     downUrl = await snapshot.ref.getDownloadURL();
    print(downUrl);
    //Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create your profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CupertinoButton(
                  onPressed: () {},
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        // ignore: unnecessary_null_comparison
                        (imageFile != null) ? FileImage(imageFile!) : null,
                    child: (imageFile == null)
                        ? const Icon(
                            Icons.person,
                            size: 60,
                          )
                        : null,
                  ),
                ),
                Positioned(
                  right: -15,
                  top: 80,
                  child: CupertinoButton(
                    onPressed: () {
                      showPhotoOptions();
                    },
                    child: ClipOval(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 20,
                          )),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name*',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: usn,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter usn*',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: address,
                minLines: 3,
                maxLines: 6,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter address*',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter phone number*',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: vehicle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter vehicle name(if exists)',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        print(name.text);
                        if (name.text == "" ||
                            usn.text == "" ||
                            address.text == "" ||
                            number.text ==  "") {
                          setState(() {
                            error = 'Fill all the Required fields';
                          });
                        } else {
                          await firestore.collection('users').add({
                            'email': user?.email,
                            'Name': name.text,
                            'usn': usn.text,
                            'address': address.text,
                            'vehiclename': vehicle.text,
                            'image': downUrl,
                            'number':number.text,
                            'createdAt':Timestamp.now(),
                          }).then((name) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Created Successfully')));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => First(),
                              ),
                            );
                          }).catchError((err) {
                            setState(() {
                              error = err;
                            });
                          });
                        }
                      },
                      child: const Text("CREATE"))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                error!,
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
