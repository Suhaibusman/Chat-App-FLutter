// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';

// class CustomDialogBox extends StatefulWidget {
//   const CustomDialogBox({Key? key}) : super(key: key);

//   @override
//   State<CustomDialogBox> createState() => _CustomDialogBoxState();
// }

// class _CustomDialogBoxState extends State<CustomDialogBox> {
//   @override
//   Widget build(BuildContext context) {
//     return AwesomeDialog(
//       context: context,
//       dialogType: DialogType.info,
//       borderSide: const BorderSide(
//         color: Colors.green,
//         width: 2,
//       ),
//       width: 280,
//       buttonsBorderRadius: const BorderRadius.all(
//         Radius.circular(2),
//       ),
//       dismissOnTouchOutside: true,
//       dismissOnBackKeyPress: false,
//       onDismissCallback: (type) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Dismissed by $type'),
//           ),
//         );
//       },
//       headerAnimationLoop: false,
//       animType: AnimType.bottomSlide,
//       title: 'INFO',
//       desc: 'This Dialog can be dismissed touching outside',
//       showCloseIcon: true,
//       btnCancelOnPress: () {},
//       btnOkOnPress: () {},
//     ).show();
//   }
// }
