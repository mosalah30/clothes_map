import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:clothes_map/screens/main_screen/customer_login.dart';
import 'package:clothes_map/screens/main_screen/shopping_map.dart';
import 'package:clothes_map/screens/main_screen/offers.dart';
import 'package:clothes_map/screens/customer_account.dart';
import 'package:clothes_map/screens/main_screen/home.dart';
import 'package:clothes_map/screens/main_screen/sections.dart';
import 'package:clothes_map/state_management/screens_controller.dart';
import 'package:clothes_map/state_management/user_info.dart';
import 'package:clothes_map/services/location.dart';
import 'package:clothes_map/utils/screen_util.dart';
import 'package:clothes_map/utils/values.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  ScreenUtil screenUtil;

  // ignore: missing_return
  Widget buildAppBar(int screenIndex) {
    final deviceHeight = MediaQuery.of(context).size.height;
    if (screenIndex == 0) {
      return AppBar(
        leading: Container(),
        centerTitle: true,
        title: Hero(
          child: Image.asset(
            'assets/splash_logo.png',
            height: deviceHeight * 0.065,
          ),
          tag: 'splash_logo',
        ),
      );
    } else if (screenIndex == 2) {
      return PreferredSize(
        preferredSize: Size(double.maxFinite, deviceHeight * 0.1),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: TabBar(
              labelPadding: EdgeInsets.symmetric(vertical: 20),
              tabs: <Widget>[
                Text('الرجال'),
                Text('النساء'),
                Text('الأطفال'),
              ],
              onTap: (int i) {
                Provider.of<ScreensController>(
                  context,
                  listen: false,
                ).changeSectionIndex(i);
              },
            ),
          ),
        ),
      );
    } else if (screenIndex == 4 && UserInfo.info['type'] == 'customer') {
      final avatarUrl =
          "$customersAvatarsStorage${UserInfo.info['email']}.${UserInfo.info['avatarExtension']}";
      return PreferredSize(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'أهلا ${UserInfo.info['name']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(UserInfo.info['email']),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2, bottom: 2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: UserInfo.info['avatarExtension'] != ''
                        ? CachedNetworkImage(
                            imageUrl: avatarUrl,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error, color: Colors.red),
                          )
                        : Image.asset(defaultUserAvatarAsset),
                  ),
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size(double.maxFinite, deviceHeight * 0.1),
      );
    }
  }

  // ignore: missing_return
  Widget buildCurrentScreen(int screenIndex) {
    switch (screenIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return ShoppingMapScreen();
      case 2:
        return Sections();
      case 3:
        return OffersScreen();
      case 4:
        if (UserInfo.info['type'] == "customer")
          return CustomerAccount();
        else
          return CustomerLogin();
    }
  }

  @override
  void initState() {
    super.initState();
    screenUtil = ScreenUtil.instance;
    Location().findUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<ScreensController, int>(
      selector: (context, screensController) => screensController.screenIndex,
      builder: (context, screenIndexState, child) {
        return SafeArea(
          child: Consumer<UserInfo>(
            builder: (context, userInfo, child) => Scaffold(
              backgroundColor: Colors.white,
              resizeToAvoidBottomPadding: false,
              appBar: buildAppBar(screenIndexState),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: buildCurrentScreen(screenIndexState),
              ),
              bottomNavigationBar: Directionality(
                textDirection: TextDirection.rtl,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      title: Text(
                        'الرئيسية',
                        style: TextStyle(fontSize: 13),
                      ),
                      icon: Image.asset(
                        'assets/icons/home.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                    BottomNavigationBarItem(
                      title: Text(
                        'الخريطة',
                        style: TextStyle(fontSize: 13),
                      ),
                      icon: Image.asset(
                        'assets/icons/shopping_map.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                    BottomNavigationBarItem(
                      title: Text(
                        'الأقسام',
                        style: TextStyle(fontSize: 13),
                      ),
                      icon: Image.asset(
                        'assets/icons/menu.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                    BottomNavigationBarItem(
                      title: Text(
                        'العروض',
                        style: TextStyle(fontSize: 13),
                      ),
                      icon: Image.asset(
                        'assets/icons/offers.png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                    BottomNavigationBarItem(
                      title: Text(
                        'الحساب',
                        style: TextStyle(fontSize: 13),
                      ),
                      icon: Image.asset(
                        'assets/icons/account.png',
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ],
                  selectedItemColor: Colors.blue,
                  unselectedFontSize: screenUtil.setSp(18),
                  selectedFontSize: screenUtil.setSp(20),
                  currentIndex: screenIndexState,
                  onTap: (int i) {
                    Provider.of<ScreensController>(context, listen: false)
                        .changeScreenIndex(i);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
