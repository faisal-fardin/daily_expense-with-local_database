import 'package:flutter/material.dart';

showSingleTextFieldDialog({
  required BuildContext context,
  required String title,
  required String hint,
  TextInputType inputType = TextInputType.name,
  String positiveBtnText = 'SAVE',
  String negativeBtnText = 'CANCEL',
  required Function(String) onSave,
}) {
  final controller = TextEditingController();
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: controller,
                keyboardType: inputType,
                decoration: InputDecoration(hintText: hint),
              ),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text(negativeBtnText),
              ),
              ElevatedButton(
                onPressed: (){
                  if(controller.text.isEmpty){
                    return;
                  }
                  Navigator.pop(context);
                  onSave(controller.text);
                },
                child: Text(positiveBtnText),
              ),
            ],
          ));
}
