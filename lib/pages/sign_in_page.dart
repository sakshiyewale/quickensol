import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quickensol/controller/sign_in_controller.dart';
import 'package:quickensol/pages/home_page.dart';
import 'package:quickensol/pages/sign_up_page.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';
import '../utils/textstyle.dart';
import '../widgets/common textfield.dart';
import '../widgets/common_button.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInController signInController = Get.put(SignInController());

  final RegExp passwordRegex = RegExp(r'^(?=.*[0-9])(?=.*[!@#$%^&*])(?=.*[A-Z]).{8,}$');

  bool passwordObsecured = true;
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(height: 8.80.h,),
          Padding(
            padding: EdgeInsets.symmetric(vertical:4.80.h, horizontal: 6.w),
            child: Column(
              children: [
                Form(
                  key: loginKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign In",
                            style: TextHelper.size20.copyWith(fontSize: 30, fontWeight: FontWeight.w600, color: ColorsForApp.headingPageColor),
                          )
                        ],
                      ),
                      SizedBox(height: 10.h),
                      const Row(
                        children: [
                          Text("Email",
                              style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: CustomTextField(
                          prefixIcon: Icon(Icons.person),
                          controller: signInController.emailController,
                          // onChange: (val){
                          //   BlocProvider.of<LoginBloc>(context).add(LoginValidationEvent(usernameController.text,passwordController.text));
                          // },
                          hintText: "Type Your email",
                          // hintTextColor: Colors.red,
                          hintTextColor: Colors.black.withOpacity(0.9),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter email";
                            }

                            return null;
                          },
                          inputFormatters: [],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: CustomTextField(
                          controller: signInController.passwordController,
                          prefixIcon: Icon(Icons.lock_outline_sharp),
                          obscureText: passwordObsecured,
                          hintText: "Type Your Password",
                          //  hintTextColor: Colors.red,
                          hintTextColor: Colors.black.withOpacity(0.9),
                          // onChange: (val){
                          //   BlocProvider.of<LoginBloc>(context).add(LoginValidationEvent(usernameController.text,passwordController.text));
                          // },
                          suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  passwordObsecured =! passwordObsecured;
                                });
                              },
                              child: passwordObsecured ?Icon(Icons.visibility_off,color: Colors.black,):Icon(Icons.remove_red_eye,color: Colors.black,)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Password";
                            }
                            else if (!passwordRegex.hasMatch(value)) {
                              return "Password must be at least 8 characters long";
                            }

                            return null;
                          },
                          inputFormatters: [],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Text(
                              "Forgot password ?",
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, "forget_screen");
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.sp),
            child: CommonButton(
              buttonText: "Log In",
              onpressed: () {
                signInController.SignIn(context);
                if (loginKey.currentState!.validate()) {

                }
              },
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't Have an account? ? ",
                style: TextHelper.size20.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp, color: Colors.black),
              ),
              SizedBox(width: 2.sp,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpPage()));
                },
                child: Text(
                  "SignUp",
                  style: TextHelper.size20.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w500, color: ColorsForApp.headingPageColor),
                ),
              )
            ],
          ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/AppLogo.png", height: 35.95.h, width: 100.w, fit: BoxFit.fill),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
