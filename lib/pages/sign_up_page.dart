import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickensol/controller/sign_up_controller.dart';
import 'package:quickensol/pages/home_page.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/app_colors.dart';
import '../utils/textstyle.dart';

import '../widgets/common textfield.dart';
import '../widgets/common_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpController signUpController = Get.put(SignUpController());
  final RegExp usernameRegex = RegExp(r'^[a-zA-Z]+$');
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
            padding: EdgeInsets.symmetric(vertical: 4.80.h, horizontal: 6.w),
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
                            "Sign Up",
                            style: TextHelper.size20.copyWith(fontSize: 30, fontWeight: FontWeight.w600, color: ColorsForApp.headingPageColor),
                          )
                        ],
                      ),
                      SizedBox(height: 5.h),
                      const Row(
                        children: [
                          Text("Name", style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: CustomTextField(
                          prefixIcon: Icon(Icons.person),
                          controller: signUpController.nameController,
                          hintText: "Type Your Name",
                          hintTextColor: Colors.black.withOpacity(0.9),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Name";
                            } else if (!usernameRegex.hasMatch(value)) {
                              return "Username can only contain letters";
                            }
                            return null;
                          },
                          inputFormatters: [],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      const Row(
                        children: [
                          Text("Email", style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: CustomTextField(
                          prefixIcon: Icon(Icons.person),
                          controller: signUpController.emailController,
                          hintText: "Type Your Email",
                          hintTextColor: Colors.black.withOpacity(0.9),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Email";
                            }
                            return null;
                          },
                          inputFormatters: [],
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: CustomTextField(
                          controller: signUpController.passwordController,
                          prefixIcon: Icon(Icons.lock_outline_sharp),
                          obscureText: passwordObsecured,
                          hintText: "Type Your Password",
                          hintTextColor: Colors.black.withOpacity(0.9),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                passwordObsecured = !passwordObsecured;
                              });
                            },
                            child: passwordObsecured ? Icon(Icons.visibility_off, color: Colors.black,) : Icon(Icons.remove_red_eye, color: Colors.black,),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Password";
                            } else if (!passwordRegex.hasMatch(value)) {
                              return "Password must be at least 8 characters long";
                            }
                            return null;
                          },
                          inputFormatters: [],
                        ),
                      ),
                      SizedBox(height: 1.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.sp),
            child: CommonButton(
              buttonText: "Sign UP",
              onpressed: () {
                if (loginKey.currentState!.validate()) {
                  signUpController.signUp();
                }
              },
            ),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already Have an Account? ",
                style: TextHelper.size20.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.black),
              ),
              SizedBox(width: 2.sp,),
              Text(
                "Sign in",
                style: TextHelper.size20.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600, color: ColorsForApp.headingPageColor),
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
