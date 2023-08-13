import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:letsgo/home.dart';
import 'package:swipebuttonflutter/swipebuttonflutter.dart';
import 'package:intl/intl.dart';

class Ride extends StatefulWidget {
  const Ride({super.key});

  @override
  State<Ride> createState() => _RideState();
}

class _RideState extends State<Ride> {
  TextEditingController timeinput = TextEditingController();
  TextEditingController destinput = TextEditingController();
  TextEditingController pininput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(60)),
            Container(
            padding: EdgeInsets.all(15),
            height:150,
            child:Center( 
               child:TextField(
                  controller: timeinput, //editing controller of this TextField
                  decoration: InputDecoration( 
                     icon: Icon(Icons.timer), //icon of text field
                     labelText: "Enter Time" //label text of field
                  ),
                  readOnly: false,  //set it true, so that user will not able to edit text
                  onTap: () async {
                    TimeOfDay? pickedTime =  await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                        );
                    
                    if(pickedTime != null ){
                        print(pickedTime.format(context));   //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.
      
                        setState(() {
                          timeinput.text = formattedTime; //set the value of text field. 
                        });
                    }else{
                        print("Time is not selected");
                    }
                  },
               )
            )
          ),
          Container(
            padding: EdgeInsets.all(15),
            height: 150,
            child: Center(
              child: TextField(
                controller: destinput,
                decoration: InputDecoration(
                  icon: Icon(Icons.place),
                  labelText: "Enter Destination"
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            height: 150,
            child: Center(
              child: TextField(
                controller: pininput,
                decoration: InputDecoration(
                  icon: Icon(Icons.pin),
                  labelText: "Enter PinCode"
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SwipingButton(text: "Swipe To GO", onSwipeCallback:(){
              Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
            },backgroundColor: Colors.blue,swipeButtonColor: Colors.white,iconColor: Colors.blue,),
          )
      
          ],
        ),
      ),
    );
  }
}