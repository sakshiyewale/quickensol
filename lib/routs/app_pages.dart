

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quickensol/Routs/routs.dart';
import 'package:quickensol/pages/home_page.dart';
import 'package:quickensol/pages/sign_in_page.dart';
import 'package:quickensol/pages/sign_up_page.dart';
import 'package:quickensol/pages/splash_screen.dart';
import '../binding/app_binding.dart';

class AppPages
{
   static String INITIAL_ROUTS = Routs.SPLASHSCREEN_ROUTS;
   static final pages =
   [
   GetPage(
       name: Routs.SIGN_IN_ROUTS,
       page:()=>SignInPage(),
       binding: SignInBinding()
   ),
      GetPage(
          name: Routs.SIGN_UP_ROUTS,
          page:()=>SignUpPage(),
          binding: SignUpBinding()
      ),
      GetPage(
          name: Routs.HOMEPAGE_ROUTS,
          page:()=>HomePage(),
          binding: HomePageBinding()
      ),
      GetPage(
          name:Routs.SPLASHSCREEN_ROUTS,
          page: ()=>SplashScreen(),
          binding: SplashScreenBinding()
      )

   ];
}