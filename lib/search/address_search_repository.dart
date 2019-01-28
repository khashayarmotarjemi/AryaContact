import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

final MAP_API_KEY =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImRjYTY4N2ZjZjI3YmZhMTNiMjI0ZDdiNGQwMTc1Yjg3Y2Y3ODI2YmU5ZmQzYWRiNzUxNWIwMWYyMWNkMzA2M2M5NzIxMWY2ZDc3NjlkOWM5In0.eyJhdWQiOiJteWF3ZXNvbWVhcHAiLCJqdGkiOiJkY2E2ODdmY2YyN2JmYTEzYjIyNGQ3YjRkMDE3NWI4N2NmNzgyNmJlOWZkM2FkYjc1MTViMDFmMjFjZDMwNjNjOTcyMTFmNmQ3NzY5ZDljOSIsImlhdCI6MTU0NDM2MTgzMSwibmJmIjoxNTQ0MzYxODMxLCJleHAiOjE1NDQzNjU0MzEsInN1YiI6IiIsInNjb3BlcyI6WyJiYXNpYyIsImVtYWlsIl19.eaVmXL4JpcUq3V4UBkxZ_kNIuRlAU3ZCkngrqsMzWC1BD6oa6sPTSs-no8ahlCFcWpbejUdJOmQUT_mpWCk8Y8Hey5J1FloYrZcXkMQimosWklfcqiX156RqJlZ25iE2ZrQ2Rui70xxWJn8CTQ5TOJulIny8GqTdWzDCRf3MMw6qetwmPX0i9reOajlVhZMAOhfIs7X9cUWMeIabs4tBIJZrFhtVbqmt7GrhObJ3ioxP34zCC7X0FFRmNqpsAm4nrTVXWkMQgLv9z7kzxREJgpu-QpOXsWfMtTBUPFIveUhGLOQWQBY9QX6OEHa5Eu4M0l9T7fZySffXRjSDCPsS_g";

abstract class AbstractAddressSearchRepository {
  Future<List<SearchLocation>> getSearchLocations(String key);
}

class AddressSearchRepository implements AbstractAddressSearchRepository {
  @override
  Future<List<SearchLocation>> getSearchLocations(String key) {
    var body = """{
  "text": "$key زنجان" ,
  "location": {
    "type": "Point",
    "coordinates": [
      48.5087,
      36.6830
    ]
  }
}""";
    return http
        .post("https://map.ir/search",
            headers: Map.fromEntries([
              MapEntry("x-api-key", MAP_API_KEY),
              MapEntry("Content-Type", "application/json")
            ]),
            body: body)
        .then((r) => jsonDecode(r.body))
        .then((json) {
      var list = json['value'] as List;

      List<SearchLocation> searchLocationList = list
          .map((sl) => SearchLocation(
              LatLng(sl['Coordinate']['lat'], sl['Coordinate']['lon']),
              sl['Title']))
          .toList();

      return Future.delayed(
          Duration(seconds: 2), () => Future.value(searchLocationList));
    });
  }
}

class SearchLocation {
  final LatLng location;
  final String name;

  SearchLocation(this.location, this.name);
}

