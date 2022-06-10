import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Container genericButton({required String title, required Function? onPress}) {
  return Container(
    height: 55,
    child: CupertinoButton(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: const Color(0xfffe9c26),
        disabledColor: Colors.grey,
        onPressed: onPress != null
            ? () {
                onPress();
              }
            : null),
  );
}
