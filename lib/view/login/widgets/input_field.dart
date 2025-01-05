import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/const.dart';

class InputField extends StatelessWidget {
  String? title;
  String? hint;
  bool isEmail;
  TextEditingController controller = TextEditingController();

  InputField({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          kheight10,
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
                hintText: '$hint',
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'this field is requiered';
              }
              if (isEmail) {
                if (!value.isEmail) {
                  return 'please enter valid email';
                }
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }
}
