import 'package:chatapp/models/user_models.dart';
import 'package:chatapp/screen/homepage.dart';
import 'package:chatapp/screen/signuppage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/widgets/buttonwidget.dart';
import 'package:chatapp/widgets/textfieldwidget.dart';
import 'package:chatapp/widgets/textwidget.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginScreen({Key? key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  
  
Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
       // ignore: use_build_context_synchronously
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
      
    } catch (e) {
      // Handle any errors that may occur during sign-in
      // ignore: avoid_print
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future customDialogBox(String erroMessage) async{
 return  showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(erroMessage),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
}

checkValue(){
  if (emailAddress.text.isEmpty) {
    customDialogBox("Please Enter Email Address");
  }else if (password.text.isEmpty) {
    customDialogBox("Please Enter Password");
  }else{
    loginUser();
  }
}
Future<void> loginUser() async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailAddress.text, password: password.text);

    if (userCredential.user != null) {
      String uid = userCredential.user!.uid;
      DocumentSnapshot userData =
          await FirebaseFirestore.instance.collection("user").doc(uid).get();

      if (userData.exists) {
        UserModel userModel =
            UserModel.fromMap(userData.data() as Map<String, dynamic>);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } 
    }
  }  on FirebaseAuthException catch (e) {
    String errorMessage = "An error occurred";

    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'No user found for that email.';
        break;
      case 'wrong-password':
        errorMessage = 'Wrong password provided for that user.';
        break;
      case 'invalid-email':
        errorMessage = 'The email address is invalid.';
        break;
      case 'user-disabled':
        errorMessage = 'The user account has been disabled.';
        break;
      case 'too-many-requests':
        errorMessage = 'The user has made too many requests in a short period of time.';
        break;
      case 'network-error':
        errorMessage = 'There was a network error while processing the request.';
        break;
      case 'internal-error':
        errorMessage = 'An internal error occurred.';
        break;
      default:
        // Handle other errors here
    }
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Login Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

  bool isPassVisible =true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        body: Container(
           height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
         decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/loginScreenImage.png"),
          fit: BoxFit.cover,
        ),
      
        ),
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 const TextWidget(textMessage: "Log in to Shh!", textColor: Colors.white, textSize: 40),
                      
                      const SizedBox(height: 40,),
                       InkWell(
                        onTap: () {
                        //  fireBaseFunctions.signInWithGoogle();
                          signInWithGoogle();
                        },
                        child: CustomButtonWidget(imageAddress: "assets/images/googlelogo.png", bgColor: Colors.black, textMessage: "Sign in with Google", textColor: Colors.white, textSize: 20, buttonWidth: MediaQuery.of(context).size.width*0.8,)),
                    const SizedBox(height: 40,),
                     Image.asset("assets/images/continuewithEmail.png"),
                      const SizedBox(height: 40,),
                         const Padding(
                           padding: EdgeInsets.only(left:50),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               TextWidget(textMessage: "Username or Email", textColor: Colors.black, textSize: 15),
                             ],
                           ),
                         ),
                        const SizedBox(height: 10,),
                      CustomTextField(textFieldController: emailAddress,),
                         const SizedBox(height: 20,),
                         const Padding(
                           padding: EdgeInsets.only(left:50 , right: 50),
                           child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               TextWidget(textMessage: "Password", textColor: Colors.black, textSize: 15),
                               TextWidget(textMessage: "Forgot", textColor: Colors.black, textSize: 15),
                             ],
                           ),
                         ),
                        const SizedBox(height: 10,),
                      CustomTextField(textFieldController: password, isPass: isPassVisible, textFieldIcon: IconButton(onPressed: (){
                    setState(() {
                      isPassVisible =!isPassVisible;
                    });
                   }, icon: const Icon(Icons.remove_red_eye_outlined))),
              const SizedBox(height: 20,),
            InkWell(
                    onTap: () {
                        loginUser();
                    },
                    child: CustomButtonWidget( bgColor: Colors.black, textMessage: "Login", textColor: Colors.white, textSize: 20, buttonWidth: MediaQuery.of(context).size.width*0.4,)),
              
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                           const TextWidget(textMessage: "Don’t have an account?", textColor: Colors.white, textSize: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const TextWidget(textMessage: "Sign up", textColor: Colors.black, textSize: 20),
    
                      ),
                       const SizedBox(height: 50,),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



