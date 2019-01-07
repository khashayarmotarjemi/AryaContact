import 'dart:convert';

import 'package:arya_contact/postal/postal_data.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

abstract class PostalRepository {
  Future<PostalData> getPostalData(LatLng location);
}

class WebPostalRepository extends PostalRepository {
  @override
  Future<PostalData> getPostalData(LatLng location) {
    var url = "http://198.143.180.206:8080/postal";
    return http
        .get(url)
        .then((r) => jsonDecode(r.body)['code'])
        .then((c) => PostalData(c));
  }
}
