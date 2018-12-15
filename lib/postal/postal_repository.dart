import 'package:latlong/latlong.dart';
import 'package:maps_test/postal/postal_data.dart';

abstract class PostalRepository {
  Future<PostalData> getPostalData(LatLng location);
}
