import 'package:flutter/material.dart';
import 'package:security_system/ui/forgotpass.dart';
import 'package:security_system/ui/home.dart';
import 'package:security_system/ui/signup.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Back'),
        centerTitle: true,
        backgroundColor: Color(0xFF1C2321),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 20,
                bottom: 180,
                child: SizedBox(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: username,
                            cursorColor: Colors.grey,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(
                                Icons.people_outline_outlined,
                                color: Colors.grey,
                              ),
                              hintText: 'Username',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50,
                bottom: 70,
                child: SizedBox(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: password,
                            cursorColor: Colors.grey,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(
                                Icons.password_outlined,
                                color: Colors.grey,
                              ),
                              hintText: 'Password',
                            ),
                            obscureText: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 175,
                right: 15,
                bottom: -50,
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPass(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF1C2321),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 15,
                right: 15,
                child: SizedBox(
                  child: Form(
                    key: formKey,
                    child: GestureDetector(
                      onTap: () {
                        String tUser = 'anton';
                        String tPass = '123';
                        if (username.text.isEmpty || password.text.isEmpty) {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Username and Password cannot be empty'),
                              ),
                            );
                          });
                        } else if (username.text == tUser &&
                            password.text == tPass) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(
                                  // username: username.text,
                                  // password: password.text,
                                  ),
                            ),
                          );
                        } else {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Invalid username or password'),
                              ),
                            );
                          });
                        }
                      },
                      child: Container(
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1C2321),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                            child: Text('Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                )),
                          )),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't Have an Account?",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF1C2321),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Registration(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1C2321),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
