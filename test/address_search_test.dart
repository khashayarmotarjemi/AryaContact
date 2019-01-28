import 'package:arya_contact/search/address_search_repository.dart';
import 'package:latlong/latlong.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

class MockAddressSearchRepo extends Mock implements AbstractAddressSearchRepository {}

void main() {
  group('address search bloc', () {
      AbstractAddressSearchRepository repo = new MockAddressSearchRepo();

      test("get simple address search", () {
      when(repo.getSearchLocations("darvaze arg")).thenAnswer(
              (_) => Future.value([SearchLocation(LatLng(12,12),"aaaa"),
              SearchLocation(LatLng(12,12),"aaaa"),
              SearchLocation(LatLng(12,12),"aaaa")]));
      });
  });
}
