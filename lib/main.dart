import 'package:clothes_map/state_management/shops_markers_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admob_flutter/admob_flutter.dart';

import 'package:clothes_map/screens/splash_screen.dart';
import 'package:clothes_map/state_management/account_recovery_notifier.dart';
import 'package:clothes_map/state_management/user_info.dart';
import 'package:clothes_map/utils/styles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(testDeviceIds: ["64CF294066C542DC", "1E633D5C18BEDDEF"]);
  runApp(ClothesMap());
}

class ClothesMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInfo()),
        ChangeNotifierProvider(create: (context) => AccountRecoveryNotifier()),
        ChangeNotifierProvider(create: (context) => ShopsMarkersNotifier()),
      ],
      child: MaterialApp(
        title: 'Clothes Map',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData(
          fontFamily: 'Almarai',
          primaryColor: appPrimaryColor,
          textTheme: TextTheme(
            bodyText2: TextStyle(fontSize: 18),
          ),
          buttonTheme: ButtonThemeData(minWidth: 20),
        ),
      ),
    );
  }
}
