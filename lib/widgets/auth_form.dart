// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shop_with_auth/utils/colors.dart';
import '../utils/utilities.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitFtn,this.isLoading,this.resetPass,{Key? key}) : super(key: key);
  final void Function(String userName, String userEmail, String userPassword,bool isLogin,BuildContext context)? submitFtn;
  final bool isLoading;
  final Future Function(String myEmail,BuildContext context,bool isReset)? resetPass;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey=GlobalKey<FormState>();
  bool _isLogin=true;
  bool isObsecure=true;
  bool reset=false;
  var _userName='';
  var _userEmail='';
  var _userPassword='';

  void _tryReset(){
    final isValid=_formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState!.save();
      widget.resetPass!(
        _userEmail.trim(),
        context,
        reset=false,
      );
    }
  }
  void _trySubmit(){
    final isValid=_formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      _formKey.currentState!.save();
      widget.submitFtn!(
        _userName.trim(),
        _userEmail.trim(),
        _userPassword.trim(),
        _isLogin,
        context,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: MyUpperClipper(),
            child: Container(
              height: size.height*0.265,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      MyColors.primaryClr,
                      MyColors.quaternaryClr,
                      MyColors.secondaryClr,
                    ]),
              ),
              child: Align(
                alignment: Alignment(-0.62,0),
                child: reset ? Text('Reset Password',style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: MyColors.quinaryClr, fontWeight: FontWeight.bold),) : Text(_isLogin? 'Login':'SignUp',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: MyColors.quinaryClr, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          Expanded(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height*0.05,),
                      if(!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value){
                          if(value!.isEmpty || value.length < 4){
                            return 'please enter at least 4 characters';
                          }
                          return null;
                        },
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                            constraints: BoxConstraints(
                              maxWidth: size.width*0.95,
                            ),
                            hintText: 'Enter Username',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                            suffixIcon: Icon(Icons.person_outline_outlined,size: 20),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purpleAccent,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45))),
                        onSaved: (value){
                          _userName=value!;
                        },
                      ),
                        TextFormField(
                          key: ValueKey('email'),
                          validator: (value){
                            if(value!.isEmpty || !value.contains('@') || !value.contains('.')){
                              return 'please enter a valid @email';
                            }
                            return null;
                          },
                          onSaved: (value){
                            _userEmail=value!;
                          },
                          cursorColor: Colors.purpleAccent,
                          decoration: InputDecoration(
                              constraints: BoxConstraints(
                                maxWidth: size.width*0.95,
                              ),
                              hintText: 'Enter Email',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),
                              suffixIcon: Icon(Icons.email,size: 20),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.purpleAccent,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black45))),
                        ),
                      if(!reset)
                      TextFormField(
                        key: ValueKey('password'),
                        validator: (value){
                          if(value!.isEmpty || value.length < 7){
                            return 'password must be of 7 characters';
                          }
                          return null;
                        },
                        onSaved: (value){
                          _userPassword=value!;
                        },
                        obscureText: isObsecure,
                        cursorColor: Colors.purpleAccent,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              padding: EdgeInsets.zero,

                              onPressed: (){
                                isObsecure=!isObsecure;
                                setState((){});
                              },
                              icon: isObsecure ? Icon(Icons.visibility_off,color: Colors.grey,size: 20,): Icon(Icons.visibility,color: MyColors.quaternaryClr,size: 20,),
                            ),
                            constraints: BoxConstraints(
                              maxWidth: size.width*0.95,
                            ),
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purpleAccent,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45))),
                      ),
                        if(!reset)
                      if(_isLogin)
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            onTap: (){
                              setState(() {
                                reset=!reset;
                              });
                            },
                            child: Text('Forgot Password?',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13),)),
                      ),
                      SizedBox(height: 10,),
                      if(widget.isLoading)
                        SpinKitCircle(color: MyColors.primaryClr,size: 35,),
                      if(!widget.isLoading)
                      ElevatedButton(
                        onPressed: reset ? _tryReset : _trySubmit,
                        child: reset ?  Text('Confirm Email') :Text(_isLogin ? 'Login':'Sign Up') ,
                        style: ElevatedButton.styleFrom(
                          primary: MyColors.tertiaryClr,
                          padding: EdgeInsets.symmetric(horizontal: size.width*0.12,vertical: size.width*0.03),

                        ),
                      ),
                    ]),
              ),
            ),
          ),
          RotateX(
            child: RotateY(
              child: ClipPath(
                clipper: MyUpperClipper(),
                child: Container(
                  height: size.height*0.265,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [
                          MyColors.primaryClr,
                          MyColors.quaternaryClr,
                          MyColors.secondaryClr,
                        ]),
                  ),
                  child: RotateX(
                    child: RotateY(
                      child: Align(
                        alignment: Alignment(0,0.2),
                        child: reset ? InkWell(
                          onTap: (){
                            setState((){
                              _isLogin=false;
                              reset=false;
                            });
                          },
                          child: Text(
                              'Create New Account',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: MyColors.quinaryClr) ),
                        ): Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _isLogin ? Text(
                              'Don\'t you have an account,',style: Theme.of(context).textTheme.bodyText2!.copyWith(color: MyColors.quinaryClr),
                            ):Text(
                              'If you already have an account,',style: Theme.of(context).textTheme.bodyText2!.copyWith(color: MyColors.quinaryClr),
                            ),
                            SizedBox(width: 4,),
                            InkWell(
                              onTap: (){
                                setState((){
                                  _isLogin=!_isLogin;
                                  reset=false;
                                });
                              },
                              child: _isLogin? Text(
                                  'Register',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: MyColors.quinaryClr) ): Text(
                                'Login',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: MyColors.quinaryClr),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}