import 'package:latlong/latlong.dart';
import 'package:maps_test/postal/postal_bloc.dart';
import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';

class MockPostalRepo extends Mock implements PostalRepository{}


void main() {
  group('postal bloc', () {
    var mockRepo = new MockPostalRepo();
    when(mockRepo.getPostalData(new LatLng(20,20))).thenAnswer((_) => Future.value(PostalData("23322")));

    PostalBloc bloc = new PostalBloc(mockRepo);
    mockRepo.getPostalData(new LatLng(21, 20)).then((data) => print(data.postalCode));
  });
    /*test("viewPoint test", () {

    });*/
}
