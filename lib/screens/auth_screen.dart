import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_with_auth/utils/utilities.dart';

import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth=FirebaseAuth.instance;
  bool isLoading=false;
  Future<void> resetPass(String email, BuildContext ctx,bool reset)async{
    try{
      setState(() {
        isLoading=true;
      });
       await _auth.sendPasswordResetEmail(email: email);
       mySnackBar(ctx, 'Password reset email was sent');
      setState(() {
        isLoading=false;
      });
      setState(() {
        reset;
      });
    }on FirebaseAuthException catch(err){
      var message='An error occured, please recheck your credentials';
      if(err.message != null) {
        message = err.message!;
      }
      mySnackBar(ctx, message);
      setState(() {
        isLoading=false;
      });

    }
    catch (e){
      setState(() {
        isLoading=false;
      });

      mySnackBar(ctx, e.toString());
    }
  }

  Future<void> _submitAuthForm(String userName, String userEmail,String userPassword,bool isLogin,BuildContext ctx, ) async{
    UserCredential userCredential;
    try{
      setState(() {
        isLoading=true;
      });
      if(isLogin){
        userCredential= await _auth.signInWithEmailAndPassword(email: userEmail, password: userPassword);
      }
      else{
        userCredential = await _auth.createUserWithEmailAndPassword(email: userEmail, password: userPassword);
      }
      await FirebaseFirestore.instance.collection('user').doc(userCredential.user!.uid).set({
            'username': userName,
            'email': userEmail,

          });
    }
    on FirebaseException catch(err){
      var message='An error occured, please recheck your credentials';
      if(err.message != null) {
        message = err.message!;
      }
      mySnackBar(ctx, message);
      setState(() {
        isLoading=false;
      });
    }

    catch (err){
      print('$err catches');
      setState(() {
        isLoading=false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(_submitAuthForm,isLoading,resetPass),
    );
  }
}
