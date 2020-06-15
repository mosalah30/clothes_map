import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:clothes_map/components/colors_loader.dart';
import 'package:clothes_map/state_management/shops_markers_notifier.dart';
import 'package:clothes_map/services/location.dart';
import 'package:clothes_map/utils/values.dart';
import 'package:clothes_map/utils/styles.dart';

class ShoppingMapScreen extends StatefulWidget {
  @override
  _ShoppingMapScreenState createState() => _ShoppingMapScreenState();
}

class _ShoppingMapScreenState extends State<ShoppingMapScreen> {
  ShopsMarkersNotifier shopsMarkersNotifier;
  GoogleMapController _controller;
  List<String> category = ['رجالي', 'حريمي', 'أطفالي'];

  @override
  void initState() {
    super.initState();
    shopsMarkersNotifier = Provider.of<ShopsMarkersNotifier>(
      context,
      listen: false,
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
    controller.setMapStyle(googleMapStyle);
    shopsMarkersNotifier.completer.complete(controller);
    shopsMarkersNotifier.getMarkersOfCurrentArea(
      await _controller.getVisibleRegion(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopsMarkersNotifier>(
      builder: (context, admin, child) => ModalProgressHUD(
        inAsyncCall: admin.loading,
        progressIndicator: ColorsLoader(),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: ToggleButtons(
                  onPressed: (int i) async {
                    admin.selectSection(i);
                    if (i == 3) {
                      await shopsMarkersNotifier.resetFilter(
                        await _controller.getVisibleRegion(),
                      );
                    } else {
                      await shopsMarkersNotifier.filterShopMarkers(
                        category[i],
                        await _controller.getVisibleRegion(),
                      );
                    }
                  },
                  isSelected: admin.categorySelectionStates,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text('رجالي'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text('حريمي'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text('أطفالي'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text('الكل'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: GoogleMap(
                onCameraMoveStarted: () async {
                  admin.getMarkersOfCurrentArea(
                    await _controller.getVisibleRegion(),
                  );
                },
                minMaxZoomPreference: MinMaxZoomPreference(7, 17),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(Location.userLatitude, Location.userLongitude),
                  zoom: 17,
                ),
                cameraTargetBounds: CameraTargetBounds(egyptBounds),
                markers: admin.markers,
              ),
            ),
            Expanded(
              flex: 1,
              child: AdmobBanner(
                adSize: AdmobBannerSize.BANNER,
                adUnitId: shoppingMapAdUnitId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
