import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:clothes_map/components/colors_loader.dart';
import 'package:clothes_map/state_management/account_recovery_notifier.dart';
import 'package:clothes_map/services/account_recovery.dart';

class AccountRecovery extends StatefulWidget {
  final String userType;

  AccountRecovery(this.userType);

  @override
  _AccountRecoveryState createState() => _AccountRecoveryState();
}

class _AccountRecoveryState extends State<AccountRecovery> {
  AccountRecoveryNotifier accountRecoveryNotifier;
  AccountRecoveryAdmin accountRecoveryAdmin;
  String phoneNum;
  String newPassword;

  @override
  void initState() {
    super.initState();
    accountRecoveryAdmin = AccountRecoveryAdmin();
    accountRecoveryNotifier = Provider.of<AccountRecoveryNotifier>(
      context,
      listen: false,
    );
  }

  Future<void> showSmsCodeVerificationDialog() async {
    String smsCode = '';
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'أدخل كود التأكيد المرسل إليك',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        content: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          onChanged: (value) {
            smsCode = value;
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'تأكيد',
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              bool smsConfirmed =
                  accountRecoveryAdmin.confirmSentSmsCode(smsCode);
              if (smsConfirmed) {
                accountRecoveryNotifier.phoneNumVerificationCompleted();
                Navigator.of(context).pop();
              } else {
                Fluttertoast.showToast(msg: 'كود خاطي، أعد المحاولة');
              }
            },
          ),
        ],
      ),
    );
  }

  void showAlertDialog(
    DialogType type,
    String title,
    String description,
    Function onOk,
  ) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      animType: AnimType.TOPSLIDE,
      title: title,
      desc: description,
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      btnOkOnPress: onOk,
      btnOkText: 'حسنَا',
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Consumer<AccountRecoveryNotifier>(
            builder: (context, provider, child) => ModalProgressHUD(
              inAsyncCall: provider.loading,
              progressIndicator: ColorsLoader(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      enabled: !provider.phoneNumVerified,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'أدخل رقم هاتفك المسجل على حسابك',
                      ),
                      onChanged: (value) {
                        phoneNum = value;
                      },
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'التحقق من الرقم',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: provider.phoneNumVerified
                        ? null
                        : () async {
                            provider.changeLoadingState(true);
                            PhoneNumVerification status =
                                await accountRecoveryAdmin
                                    .verifyUserPhoneNumber(phoneNum);
                            switch (status) {
                              case PhoneNumVerification.failed:
                                showAlertDialog(
                                  DialogType.ERROR,
                                  'حدث خطأ أثناء عملية التحقق',
                                  '',
                                  () {},
                                );
                                break;
                              case PhoneNumVerification.wrongInput:
                                showAlertDialog(
                                  DialogType.WARNING,
                                  'لقد أدخلت رقم هاتف عير صالح',
                                  'رقم الهاتف يجب ان يتكون من 11 رقم ويبدأ ب 01',
                                  () {},
                                );
                                break;
                              case PhoneNumVerification.smsVerificationNeeded:
                                showSmsCodeVerificationDialog();
                                break;
                              case PhoneNumVerification.verified:
                                {
                                  accountRecoveryNotifier
                                      .phoneNumVerificationCompleted();
                                  showAlertDialog(
                                    DialogType.INFO,
                                    'تم التحقق من رقمك',
                                    'الرجاء كتابة كلمة السر الجديدة أدناه',
                                    () {},
                                  );
                                }
                            }
                            provider.changeLoadingState(false);
                          },
                  ),
                  Padding(
                    padding: EdgeInsets.all(3),
                    child: TextField(
                      enabled: provider.phoneNumVerified,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        newPassword = value;
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintText: 'كلمة المرور الجديدة',
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'تغير كلمة المرور',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: provider.phoneNumVerified
                        ? () async {
                            provider.changeLoadingState(true);
                            AccountRecoveryResult dbResponse =
                                await accountRecoveryAdmin.recoverUserAccount(
                              newPassword: newPassword,
                              phoneNum: phoneNum,
                              userType: widget.userType,
                            );
                            switch (dbResponse) {
                              case AccountRecoveryResult.failed:
                                showAlertDialog(
                                  DialogType.ERROR,
                                  'حدث خطأ ما',
                                  '',
                                  () {},
                                );
                                break;
                              case AccountRecoveryResult.wrongInput:
                                showAlertDialog(
                                  DialogType.ERROR,
                                  'كلمة مرور جديدة غير صالحلة',
                                  'يجب ان تحتوي كلمة المرور على 6 احرف او ارقام على الأقل',
                                  () {},
                                );
                                break;
                              case AccountRecoveryResult.recovered:
                                showAlertDialog(
                                  DialogType.SUCCES,
                                  'تم تغير كلمة المرور بنجاح',
                                  '',
                                  () => Navigator.pop(context),
                                );
                            }
                            provider.changeLoadingState(false);
                          }
                        : null,
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
