import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salonapp/utils/app_color.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String lableText;
  final TextInputType inputType;
  final bool enabled;
  const CustomField({
    super.key,
    required this.controller,
    required this.lableText,
    this.inputType = TextInputType.text,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: inputType,
        inputFormatters: inputType == TextInputType.number
            ? [
                LengthLimitingTextInputFormatter(
                    10), // Maximum character length
              ]
            : null,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            enabled: enabled,
            // prefixIcon: Icon(Icons.phone),
            label: Text(lableText),
            labelStyle: TextStyle(color: Colors.black),
            disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.6), width: 1.0),
                borderRadius: BorderRadius.circular(8.0)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColor.primaryButton, width: 1.0),
                borderRadius: BorderRadius.circular(8.0)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.6), width: 1.0),
                borderRadius: BorderRadius.circular(8.0)),
            // hintText: lableText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.6), width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            )));
  }
}
