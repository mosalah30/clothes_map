import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:clothes_map/utils/values.dart';
import 'package:clothes_map/utils/styles.dart';

class ShopsMarkersNotifier extends ChangeNotifier {
  final completer = Completer<GoogleMapController>();
  Set<Marker> markers = Set<Marker>();

  bool loading = false;

  void changeLoaderState(bool newBool) {
    loading = newBool;
    notifyListeners();
  }

  Future<Uint8List> getMarkerIcon(String url) async {
    final markerImageFile = await DefaultCacheManager().getSingleFile(url);
    final markerImageBytes = await markerImageFile.readAsBytes();
    final markerImageCodec = await instantiateImageCodec(
      markerImageBytes,
      targetWidth: markerSize,
      targetHeight: markerSize,
    );
    final frameInfo = await markerImageCodec.getNextFrame();
    final byteData = await frameInfo.image.toByteData(
      format: ImageByteFormat.png,
    );
    final resizedMarkerImageBytes = byteData.buffer.asUint8List();
    return resizedMarkerImageBytes;
  }

  Future<void> getMarkersOfCurrentArea(LatLngBounds areaBounds) async {
    try {
      http.Response response = await http.post(
        getMarkersAPI,
        body: {
          'north': '${areaBounds.northeast.latitude}',
          'south': '${areaBounds.southwest.latitude}',
          'west': '${areaBounds.southwest.longitude}',
          'east': '${areaBounds.northeast.longitude}',
        },
      );

      List<dynamic> results = json.decode(response.body);

      if (results.isNotEmpty) {
        for (var shop in results) {
          Uint8List markerByteData = await getMarkerIcon(
            '$shopsMarkersStorage/${shop['phoneNumber']}.${shop['markerExtension']}',
          );
          Marker newMarker = Marker(
            markerId: MarkerId(shop['shop_id']),
            position: LatLng(
              double.parse(shop['latitude']),
              double.parse(shop['longitude']),
            ),
            icon: BitmapDescriptor.fromBytes(markerByteData),
            infoWindow: InfoWindow(title: shop['shopName']),
            onTap: () {},
          );
          if (!markers.contains(newMarker)) {
            markers.add(newMarker);
          }
        }
      }
    } catch (e) {}
    notifyListeners();
  }
}
