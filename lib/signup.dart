import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:letsgo/main.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  static const String _title = 'Lets go';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Bmsce mail id',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Expanded(
                child: TextField(
                  controller: nameController2,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter verification code',
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController2,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Reenter password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign up'),
                  onPressed: () {
                    print(nameController1.text);
                    print(passwordController1.text);
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      );
                    })
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
