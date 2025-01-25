import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
   CustomDialog({super.key,required this.text});
   final String text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(text),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child:const Text("Close") )
      ],
    );
  }
}
