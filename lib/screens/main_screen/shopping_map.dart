import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
      builder: (context, admin, child) => GoogleMap(
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
          target: LatLng(Location.userLatitude, Location.userLongitude),
          zoom: 17,
        ),
        cameraTargetBounds: CameraTargetBounds(egyptBounds),
        markers: admin.markers,
      ),
    );
  }
}
