import 'package:latlong/latlong.dart';
import 'package:maps_test/contact/contact_bloc.dart';
import 'package:maps_test/postal/postal_data.dart';
import 'package:test_api/test_api.dart';
import 'package:mockito/mockito.dart';

class MockContactRepo extends Mock implements ContactRepository{}


void main() {
  group('contact bloc', () {
    var mockRepo = new MockContactRepo();
    when(mockRepo.getContactData(new PostalData("12"))).thenAnswer((_) => Future.value(ContactData("23322")));

    ContactBloc bloc = new ContactBloc(mockRepo);
    mockRepo.getContactData(new PostalData("12")).then((data) => print(data.contactCode));
  });
  /*test("viewPoint test", () {

    });*/
}
