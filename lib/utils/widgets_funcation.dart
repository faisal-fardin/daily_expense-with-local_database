import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );

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
            title: Text(title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            content: Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                controller: controller,
                keyboardType: inputType,
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(negativeBtnText,
                    style: const TextStyle(
                        color: Colors.indigo,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple
                ),
                onPressed: () {
                  if (controller.text.isEmpty) {
                    return;
                  }
                  Navigator.pop(context);
                  onSave(controller.text);
                },
                child: Text(
                  positiveBtnText,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ));
}
