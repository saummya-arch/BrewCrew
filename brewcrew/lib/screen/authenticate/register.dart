import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading= false;

  //text field state
  String email= '';
  String password='';
  String error='';
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.7,
        title: Text("Register to Brew Crew"),
         actions: <Widget>[
          FlatButton.icon(
            onPressed: () {widget.toggleView();}, 
            icon: Icon(Icons.person),
             label: Text('Register'),
             )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6 ? 'Enter a passwor 6+ chars long' : null,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.brown[400],
                  child: Text('Register',style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(()=>loading=true);
                     dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                     if(result == null){
                       setState(() {
                         error ='please supply a valid email';
                         loading = false;
                         });
                     }
                    }
                  },
                  ),
                  SizedBox(height: 12.0,),
                  Text(
                    error,
                    style: TextStyle(color: Colors.brown,fontSize: 14.0),
                  )
              ],
            )
            ),
      ),
    );
  }
}