import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diaryapp/component/my_button.dart';
import 'package:diaryapp/component/my_textfield.dart';
import 'package:diaryapp/component/square_tile.dart';
import 'package:diaryapp/services/auth_services.dart';
import 'package:intl/intl.dart';
import 'package:diaryapp/component/setDate.dart';

class RegisterPage extends StatefulWidget {

  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editting controller
  final usernameController = TextEditingController();
  final dobController = TextEditingController();
  final numController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirm_passwordController = TextEditingController();
  

  //sign user up method
  void signUserUp() async {

    // show loading circle
    showDialog(context: context, builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
    );

    //try create new user
    try {
      //check if the password is same
      if (passwordController.text == confirm_passwordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailController.text, 
                password: passwordController.text,
                );
      }
      else{
        //show error message
        showErrorMessage("Password don't match");

      }

    //pop the loading circle
      Navigator.pop(context);     

    } on FirebaseAuthException catch (e){
      //pop the loading circle
      Navigator.pop(context);
      //error message
      showErrorMessage(e.code);

    }

      }//signUserup

      //wrong input message
      void showErrorMessage(String message){
        showDialog(context: context, builder: (context) {
          return  AlertDialog(
            backgroundColor: Colors.yellow,
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
                  size:70,
                  color: Colors.white,
                     ),
                  
                 const SizedBox(height: 30,),
          
                //Welcome back!
                Text(
                  'Lets create a new account!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    ),
                ),
          
                 const SizedBox(height: 25,),

                 //username textfield//
                MyTextField(
                  controller: usernameController,
                  hintText: 'username',
                  obscureText: false,  
                  ),
          
                const SizedBox(height: 10,),

                //dob textfield//
                DatePickerTextFieldWidget(
                  hintText: 'Date of Birth',
                ),
                    
                                  
                const SizedBox(height: 10,),

                                       
                //Phone Number textfield//
                MyTextField(
                  controller: numController,
                  hintText: 'phone number',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10,),
          
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

                //confirm password textfield
                 MyTextField(
                  controller: confirm_passwordController,
                  hintText: 'confirm password',
                  obscureText: true,
                  
                 ),
                 
                                       
                const SizedBox(height: 25,),
          
                //sign in button
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp ,
                 ),
                
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
                      "Already have account?",
                      style: TextStyle(color: Colors.white),
                      ),
          
                    const SizedBox(width: 4,),
          
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Now",
                        style: TextStyle(color: Colors.blue.shade900,
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
