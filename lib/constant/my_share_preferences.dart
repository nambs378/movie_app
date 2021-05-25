import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  MySharedPreferences._privateConstructor();

  static final MySharedPreferences instance =
  MySharedPreferences._privateConstructor();

  setStringValue(String key, String value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setString(key, value);
  }

  Future<String> getStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getString(key) ?? "";
  }

  setIntegerValue(String key, int value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setInt(key, value);
  }

  // setMapValue(String key, String keyMap, dynamic valueMap) async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   String encodedMap = myPrefs.getString(key) ?? "";
  //   Map<String,dynamic> decodedMap = {};
  //   if (encodedMap == "") {
  //     decodedMap = json.decode(encodedMap);
  //     print(decodedMap);
  //   }
  //   decodedMap[keyMap] = valueMap;
  //   encodedMap = json.encode(decodedMap);
  //   print(encodedMap);
  //   myPrefs.setString('timeData', encodedMap);
  // }
  //
  // Future<Map<String, dynamic>> getMapValue(String key) async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //   String encodedMap = myPrefs.getString(key) ?? "";
  //   Map<String,dynamic> decodedMap = {};
  //   if (encodedMap == "" ) {
  //     decodedMap = json.decode(encodedMap);
  //     print(decodedMap);
  //   }
  //   return decodedMap;
  // }

  Future<int> getIntegerValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getInt(key) ?? 0;
  }

  Future<List<String>> getListStringValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    List<String> listDefault = [];
    if (myPrefs.getStringList(key) != null) {
      listDefault = myPrefs.getStringList(key)!;
    }
    return listDefault;
  }

  setListStringValue(String key, List<String> list) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setStringList(key, list);
  }

  setBooleanValue(String key, bool value) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setBool(key, value);
  }

  Future<bool> getBooleanValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.getBool(key) ?? false;
  }

  Future<bool> containsKey(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.containsKey(key);
  }

  removeValue(String key) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.remove(key);
  }

  removeAll() async{
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    return myPrefs.clear();
  }

}