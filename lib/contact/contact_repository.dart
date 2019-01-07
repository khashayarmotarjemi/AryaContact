import 'dart:convert';

import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/postal/postal_data.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

abstract class ContactRepository {
  Future<ContactData> getContactData(PostalData postal);
}

class WebContactRepository extends ContactRepository {
  @override
  Future<ContactData> getContactData(PostalData postal) {
    var url = "http://198.143.180.206:8080/postal";
    return http.get(url).then((r) => jsonDecode(r.body));
/*
        .then((json) => Contact(json['phone'].toString(), json['name']));
*/
  }
}

