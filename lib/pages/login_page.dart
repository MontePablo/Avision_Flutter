

import 'package:avision/storage/shared_preferences.dart';
import 'package:avision/utils/Utilities.dart';
import 'package:avision/utils/colors.dart';
import 'package:avision/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/my_custom_widgets.dart';
import '../data_models/loginRequest.dart';
import '../utils/routes.dart';
import '../viewmodels/auth_viewmodel.dart';
void main(){
  runApp(LoginPage());
}

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   var authViewModel=AuthViewModel();
  var loading=false;

  // FocusNode emailFocus=FocusNode();
  //
  // FocusNode passwordFocus=FocusNode();

  TextEditingController emailCont=TextEditingController();

  TextEditingController passwordCont=TextEditingController();

  ValueNotifier<bool> obsecurePass=ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Row(
              children: [
                SizedBox(
                  width: MyConstants.sw*.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset("assets/images/avision_full_logo.png",),
                      SizedBox(height: MyConstants.sh*.005,),
                      SizedBox(width: MyConstants.sw*.3,
                          child: Text("Already have an Account?",style: TextStyle(fontSize: MyConstants.sh*.03,fontWeight: FontWeight.bold),))
                    ],
                  ),
                ),
                SizedBox(width: MyConstants.sw*.6,
                    child: Image.asset("assets/images/login_illust.png",))
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: MyConstants.sw*.077),
              child: Column(
                  children:[
                    Column(
                      children: [
                        TextFormField(
                          decoration:InputDecoration(
                            hintText: "Email / Phone No.",
                            labelText: "Email/ Phone No.",
                          ),
                          // onFieldSubmitted: Utility.focusChange(context, emailFocus, passwordFocus),
                          // focusNode: emailFocus,
                          controller: emailCont,
                        ),
                        SizedBox(height: MyConstants.sh*.02,),
                        ValueListenableBuilder(
                          valueListenable: obsecurePass,
                          builder:(context,value,child){
                            return  TextFormField(
                              cursorColor: Colors.blue,
                              cursorErrorColor: Colors.red,
                              obscureText: obsecurePass.value,
                              obscuringCharacter: "#",
                              // focusNode: passwordFocus,
                              controller: passwordCont,
                              decoration:InputDecoration(
                                  hintText: "Password",
                                  labelText: "Password",
                                  suffixIcon:InkWell(
                                      onTap: (){
                                        obsecurePass.value=!obsecurePass.value;
                                      },
                                      child: Icon(obsecurePass.value?Icons.visibility_off_outlined:Icons.visibility))
                              ),
                            );
                          },
                        ),

                        SizedBox(height: MyConstants.sh*.02,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {  },
                              child: Text("Forget password?",style: TextStyle(color: Colors.blue.shade700),),
                            ),
                          ],
                        ),
                        SizedBox(height: MyConstants.sh*.02,),
                        Visibility(
                          visible: !loading,
                          child: ElevatedButton(
                              onPressed: (){
                                if(emailCont.text.isEmpty || passwordCont.text.isEmpty)
                                  Utility.flushbarErrorMsg("fill all fields first", context);
                                else
                                  performLogin(context);
                                // Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
                              },
                              style: TextButton.styleFrom(minimumSize: Size(60, 40),backgroundColor: Colors.blue.shade900),
                              child: Padding(
                                padding:  EdgeInsets.symmetric(horizontal: MyConstants.sw*.12,vertical: MyConstants.sh*.016),
                                child: Text("Login",style: TextStyle(color: Colors.white),),
                              )
                          ),
                        ),
                        SizedBox(height: MyConstants.sh*.01,),
                        TextButton(
                            onPressed: () {},
                            child: Text("New user? Register Now",style: TextStyle(color: Colors.blue.shade900,fontSize: 15,fontWeight: FontWeight.bold),)
                        ),
                        SizedBox(height: MyConstants.sh*.015,),
                        Text("Use other Methods",textAlign: TextAlign.center,),
                        SizedBox(height: MyConstants.sh*.015,),
                        Visibility(
                          visible: !loading,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: MyConstants.sw*.1,height: MyConstants.sh*.1,
                                  child: Image.asset("assets/images/logo_fb.PNG")),
                              SizedBox(width: 15,),
                              SizedBox(width: MyConstants.sw*.1,height: MyConstants.sh*.1,
                                  child: Image.asset("assets/images/logo_google.PNG")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
            ),
          ],
          ),
          Center(
            child: Visibility(
              visible: loading,
              child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
            ),
          )
        ],
      ),
    );
  }

  Future<void> performLogin(BuildContext context) async {
    LoginRequest data=LoginRequest(userEmail: emailCont.text,userPassword: passwordCont.text);
    loading=true; reloadUi();
    var loginResp=await authViewModel.login(data,context);
    loading=false; reloadUi();
    if(loginResp?.statusCode==200.toString()){
      MySharedPreferences().saveUserDetail(loginResp!).whenComplete(() =>
          Navigator.pushNamed(context, MyRoutes.homeRoute)
      );
    }
  }

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }
  void reloadUi(){
    setState(() {
    });
  }
}