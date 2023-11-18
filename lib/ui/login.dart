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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 10,
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 60,
                      bottom: -90,
                      child: SizedBox(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person_2_rounded,
                              color: Colors.grey,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: username,
                                  cursorColor: Colors.grey,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
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
                      top: 100,
                      left: 60,
                      bottom: -90,
                      child: SizedBox(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.password_outlined,
                              color: Colors.grey,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: password,
                                  cursorColor: Colors.grey,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
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
                      top: 130,
                      left: 15,
                      right: 15,
                      bottom: -150,
                      child: SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: 0.7,
                              child: Checkbox(
                                value: isChecked,
                                activeColor: Color(0xFF0CC0DF),
                                onChanged: (newBool) {
                                  setState(() {
                                    isChecked = newBool!;
                                  });
                                },
                              ),
                            ),
                            Text(
                              'Remember Password',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF0CC0DF),
                                fontWeight: FontWeight.w300,
                              ),
                            ),
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
                                  color: Color(0xFF0CC0DF),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 15,
                      right: 15,
                      child: SizedBox(
                        child: Form(
                          key: formKey,
                          child: GestureDetector(
                            onTap: () {
                              String tUser = 'anton';
                              String tPass = '123';
                              if (username.text.isEmpty ||
                                  password.text.isEmpty) {
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
                                      content:
                                          Text('Invalid username or password'),
                                    ),
                                  );
                                });
                              }
                            },
                            child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF0CC0DF),
                                        Color(0xFFFFDE59),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                child: const Center(
                                  child: Text('Login',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't Have an Account?",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF0CC0DF),
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
                                color: Color(0xFF0CC0DF),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
