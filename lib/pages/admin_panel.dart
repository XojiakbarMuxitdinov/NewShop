import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_shop/components/my_button.dart';
import 'package:new_shop/components/my_textfiled.dart';
import 'package:new_shop/components/square_tile.dart';

class AdminPanel extends StatefulWidget {
  AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  // text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sing user in method
  void singUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMassage();
      }
      
      // WRONG PASSWORD
       else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessge();
      }
    }
  }

  // wrong email massage popup
  void wrongEmailMassage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Email xato'),
          );
        },
      );
  }
  // wrong password massage popup
  void wrongPasswordMessge() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Parol xato'),
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              // logo

              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(
                height: 50,
              ),

              // welcome back, you've been missed!
              const Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(color: Colors.black45, fontSize: 16),
              ),

              const SizedBox(height: 25),

              // Email textfiled
              MyTextFiled(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // passvord textfiled
              MyTextFiled(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),
              // fogot passvord?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Parolni unutdigizmi ?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sing in button
              MyButton(
                onTap: singUserIn,
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Yoki davom eting',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                // google button
                SquareTile(imagePath: 'lib/image/google.png'),

                SizedBox(
                  height: 25,
                  width: 25,
                ),

                // apple botton
                SquareTile(imagePath: 'lib/image/apple.png'),
              ]),

              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Aʼzo emasmisiz?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'Ro\'yxatdan o\'tish',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
