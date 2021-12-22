import 'package:flutter_task_planner_app/ui/signup.dart';
import 'package:flutter_task_planner_app/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          backgroundColor: Color(0xFF262626),
          title: Padding(
            padding: EdgeInsets.all(70.0),
            child: Center(
              // child:
              // Text("TaskEzza!", style: GoogleFonts.biryani(fontSize: 40)),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: 100,
              ),
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height / 4,
          leading: Container(),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.vertical(
              bottom: new Radius.elliptical(
                  MediaQuery.of(context).size.width, 90.0),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Login",
                style: GoogleFonts.roboto(fontSize: 15),
              ),
              const SizedBox(height: 10.0),
              RaisedButton(
                color: Colors.white,
                child: Text(
                  "Login with Google",
                  style: GoogleFonts.roboto(fontSize: 15),
                ),
                onPressed: () async {
                  try {
                    await AuthHelper.signInWithGoogle();
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Enter email"),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter password"),
              ),
              const SizedBox(height: 10.0),
              RaisedButton(
                child: Text("Login", style: GoogleFonts.roboto(fontSize: 15)),
                color: Colors.white,
                onPressed: () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty) {
                    print("Email and password cannot be empty");
                    return;
                  }
                  try {
                    final user = await AuthHelper.signInWithEmail(
                        email: _emailController.text,
                        password: _passwordController.text);
                    if (user != null) {
                      print("login successful");
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              RaisedButton(
                child: Text(
                  "Create Account",
                  style: GoogleFonts.roboto(fontSize: 15),
                ),
                color: Colors.white,
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignupPage(),
                      ));
                },
              ),
              // Container(
              //     alignment: Alignment.topRight,
              //     child: Image.asset(
              //       "assets/images/girl.png",
              //       height: 300,
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
