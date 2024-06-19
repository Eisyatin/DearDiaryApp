import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diaryapp/component/my_button.dart';
import 'package:diaryapp/component/my_textfield.dart';
import 'package:diaryapp/component/square_tile.dart';
import 'package:diaryapp/services/auth_services.dart';


class LoginPage extends StatefulWidget {

  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editting controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async {

    // show loading circle
    showDialog(context: context, builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailController.text, 
                password: passwordController.text,
                );

    //pop the loading circle
      Navigator.pop(context);     

    } on FirebaseAuthException catch (e){
      //pop the loading circle
      Navigator.pop(context);
      //error message
      showErrorMessage(e.code);

    }

      }

      //wrong input message
      void showErrorMessage(String message){
        showDialog(context: context, builder: (context) {
          return  AlertDialog(
            backgroundColor: Colors.blue[600],
            title: Text(
              message,
              style: const TextStyle(color: Colors.white),),
            );
            },
        );
      }

      

    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea( //SafeArea so the lock avoid notch area 
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50,),
          
                //logo
                 const Icon(
                  Icons.lock,
                  size:100,
                  color: Colors.white,
                     ),
                  
                 const SizedBox(height: 50,),
          
                //Welcome back!
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    ),
                ),
          
                 const SizedBox(height: 25,),
          
                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'email',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10,),
          
                //password textfield
                 MyTextField(
                  controller: passwordController,
                  hintText: 'password',
                  obscureText: true,
                 ),
                 
                const SizedBox(height: 10,),
          
                //forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.white),
                        ),
          
                    ],
                  ),
                ),
          
                const SizedBox(height: 25,),
          
                //sign in button
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn ,),
                
                const SizedBox(height: 25,),
          
                //continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.white)),
                      ),
                
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 25,),
          
                //google sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'assets/images/google.png')
                  ],
                ),

                
          
                const SizedBox(height: 40,),
          
                //not a member?, register now!
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(color: Colors.white),
                      ),
          
                    const SizedBox(width: 4,),
          
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now",
                        style: TextStyle(color: Colors.yellow,
                        fontWeight: FontWeight.bold),
                        ),
                    ),
                  ],
                ),
          
                
              ],
              ),
          ),
        ),
      ),
    );
  }
}