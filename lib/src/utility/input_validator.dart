import 'package:flutter/services.dart';

String regexSource = r'^[0-9]+$';
String emailRegex =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

class TXLInputFormatterValidator implements TextInputFormatter {
  final TXLAmountValidator validator;
  TXLInputFormatterValidator({required this.validator});
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var isOldValueValid = validator.isValid(oldValue.text);
    var isNewValueValid = validator.isValid(newValue.text);

    if (isOldValueValid && !isNewValueValid) {
      return oldValue;
    }
    return newValue;
  }
}

abstract class TXLAmountValidator {
  bool isValid(String value);
}

class TXLAmountRegexValidator extends TXLAmountValidator {
  final String source;
  TXLAmountRegexValidator({required this.source});
  bool isValid(String value) {
    try {
      var regex = RegExp(source);
      var matches = regex.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
    } catch (error) {}

    return false;
  }
}

class TXLEmailRegexValidator extends TXLAmountValidator {
  final String source;
  TXLEmailRegexValidator({required this.source});
  @override
  bool isValid(String value) {
    try {
      var regex = RegExp(source);
      var matches = regex.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
    } catch (error) {}

    return false;
  }
}
