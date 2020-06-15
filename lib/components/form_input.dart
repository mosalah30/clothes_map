import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final bool validator;
  final Function onChanged;
  final TextInputType keyboardType;
  final String errorMessage;
  final String hintText;
  final IconData iconData;
  final TextEditingController controller;
  final bool secretInfo;

  FormInput({
    this.validator,
    this.onChanged,
    this.iconData,
    this.keyboardType = TextInputType.text,
    this.errorMessage,
    this.hintText,
    this.controller,
    this.secretInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: validator != false ? Colors.grey.withOpacity(0.5) : Colors.red,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Icon(
              iconData,
              color: Colors.grey,
            ),
          ),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey.withOpacity(0.5),
            margin: EdgeInsets.only(left: 10),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: TextField(
                autocorrect: true,
                keyboardType: keyboardType,
                obscureText: secretInfo,
                onChanged: onChanged,
                controller: controller,
                decoration: InputDecoration(
                  suffixText: validator != false ? null : errorMessage,
                  suffixStyle: TextStyle(fontSize: 16),
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
