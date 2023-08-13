import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:letsgo/auto.dart';
import 'package:letsgo/createprofile.dart';
import 'package:letsgo/extraSeat.dart';
import 'package:letsgo/needRide.dart';
import 'package:letsgo/previous.dart';
import 'package:letsgo/profile.dart';
import 'package:letsgo/ride.dart';

class First extends StatelessWidget {
  const First({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
            child: ListView(
          children: [
            ListTile(
              title: Text("Profile"),
              trailing: Icon(Icons.person),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ),
                );
                //await FirebaseAuth.instance.signOut();
              },
            ),
            
            ListTile(
              title: Text("Previous Rides"),
              trailing: Icon(Icons.history),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Previous(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.power_settings_new_outlined),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
            )
          ],
        )),
        body: Stack(
          children: [
            SizedBox(
              child: FlutterMap(
                options: MapOptions(
                  center: latLng.LatLng(12.941284047210978, 77.56548288665944),
                  zoom: 18,
                  maxZoom: 18,
                  keepAlive: true,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Center(child: Text("Have an extra seat")),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExtraSeat(),
                            ),
                          );
                        },
                        tileColor: Color.fromARGB(255, 121, 188, 198),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius:
                              BorderRadius.circular(20), //<-- SEE HERE
                        ),
                      ),
                    ),
                    //Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Center(child: Text("Need a ride")),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NeedRide(),
                            ),
                          );
                        },
                        tileColor: Color.fromARGB(255, 172, 244, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), //<-- SEE HERE
                        ),
                      ),
                    ),
                    //Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Center(child: Text("Go to metro by auto")),
                        onTap: () {
                          
                          
                        },
                        tileColor: Color.fromARGB(255, 172, 244, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), //<-- SEE HERE
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            )
          ],
        ));
  }
}

