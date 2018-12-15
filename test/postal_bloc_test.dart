import 'package:latlong/latlong.dart';
import 'package:maps_test/postal/postal_bloc.dart';
import 'package:maps_test/postal/postal_data.dart';
import 'package:maps_test/postal/postal_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

class MockPostalRepo extends Mock implements PostalRepository {}

void main() {
  group('postal bloc', () {
    MockPostalRepo mockRepo = new MockPostalRepo();
    when(mockRepo.getPostalData(new LatLng(12,12)))
        .thenAnswer((_) => Future.value(PostalData("1111")));

    PostalBloc bloc = new PostalBloc(mockRepo);

    test("simple postal get test", () {
      bloc.setLocation.add(LatLng(12, 12));
      bloc.postalData.listen((postal) {
        expect(postal.postalCode, "1111");
      });
    });
  });
}
