import 'package:get/get.dart';
import 'package:quickensol/controller/home_page_controller.dart';
import 'package:quickensol/controller/sign_in_controller.dart';
import 'package:quickensol/controller/sign_up_controller.dart';
import 'package:quickensol/controller/splash_screen_controller.dart';

class SignInBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}


class SignUpBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}


class HomePageBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
  }
}

class SplashScreenBinding extends Bindings
{
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }

}