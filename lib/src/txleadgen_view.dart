import 'package:flutter/material.dart';
import 'package:teamxleadgen/src/components/button.dart';
import 'package:teamxleadgen/src/components/text_field_container.dart';
import 'package:teamxleadgen/src/utility/utility.dart';

class TXLeadgenView extends StatefulWidget {
  final Function callBack;
  const TXLeadgenView({Key? key, required this.callBack}) : super(key: key);

  @override
  _TXLeadgenViewState createState() => _TXLeadgenViewState();
}

class _TXLeadgenViewState extends State<TXLeadgenView> {
  BoxDecoration decoration() {
    //Setting cornerRadius
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)));
  }

  TextFieldFocus? currentFocus;
  double? stepUpPercentage;
  TextEditingController? controller;
  String? errorText;
  String? name;
  String? email;
  String? phoneNumber;

  bool invalidName = false;
  bool invalidEmail = false;
  bool invalidPhoneNumber = false;
  bool isTermsAccepted = false;
  bool isAllValid = false;
  isAllInputValid() {
    bool isValid = true;
    // if (errorText != null) {
    //   isValid = false;
    // }
    if (name == null || invalidName) {
      isValid = false;
    }
    if (email == null || invalidEmail) {
      isValid = false;
    }
    if (phoneNumber == null || invalidPhoneNumber) {
      isValid = false;
    }

    if (isTermsAccepted == false) {
      isValid = false;
    }
    setState(() {
      isAllValid = isValid;
    });
    return isValid;
  }

  void _submitButtonTapped() {
    {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
      Navigator.of(context).pop();
    }
  }

  _onTextChange(TextFieldFocus? textField, String value) {
    if (textField == TextFieldFocus.name) {
      setState(() {
        if (value.isNotEmpty) {
          setState(() {
            name = value;
            //print(name);
            invalidName = false;
          });
        } else {
          setState(() {
            name = null;
            invalidName = true;
          });
        }
      });
    }

    if (textField == TextFieldFocus.email) {
      setState(() {
        if (value.isNotEmpty) {
          setState(() {
            email = value;
            //print(email);
            invalidEmail = false;
          });
        } else {
          setState(() {
            email = null;
            invalidEmail = true;
          });
        }
      });
    }

    if (textField == TextFieldFocus.mobileNumber) {
      setState(() {
        if (value.isNotEmpty) {
          setState(() {
            phoneNumber = value;
            invalidPhoneNumber = false;
          });
        } else {
          setState(() {
            phoneNumber = null;
            invalidPhoneNumber = true;
          });
        }
      });
    }
    isAllInputValid();
  }

  _onFocusChange(TextFieldFocus? textField, bool value) {
    if (value == true) {
      setState(() {
        currentFocus = textField;
      });
    } else {
      if (textField == TextFieldFocus.name) {
        validateName();
      } else if (textField == TextFieldFocus.email) {
        validateEmail();
      } else if (textField == TextFieldFocus.mobileNumber) {
        validatePhoneNumber();
      }
    }

    // isAllInputValid();
  }

  validateName() {
    if (name == null) {
      setState(() {
        invalidName = true;
      });
    }
  }

  validateEmail() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email ?? "");
    setState(() {
      invalidEmail = !emailValid;
    });
  }

  validatePhoneNumber() {
    if (phoneNumber == null) {
      setState(() {
        invalidPhoneNumber = true;
      });
    }
  }

  void removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (this.currentFocus != null) {
      setState(() {
        this.currentFocus = null;
      });
    }
  }

  _onDoneButtonTapped() {
    setState(() {
      removeFocus();
    });
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return const Color(0xfffe9c26);
  }

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black.withOpacity(0.5),
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          // ),
          body: GestureDetector(
            onTap: () {
              removeFocus();
            },
            child: Center(
              child: Container(
                decoration: decoration(),
                margin: const EdgeInsets.fromLTRB(16, 20, 16, 44),
                height: 500,
                child:
                    SingleChildScrollView(child: buildInputContainer(context)),
              ),
            ),
          ),
        ));
  }

  Widget buildInputContainer(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
        width: deviceWidth,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.fromLTRB(8, 10, 8, 0),
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Expanded(child: Text(" ")),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Transform.scale(
                      scale: 1.5,
                      child: IconButton(
                        icon: const Icon(Icons.close_outlined,
                            color: Colors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  )
                ],
              ),
              buildTextFieldContainerSection(
                  textField: TextFieldFocus.name,
                  textFieldType: TextFieldType.string,
                  placeHolder: "John Write",
                  textLimit: 30,
                  containerTitle: "Full Name",
                  focus: currentFocus,
                  onFocusChange: _onFocusChange,
                  onTextChange: _onTextChange,
                  onDoneButtonTapped: _onDoneButtonTapped,
                  isError: invalidName),
              // SizedBox(height: 20),

              // invalidPeriod == true
              //     ? buildErrorView(ErrorType.maxPeriodYears)
              //     : Container(),
              const SizedBox(height: 15),
              buildTextFieldContainerSection(
                textField: TextFieldFocus.email,
                textFieldType: TextFieldType.email,
                placeHolder: "john.write@gmail.com",
                textLimit: 30,
                containerTitle: "Email",
                focus: currentFocus,
                onFocusChange: _onFocusChange,
                onTextChange: _onTextChange,
                onDoneButtonTapped: _onDoneButtonTapped,
                isError: invalidEmail,
              ),
              const SizedBox(height: 15),
              buildTextFieldContainerSection(
                textField: TextFieldFocus.mobileNumber,
                textFieldType: TextFieldType.number,
                placeHolder: "90295399",
                textLimit: 10,
                containerTitle: 'Phone Number',
                focus: currentFocus,
                onFocusChange: _onFocusChange,
                onTextChange: _onTextChange,
                onDoneButtonTapped: _onDoneButtonTapped,
                isError: invalidPhoneNumber,
              ),
              // invalidStepup == true
              //     ? buildErrorView(ErrorType.maxStepUpRate)
              //     : Container(),

              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  checkboxContainer(),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Text(
                      "You consent to \"US\" sharing your personal details including name, email, contact number to Chubb for the purpose of policy issuance & servicing",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(children: [
                Expanded(
                    child: genericButton(
                        title: 'Submit'.toUpperCase(),
                        onPress: isAllValid ? _submitButtonTapped : null)),
              ])
            ]));
  }

  Widget checkboxContainer() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTermsAccepted = !isTermsAccepted;
          isAllInputValid();
        });
      },
      child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
              color: Color(0xFFF1F3F6),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: isTermsAccepted
              ? const Center(
                  child: Icon(
                    Icons.done,
                    color: Color(0xFFFFAC30),
                    size: 40,
                  ),
                )
              : null),
    );
  }
}
