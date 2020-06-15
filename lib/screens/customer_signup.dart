import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

import 'package:clothes_map/components/form_header.dart';
import 'package:clothes_map/components/form_input.dart';
import 'package:clothes_map/state_management/customers_signup.dart';
import 'package:clothes_map/services/customers_auth.dart';
import 'package:clothes_map/utils/shape_cliper.dart';
import 'package:clothes_map/utils/values.dart';

class CustomerSignup extends StatefulWidget {
  @override
  _CustomerSignupState createState() => _CustomerSignupState();
}

class _CustomerSignupState extends State<CustomerSignup> {
  CustomerAuth customerAuth;
  CustomersSignup customersSignup;

  @override
  void initState() {
    super.initState();
    customerAuth = CustomerAuth();
    customersSignup = CustomersSignup();
  }

  ImageProvider showAvatar() {
    if (CustomersSignup.newUserAvatar == defaultUserAvatarAsset)
      return AssetImage(defaultUserAvatarAsset);
    else
      return FileImage(File(CustomersSignup.newUserAvatar));
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => CustomersSignup(),
        child: Consumer<CustomersSignup>(
          builder: (context, signUpAdmin, child) => Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                margin: EdgeInsets.only(bottom: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          ClipPath(
                            clipper: ShapeClipper(),
                            child: Container(
                              height: deviceHeight / 4.5,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Container(
                            height: deviceHeight / 5.5,
                            margin: EdgeInsets.only(top: deviceHeight * 0.07),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 0.0,
                                  color: Colors.black26,
                                  offset: Offset(1.0, 10.0),
                                  blurRadius: 20.0,
                                ),
                              ],
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) => CircleAvatar(
                                backgroundImage: showAvatar(),
                                radius: min(
                                  constraints.maxHeight / 2,
                                  constraints.maxWidth / 2,
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                          Positioned(
                            top: deviceHeight / 5,
                            left: deviceWidth / 1.85,
                            child: Container(
                              alignment: Alignment.center,
                              height: deviceHeight / 23,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange[100],
                              ),
                              child: GestureDetector(
                                onTap: signUpAdmin.letUserChooseHisAvatar,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.blueGrey,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FormHeader(title: 'الإسم بالكامل'),
                          FormInput(
                            iconData: Icons.person_outline,
                            validator: signUpAdmin.fullNameValid,
                            onChanged: (value) =>
                                signUpAdmin.validateFullName(),
                            errorMessage: 'الاسم غير صالح',
                            hintText: 'أدخل الاسم الكامل',
                            controller: signUpAdmin.fullNameController,
                          ),
                          FormHeader(title: 'البريد الإلكتروني'),
                          FormInput(
                            iconData: Icons.alternate_email,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'أدخل البريد الإلكتروني',
                            errorMessage: 'بريد غير صالح',
                            validator: signUpAdmin.emailVerified,
                            controller: signUpAdmin.emailController,
                            onChanged: (value) => signUpAdmin.validateEmail(),
                          ),
                          FormHeader(title: 'رقم الهاتف'),
                          FormInput(
                            iconData: Icons.phone,
                            validator: signUpAdmin.phoneNumberVerified,
                            controller: signUpAdmin.phoneNumberController,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) =>
                                signUpAdmin.validatePhoneNumber(),
                            errorMessage: 'رقم هاتف غير صالح',
                            hintText: 'أدخل رقم هاتفك',
                          ),
                          FormHeader(title: 'العنوان'),
                          FormInput(
                            iconData: Icons.location_on,
                            validator: true,
                            controller: signUpAdmin.addressController,
                            hintText: 'أدخل عنوان منزلك',
                            errorMessage: 'عنوان غير صالح',
                          ),
                          FormHeader(title: 'كلمة المرور'),
                          FormInput(
                            iconData: Icons.lock_outline,
                            secretInfo: true,
                            validator: signUpAdmin.passwordVerified,
                            controller: signUpAdmin.passwordController,
                            onChanged: (value) {
                              signUpAdmin.validatePassword();
                              signUpAdmin.checkIfPasswordVerificationMatch();
                            },
                            errorMessage: 'كلمة مرور غير صالحة (6-32)',
                            hintText: 'أدخل كلمة سر',
                          ),
                          FormHeader(title: 'تأكيد كلمة المرور'),
                          FormInput(
                            iconData: Icons.security,
                            controller:
                                signUpAdmin.passwordVerificationController,
                            validator: signUpAdmin.passwordVerificationMatches,
                            secretInfo: true,
                            onChanged: (value) {
                              signUpAdmin.validatePassword();
                              signUpAdmin.checkIfPasswordVerificationMatch();
                            },
                            hintText: 'أعد إدخال كلمة السر',
                            errorMessage: 'كلمة السر غير متطابقة',
                          ),
                        ],
                      ),
                      ProgressButton(
                          width: deviceWidth / 2,
                          borderRadius: 30,
                          color: Colors.blue,
                          defaultWidget: Text(
                            'إنشاء حساب',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          progressWidget: SpinKitPulse(color: Colors.white),
                          onPressed: () async {
                            if (signUpAdmin.fullNameValid == true &&
                                signUpAdmin.emailVerified == true &&
                                signUpAdmin.phoneNumberVerified == true &&
                                signUpAdmin.passwordVerified == true &&
                                signUpAdmin.passwordVerificationMatches ==
                                    true) {
                              EmailCreation dbResponse =
                                  await customerAuth.createNewUser(
                                signUpAdmin.fullNameController.text.trim(),
                                signUpAdmin.emailController.text,
                                signUpAdmin.phoneNumberController.text,
                                signUpAdmin.addressController.text,
                                signUpAdmin.passwordController.text,
                                CustomersSignup.newUserAvatar ==
                                        defaultUserAvatarAsset
                                    ? ''
                                    : CustomersSignup.newUserAvatar
                                        .split('.')
                                        .last,
                              );
                              switch (dbResponse) {
                                case EmailCreation.succeeded:
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(
                                    msg: 'تم إنشاء الحساب بنجاح',
                                  );
                                  break;
                                case EmailCreation.alreadyExists:
                                  Fluttertoast.showToast(
                                    msg: 'هذا الحساب مسجل بالفعل',
                                  );
                                  break;
                                case EmailCreation.failed:
                                  Fluttertoast.showToast(
                                    msg: 'حدث خطأ ما يرجى المحاولة مجددا',
                                  );
                              }
                            } else
                              Fluttertoast.showToast(
                                  msg: 'قد أدخلت بيانات خاطئة');
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                "لديك حساب بالفعل؟",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    customersSignup.clearInputs();
  }
}
