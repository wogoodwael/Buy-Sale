// // ignore_for_file: prefer_const_constructors

// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shopping/core/utils/colors.dart';
// import 'package:shopping/presentation/widgets/errors_snack.dart';

// class ForgetPassword extends StatefulWidget {
//   const ForgetPassword({super.key});

//   @override
//   State<ForgetPassword> createState() => _ForgetPasswordState();
// }

// class _ForgetPasswordState extends State<ForgetPassword> {
//   Errors errors = Errors();
//   final formKey = GlobalKey<FormState>();
//   final emailController = TextEditingController();
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     emailController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           leading: Icon(
//             Icons.arrow_back_ios,
//             color: Constants.darkBrawn,
//           ),
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Text(
//                 "4Buy And Sale",
//                 style: TextStyle(color: Constants.darkBrawn),
//               ),
//             ],
//           ),
//           centerTitle: false,
//         ),
//         body: SingleChildScrollView(
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             SizedBox(
//               height: .03 * mediaHiegh(context),
//             ),

//             Padding(
//               padding: EdgeInsets.only(
//                   left: .08 * mediawidth(context)),
//               child: Text(
//                 " Reset Password",
//                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(
//               height: .02 * mediaHiegh(context),
//             ),
//             Text(
//               """
//           Enter the email adreess you used when you 
//           joined and we will send you instructions to reset
//           your password 
//         """,
//               style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: .05 * mediaHiegh(context),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(
//                   horizontal: .07 * mediawidth(context)),
//               width: .90 * mediawidth(context),
//               height: .07 * mediaHiegh(context),
//               decoration: BoxDecoration(
//                   border: Border.all(
//                       color: const Color.fromARGB(255, 189, 187, 187)),
//                   borderRadius: BorderRadius.circular(10)),
//               child: Center(
//                 child: TextFormField(
//                   controller: emailController,
//                   cursorColor: Colors.white,

//                   decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.email),
//                       border: InputBorder.none,
//                       hintText: 'Enter your email..',
//                       hintStyle: TextStyle(color: Colors.grey, fontSize: 17)),
//                   autovalidateMode: AutovalidateMode.onUserInteraction,

//                   // TextFormField
//                 ),
//               ),
//             ),
//             SizedBox(height: .4 * mediaHiegh(context)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "You remeber your password ? ",
//                   style: TextStyle(
//                       color: Colors.grey, fontWeight: FontWeight.bold),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pushNamed(context, 'Login');
//                   },
//                   child: Text(
//                     "Login",
//                     style: TextStyle(
//                         color: Constants.secondBrawn,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: .04 * mediaHiegh(context)),
//             Center(
//               child: MaterialButton(
//                 color: Constants.darkBrawn,
//                 shape: StadiumBorder(),
//                 minWidth: .9 * mediawidth(context),
//                 height: .06 * mediaHiegh(context),
//                 onPressed: () {
//                   resetPassword();
//                 },
//                 child: Text(
//                   "Request password reset",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             )

//             // ElevatedButton. icon
//           ]),
//         ));
//   }

//   Future resetPassword() async {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (context) => Center(
//               child: CircularProgressIndicator(),
//             ));
//     Navigator.pop(context);
//       try {
//         await FirebaseAuth.instance
//             .sendPasswordResetEmail(email: emailController.text.trim());
//         errors.ErrorSnackBar(context, 'Password reset Email Sent', Colors.green);
//         Navigator.pop(context);
//       } on FirebaseAuthException catch (e) {
//         print(e);
//         errors.ErrorSnackBar(context, e.message.toString(), Colors.red);
//       }
//     }
//   }

