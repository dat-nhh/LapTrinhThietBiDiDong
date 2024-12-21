import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dat_nhh_63133655_flutter/main.dart';
import 'package:dat_nhh_63133655_flutter/json/json_data.dart';

void main() {
  test("Test json data", () async{
    var list = await getHTTP_content();
    print(list[0].title);
  });
}
