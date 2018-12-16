import 'package:latlong/latlong.dart';
import 'package:arya_contact/postal/postal_data.dart';

abstract class PostalRepository {
  Future<PostalData> getPostalData(LatLng location);
}
