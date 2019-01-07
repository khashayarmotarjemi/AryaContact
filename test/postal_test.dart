import 'package:arya_contact/postal/postal_bloc.dart';
import 'package:arya_contact/postal/postal_data.dart';
import 'package:arya_contact/postal/postal_repository.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

class MockPostalRepo extends Mock implements PostalRepository {}

void main() {
  group('postal repo', () {
    WebPostalRepository repo = new WebPostalRepository();

    var url = "http://198.143.180.206:8080/postal";

    http.get(url).then((r) {
      PostalData(r.body);
      print("helooo");
    });

    http.read(url).then(print);


    test("simple get test", () {
      repo.getPostalData(LatLng(1, 1)).then((p) => p.postalCode).then(print);
    });
  });

  group('postal bloc', () {
    MockPostalRepo mockRepo = new MockPostalRepo();
    when(mockRepo.getPostalData(new LatLng(12, 12)))
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
