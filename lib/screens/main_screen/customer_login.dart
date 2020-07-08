import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

import 'package:clothes_map/screens/customer_signup.dart';
import 'package:clothes_map/components/colors_loader.dart';
import 'package:clothes_map/components/form_header.dart';
import 'package:clothes_map/components/form_input.dart';
import 'package:clothes_map/screens/account_recovery.dart';
import 'package:clothes_map/state_management/screens_controller.dart';
import 'package:clothes_map/state_management/customer_login.dart';
import 'package:clothes_map/state_management/user_info.dart';
import 'package:clothes_map/services/customers_auth.dart';
import 'package:clothes_map/utils/shape_cliper.dart';
import 'package:clothes_map/utils/transitions.dart';

class CustomerLogin extends StatefulWidget {
  @override
  _CustomerLoginState createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  CustomerAuth customerAuth;
  CustomersLogin customersLogin;

  @override
  void initState() {
    super.initState();
    customerAuth = CustomerAuth();
    customersLogin = CustomersLogin();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomersLogin(),
      child: Consumer<CustomersLogin>(
        builder: (context, loginAdmin, child) => ModalProgressHUD(
          progressIndicator: ColorsLoader(),
          inAsyncCall: loginAdmin.socialAuthLoading,
          child: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Selector<ScreensController, int>(
                selector: (context, screensController) =>
                    screensController.screenIndex,
                builder: (context, screenIndexState, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipPath(
                      clipper: ShapeClipper(),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20),
                        height: MediaQuery.of(context).size.height * 0.25,
                        color: Theme.of(context).primaryColor,
                        child: Image.asset(
                          "assets/splash_logo.png",
                          height: MediaQuery.of(context).size.height * 0.13,
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                    FormHeader(title: 'البريد الإلكتروني'),
                    FormInput(
                      iconData: Icons.alternate_email,
                      validator: loginAdmin.emailVerified,
                      controller: loginAdmin.emailController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => loginAdmin.validateEmail(),
                      errorMessage: 'بريد غير صالح',
                      hintText: 'أدخل البريد الإلكتروني',
                    ),
                    FormHeader(title: 'كلمة المرور'),
                    FormInput(
                      iconData: Icons.lock_outline,
                      secretInfo: true,
                      validator: loginAdmin.passwordVerified,
                      controller: loginAdmin.passwordController,
                      onChanged: (value) => loginAdmin.validatePassword(),
                      errorMessage: 'كلمة مرور غير صالحة (6-32)',
                      hintText: 'أدخل كلمة المرور',
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ProgressButton(
                              borderRadius: 30,
                              defaultWidget: Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              progressWidget: SpinKitPulse(color: Colors.white),
                              animate: false,
                              color: Colors.blue,
                              onPressed: () async {
                                EPLogin dbResponse = await customerAuth
                                    .loginWithEmailAndPassword(
                                  loginAdmin.emailController.text,
                                  loginAdmin.passwordController.text,
                                );
                                switch (dbResponse) {
                                  case EPLogin.signedInWithGoogle:
                                    Fluttertoast.showToast(
                                      msg: "هذا الحساب مسجل بجوجل",
                                    );
                                    break;
                                  case EPLogin.signedInWithFacebook:
                                    Fluttertoast.showToast(
                                      msg: "هذا الحساب مسجل بالفيس بوك",
                                    );
                                    break;
                                  case EPLogin.wrongPassword:
                                    Fluttertoast.showToast(
                                      msg: 'كلمة مرور خاطئة',
                                    );
                                    break;
                                  case EPLogin.emailNotFound:
                                    Fluttertoast.showToast(
                                      msg: 'هذا الحساب غير مسجل',
                                    );
                                    break;
                                  case EPLogin.failed:
                                    Fluttertoast.showToast(
                                      msg: 'فشل التحقق من الحساب',
                                    );
                                    break;
                                  case EPLogin.succeeded:
                                    await Provider.of<UserInfo>(
                                      context,
                                      listen: false,
                                    ).getInfo();
                                    loginAdmin.clearInputs();
                                }
                              },
                            ),
                          ),
                          IconButton(
                            tooltip: 'نسيت كلمة المرور؟',
                            icon:
                                Image.asset('assets/icons/forgot_password.png'),
                            onPressed: () => Navigator.of(context).push(
                              ScaleTransitionEffect(
                                newScreen: AccountRecovery('customers'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: Text(
                        'أو',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              iconSize: 40,
                              onPressed: () async {
                                loginAdmin.changeSocialAuthLoadingState(true);
                                SLogin dbResponse =
                                    await customerAuth.googleSignIn();
                                switch (dbResponse) {
                                  case SLogin.failed:
                                    Fluttertoast.showToast(
                                        msg: 'فشل التحقق من حسابك');
                                    break;
                                  case SLogin.hasDifferentCredentials:
                                    Fluttertoast.showToast(
                                        msg: 'هذا الحساب مسجل بطريقة أخرى');
                                    break;
                                  case SLogin.succeeded:
                                    await Provider.of<UserInfo>(
                                      context,
                                      listen: false,
                                    ).getInfo();
                                    loginAdmin.clearInputs();
                                }
                                loginAdmin.changeSocialAuthLoadingState(false);
                              },
                              icon: Image.asset('assets/icons/google.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 7),
                          child: Material(
                            color: Colors.transparent,
                            child: IconButton(
                              iconSize: 40,
                              onPressed: () async {
                                loginAdmin.changeSocialAuthLoadingState(true);
                                SLogin dbResponse =
                                    await customerAuth.facebookSignIn();
                                switch (dbResponse) {
                                  case SLogin.failed:
                                    Fluttertoast.showToast(
                                      msg: 'فشل التحقق من حسابك',
                                    );
                                    break;
                                  case SLogin.hasDifferentCredentials:
                                    Fluttertoast.showToast(
                                      msg: 'هذا الحساب مسجل بطريقة أخرى',
                                    );
                                    break;
                                  case SLogin.succeeded:
                                    await Provider.of<UserInfo>(
                                      context,
                                      listen: false,
                                    ).getInfo();
                                    loginAdmin.clearInputs();
                                }
                                loginAdmin.changeSocialAuthLoadingState(false);
                              },
                              icon: Image.asset('assets/icons/facebook.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          shape: StadiumBorder(),
                          child: Text(
                            "ليس لديك حساب؟",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal,
                            ),
                          ),
                          onPressed: () {
                            loginAdmin.clearInputs();
                            Navigator.push(
                              context,
                              SlideRightTransition(newScreen: CustomerSignup()),
                            );
                          },
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
    );
  }

  @override
  void dispose() {
    super.dispose();
    customersLogin.clearInputs();
  }
}
