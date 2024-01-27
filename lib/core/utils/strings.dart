import 'package:flutter/widgets.dart';

const String splash = '/splash.dart';
const String signUp = '/sign_up.dart';
const String signIn = '/sign_in.dart';
// const String otp = '/otp.dart';
const String advertise = '/advertise.dart';
const String countries = '/countries_and_cities.dart';
const String home = '/home.dart';
const String editProfile = '/profile_edit.dart';
const String section = '/section.dart';
double mediaHiegh(BuildContext context) {
  double resHeight = MediaQuery.sizeOf(context).height;
  return resHeight;
}

double mediawidth(BuildContext context) {
  double reswidth = MediaQuery.sizeOf(context).width;
  return reswidth;
}

//^ Apis
String registerLink = "https://buyandsell2024.com/api/register"; //&done
String loginLink = "https://buyandsell2024.com/api/login"; //&done
String governmentLink = "https://buyandsell2024.com/api/governorate"; //&done
String categoriesLink = "https://buyandsell2024.com/api/category"; //&done
String myadvertiseLink =
    "https://buyandsell2024.com/api/my_advertisement"; //&done
String updateProfileLink = "https://buyandsell2024.com/profile";
String createCommentLink = "https://buyandsell2024.com/api/comment";//&done
