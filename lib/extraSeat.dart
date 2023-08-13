import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:letsgo/firstpage.dart';
import 'package:letsgo/lists.dart';
import 'package:swipebuttonflutter/swipebuttonflutter.dart';

class ExtraSeat extends StatefulWidget {
  const ExtraSeat({super.key});

  @override
  State<ExtraSeat> createState() => _ExtraSeatState();
}

class _ExtraSeatState extends State<ExtraSeat> {
  final timeList = [
    '7:00 to 8:00',
    '8:00 to 9:00',
    '9:00 to 10:00',
    '10:00 to 11:00',
    '11:00 to 12:00',
    '12:00 to 13:00',
    '13:00 to 14:00',
    '14:00 to 15:00',
    '15:00 to 16:00',
    '16:00 to 17:00',
    '17:00 to 18:00',
    '18:00 to 19:00',
    '19:00 to 20:00',
  ];
  String? startValue;
  String? viaValue;
  String? toValue;
  String? timeValue;
  String? error;

  final user = FirebaseAuth.instance.currentUser;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: SwipingButton(
          backgroundColor: Colors.black,
          swipeButtonColor: Theme.of(context).primaryColor,
          text: 'Swipe to GO',
          onSwipeCallback: () async {
            if (startValue == null || toValue == null || timeValue == null) {
              setState(() {
                error = 'Select all Required fields';
              });
            } else if (startValue == toValue) {
              setState(() {
                error = 'Start and Destination cannot be same';
              });
            } else {
              await firestore.collection('rides').add({
                'rider': user?.email,
                'start': startValue,
                'via': viaValue,
                'to': toValue,
                'time': timeValue,
              }).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Added Successfully')));
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
        ),
      ),
      appBar: AppBar(
        title: Text('Look for companions'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'From : *',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      DropdownButton(
                        items: _createList(Lists.areasList),
                        hint: Text("Choose Start Location"),
                        value: startValue,
                        onChanged: (String? value) => setState(() {
                          startValue = value ?? "";
                        }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Via : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      DropdownButton(
                        items: _createList(Lists.areasList),
                        hint: Text("Choose Via Location"),
                        value: viaValue,
                        onChanged: (String? value) => setState(() {
                          viaValue = value ?? "";
                        }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'To : *',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      DropdownButton(
                        items: _createList(Lists.areasList),
                        hint: Text("Choose Destination Location"),
                        value: toValue,
                        onChanged: (String? value) => setState(() {
                          toValue = value ?? "";
                        }),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time: *',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      DropdownButton(
                        items: _createList(timeList),
                        hint: Text("Choose Time Interval"),
                        value: timeValue,
                        onChanged: (String? value) => setState(() {
                          timeValue = value ?? "";
                        }),
                      ),
                    ],
                  ),
                  if (error != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        error!,
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                ]),
          ),
        ),
      ),
    );
  }
}

final list = ["Apple", "Orange", "Kiwi", "Banana", "Grape"];
List<DropdownMenuItem<String>> _createList(List l) {
  return l
      .map<DropdownMenuItem<String>>(
        (e) => DropdownMenuItem(
          value: e,
          child: Text(e),
        ),
      )
      .toList();
}
