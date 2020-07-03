import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:clothes_map/screens/wish_list.dart';
import 'package:clothes_map/screens/customer_profile.dart';
import 'package:clothes_map/components/option_card.dart';
import 'package:clothes_map/state_management/user_info.dart';
import 'package:clothes_map/utils/transitions.dart';

class CustomerAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OptionCard(
          title: 'تفضيلاتي',
          leadingIconAsset: 'favorite.png',
          onTap: () {
            Navigator.of(context).push(
              SlideRightTransition(newScreen: WishList()),
            );
          },
        ),
        OptionCard(
          title: 'الملف الشخصي',
          leadingIconAsset: 'profile.png',
          onTap: () {
            Navigator.of(context).push(
              SlideRightTransition(newScreen: CustomerProfile()),
            );
          },
        ),
        OptionCard(
          title: 'تواصل معنا',
          leadingIconAsset: 'contact_us.png',
          onTap: () async {
            String whatsAppUrl = "whatsapp://send?phone=+201000785803";
            await canLaunch(whatsAppUrl)
                ? launch(whatsAppUrl)
                : Fluttertoast.showToast(msg: 'أنت ليس لديك تطبيق الواتساب');
          },
        ),
        FlatButton(
          splashColor: Colors.lightBlueAccent,
          onPressed: () {
            Provider.of<UserInfo>(context, listen: false).deleteUserInfo();
          },
          padding: EdgeInsets.all(0),
          child: ListTile(
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.grey,
              size: 40,
            ),
            title: Text(
              'تسجيل الخروج',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "للتواصل مع المطور",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Cairo",
          ),
          textAlign: TextAlign.center,
        ),
        Container(
          padding: EdgeInsets.only(top: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Image.asset(
                  'assets/icons/facebook.png',
                  width: 40,
                  height: 40,
                ),
                onTap: () async {
                  String facebookPageUrl = '‏‎fb.me/moonlight2172000';
                  String facePageWebUrl =
                      'https://www.facebook.com/moonlight2172000';
                  await canLaunch(facebookPageUrl)
                      ? launch(facebookPageUrl)
                      : launch(facePageWebUrl);
                },
              ),
              SizedBox(width: 20),
              InkWell(
                child: Image.asset(
                  'assets/icons/linkedin.png',
                  width: 40,
                  height: 40,
                ),
                onTap: () => launch(
                    'https://www.linkedin.com/in/ammar-yasser-018673187/'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
