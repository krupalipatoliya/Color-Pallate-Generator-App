import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ColorPallateGeneratorApi {
  ColorPallateGeneratorApi._();

  static final ColorPallateGeneratorApi colorPallateGeneratorApi =
      ColorPallateGeneratorApi._();

  Future<List?> changePaletteAPICalling() async {
    http.Response response = await http.get(
      Uri.parse("http://palett.es/API/v1/palette"),
    );

    if (response.statusCode == 200) {
      List decodedData = jsonDecode(response.body);

      List rawData = decodedData;

      print("rawData :-- $rawData");
      return rawData;
    }
    return null;
  }
}

class ColorPallateGenerator extends ChangeNotifier {
  var data = ColorPallateGeneratorApi.colorPallateGeneratorApi
      .changePaletteAPICalling();

  Color() async {
    data = ColorPallateGeneratorApi.colorPallateGeneratorApi
        .changePaletteAPICalling();

    notifyListeners();
  }
}
