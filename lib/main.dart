import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: body(),
      ),
    );
  }
}

class body extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              new Image(
                image: AssetImage('assets/index.png'),
                width: 150.0,
                height: 150.0,
                fit: BoxFit.cover,
              ),
              new Padding(
                padding: EdgeInsets.all(8.0),
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Kode Sekolah",
                  fillColor: Colors.grey[100],
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 70.0, 10.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),

                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(8.0),
              ),

              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Nomer Induk Siswa / Kependidikan",
                  fillColor: Colors.grey[100],
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Colors.yellow[800],
                    ),
                  ),

                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(8.0),
              ),
              new TextFormField(
                obscureText: true,
                decoration: new InputDecoration(
                  labelText: "Password",
                  fillColor: Colors.grey[100],
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 70.0, 10.0),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Colors.yellow[800],
                    ),
                  ),

                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if (val.length == 0) {
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(8.0),
              ),
              /*new RaisedButton(
              padding: EdgeInsets.all(15.0),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              widht : 10.0,
              onPressed: () {},
              color: Colors.blue[300],
              child: Text(
                "Button",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontSize: 20.0,
                ),
              ),
            ),*/

              SizedBox(
                width: double.infinity,
                height: 50.0,
                // match_parent
                child: new RaisedButton(
                  padding: EdgeInsets.all(15.0),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  color: Colors.blue[300],
                  child: Text(
                    "MASUK",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 15.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
