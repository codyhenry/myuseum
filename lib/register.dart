import 'package:flutter/material.dart';
import 'package:myuseum/Utils/getAPI.dart';
String urlBase = "https://cop-4331-large-project.herokuapp.com";

class RegisterRoute extends StatefulWidget {
  @override
  _RegisterRouteState createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  @override

  //Values used throughout the state
  String _email = "";
  String _firstName = "";
  String _lastName = "";
  String _password = "";
  String _output = "";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'Email',),
                  onChanged: (text) {
                    _email = text;
                  }
              ),
              TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'First Name',),
                  onChanged: (text) {
                    _firstName = text;
                  }
              ),
              TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'Last Name',),
                  onChanged: (text) {
                    _lastName = text;
                  }
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: 'Password',),
                  onChanged: (text) {
                    _password = text;
                  }
              ),
              Text(
                  '$_output'
              ),
              ElevatedButton (
                onPressed: _register,
                child: Text('Register'),
              ),
            ],
          ),
        )
    );
    return Container();
  }

  void _register() {
    //Updates the text to Regsitering to make sure there is some kind of feedback
    setState(() {
      _output = "Registering...";
    });
    //converts th email, firstname, etc. into JSON format
    String content = '{"email": "' + _email + '","firstName": "' +
        _firstName + '","lastName": "' + _lastName + '","password": "' +
        _password + '"}';
    //Updates the url to direct to the register function
    String registerURL = urlBase + "/users/register";
    //posts the request and updates the outpuut to read whether or not it was successful
    Register.sendRegister(registerURL, content).then((value) {
      setState(() {
        if(value.compareTo("200") == 0)
          _output = "Account Created";
        else if(value.compareTo("409") == 0)
          _output = "Account already exists";
        else
          _output = "Error " + value;
      });
    });
  }

}