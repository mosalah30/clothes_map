import 'dart:collection';

Map<String, dynamic> cleanReceivedJson(LinkedHashMap map) {
  Map<String, String> newMap = Map<String, String>.from(map);
  for (int i = 0; i < newMap.length; i++) {
    newMap.removeWhere((key, value) => key == i.toString());
  }
  return newMap;
}
