import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

import 'package:clothes_map/state_management/user_info.dart';
import 'package:clothes_map/services/customer_account.dart';

class CustomerProfile extends StatefulWidget {
  final inputDecoration = InputDecoration(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.5),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
  );

  final titlesStyle = TextStyle(fontSize: 20);
  final inputStyle = TextStyle(fontSize: 17);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  final customerAccountAdmin = CustomerAccountAdmin();
  final firstFieldFocus = FocusNode();
  bool isEditable = false;

  String requestedNewName = UserInfo.info['name'];
  String requestedNewAddress = UserInfo.info['address'];
  String requestedNewPhoneNum = UserInfo.info['phoneNumber'];
  String requestedNewPassword = UserInfo.info['password'];

  Future<void> showAlertDialog(
    DialogType type,
    String title,
    String description,
    Function onOk,
  ) async {
    await AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.TOPSLIDE,
      title: title,
      desc: description,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      btnOkOnPress: onOk,
      btnOkText: "حسناَ",
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'معلوماتك الشخصية',
                        style:
                            TextStyle(fontSize: 24, color: Color(0xff000070)),
                      ),
                      FlatButton(
                        color: Colors.blue,
                        child: Text(
                          'تعديل',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            isEditable = true;
                          });
                          Future.delayed(Duration(milliseconds: 100), () {
                            firstFieldFocus.requestFocus();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: deviceHeight * 0.05),
                  Text(
                    'الإسم الكامل',
                    style: widget.titlesStyle,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      requestedNewName = value;
                    },
                    focusNode: firstFieldFocus,
                    enabled: isEditable,
                    initialValue: UserInfo.info['name'],
                    decoration: widget.inputDecoration,
                    style: widget.inputStyle,
                  ),
                  SizedBox(height: deviceHeight * 0.05),
                  Text(
                    'البريد الإلكتروني',
                    style: widget.titlesStyle,
                  ),
                  TextFormField(
                    decoration: widget.inputDecoration,
                    initialValue: UserInfo.info['email'],
                    style: widget.inputStyle,
                    enabled: false,
                  ),
                  SizedBox(height: deviceHeight * 0.05),
                  Text(
                    'العنوان',
                    style: widget.titlesStyle,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      requestedNewAddress = value;
                    },
                    enabled: isEditable,
                    style: widget.inputStyle,
                    initialValue: UserInfo.info['address'],
                    decoration: widget.inputDecoration,
                  ),
                  SizedBox(height: deviceHeight * 0.05),
                  Text(
                    'رقم الهاتف',
                    style: widget.titlesStyle,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      requestedNewPhoneNum = value;
                    },
                    enabled: isEditable,
                    style: widget.inputStyle,
                    keyboardType: TextInputType.phone,
                    initialValue: UserInfo.info['phoneNumber'],
                    decoration: widget.inputDecoration,
                  ),
                  SizedBox(height: deviceHeight * 0.05),
                  Text(
                    'كلمة المرور',
                    style: widget.titlesStyle,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      requestedNewPassword = value;
                    },
                    enabled: isEditable,
                    style: widget.inputStyle,
                    obscureText: true,
                    initialValue: UserInfo.info['password'],
                    decoration: widget.inputDecoration,
                  ),
                  SizedBox(height: deviceHeight * 0.05),
                  Container(
                    width: double.maxFinite,
                    height: 50,
                    child: ProgressButton(
                      progressWidget: SpinKitPulse(color: Colors.white),
                      animate: false,
                      color: Colors.blue,
                      borderRadius: 30,
                      defaultWidget: Text(
                        'حفظ',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      onPressed: isEditable
                          ? () async {
                              final dbResponse =
                                  await customerAccountAdmin.updateCustomerInfo(
                                UserInfo.info['email'],
                                requestedNewName.trim(),
                                requestedNewAddress.trim(),
                                requestedNewPhoneNum.trim(),
                                requestedNewPassword.trim(),
                              );
                              switch (dbResponse) {
                                case UpdateResponse.failed:
                                  showAlertDialog(
                                    DialogType.ERROR,
                                    '!خطأ',
                                    'فشل تحديث البيانات',
                                    () {},
                                  );
                                  break;
                                case UpdateResponse.validationError:
                                  showAlertDialog(
                                    DialogType.WARNING,
                                    '!تحذير',
                                    'تم إدخال بيانات خاطئة',
                                    () {},
                                  );
                                  break;
                                case UpdateResponse.noChangeWasGiven:
                                  showAlertDialog(
                                    DialogType.INFO,
                                    '!تم تجاهل الأمر',
                                    'لم تقم بأي تعديل',
                                    () {},
                                  );
                                  break;
                                case UpdateResponse.succeeded:
                                  Provider.of<UserInfo>(
                                    context,
                                    listen: false,
                                  ).getInfo();
                                  showAlertDialog(
                                    DialogType.SUCCES,
                                    '!تم',
                                    'تم تحديث بياناتك بنجاح',
                                    () => Navigator.pop(context),
                                  );
                              }
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
