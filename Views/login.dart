import 'package:flutter/material.dart';

import '../main.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username;
  String password;

  String errorUsernamePassword;
  bool passwordVisibility = false;

  var types = [
    {
      'id': 1,
      'name': "User",
    },
    {
      'id': 2,
      'name': "Company",
    },
    
  ];

  @override
  void initState() {
    super.initState();
    selected = 1;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildLogo(size),
              buildInputField("Username", true),
              buildInputField("Password", passwordVisibility, bottom: 5.0),
              buildForgotPassword(),
              buildTypeText(),
              buildTypeSelection(),
              buildLoginButton(size),
              buildSignUpText(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Image.asset(
        "img/detective2.png",
        height: size.height / 4,
        width: size.width / 2,
      ),

    );
  }

  Widget buildInputField(String fieldName, bool visible, {bottom = 20.0}) {
    return Container(

      child: TextField(
        obscureText: !visible,
        onChanged: (text) {
          setState(() {
            if (visible)
              this.username = text;
            else
              this.password = text;
          });
        },
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          labelText: fieldName,
          hintText: fieldName,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          errorText: errorUsernamePassword,
          suffixIcon: fieldName == 'Password' ? buildEye(visible) : null,
        ),
      ),
      margin: EdgeInsets.fromLTRB(25, 0, 25, bottom),
    );
  }

  Widget buildLoginButton(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: FlatButton(
        onPressed: () {
          // TODO: implement validate function
          Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => Home(selectedType: selected),
              ));

        },
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        shape: StadiumBorder(),
        color: Colors.brown,
        splashColor: Colors.black,
        padding: EdgeInsets.fromLTRB(size.width / 8, 15, size.width / 8, 15),
      ),
    );
  }

  Widget buildSignUpText(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Don't Have an account yet, "),
          InkWell(
            child: Text(
              "SignUp Now",
              softWrap: true,
              style: TextStyle(
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () {

            },
          )
        ],
      ),
    );
  }

  Widget buildTypeText() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 30, top: 10),
      child: Text(
        "Login As:",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

// Get information through radio button to know which is logined user or company and send id in variable selected to verify--------------------------------- 

  Widget buildTypeSelection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(left: 20),
      child: Column(
        children: types.map((type) {
          return RadioListTile(
            value: type['id'],
            title: Text(type['name']),
            groupValue: selected,
            activeColor: Colors.brown,
            onChanged: (i) {
              setState(() {
                selected = i;

                print(selected);
              });
            },
          );
        }).toList(),
      ),
    );
  }
//-----------------------------------------------------------------------------------------

// --------------------- show your Password ----------------------------------------

  Widget buildEye(bool visible) {
    return IconButton(
        icon: Icon(visible ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            passwordVisibility = !passwordVisibility;
          });
        });
  }
//------------------------------------------------------

  Widget buildForgotPassword() {
    return Container(
      margin: EdgeInsets.only(right: 35),
      child: Align(
          child: InkWell(
            child: Text(
              "Forgot Password?!",
              style: TextStyle(
                color: Color(0xff325da3),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () => forgotPassword(),
          ),
          alignment: Alignment.centerRight),
    );
  }

  Future<bool> forgotPassword() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('You Really Forgot Your Password?!!!'),
                content: new Text('No Worries we will get you a new one.'),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: new Text('Ok'),
                  ),
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: new Text('Cancel'),
                  ),
                ],
              ),
        ) ??
        false;
  }
}
