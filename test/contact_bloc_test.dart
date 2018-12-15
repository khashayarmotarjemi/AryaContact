import 'package:maps_test/contact/contact_bloc.dart';
import 'package:maps_test/postal/postal_data.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

class MockContactRepo extends Mock implements ContactRepository {}

void main() {
  group('contact bloc', () {
    MockContactRepo mockRepo = new MockContactRepo();
    when(mockRepo.getContactData(new PostalData("12")))
        .thenAnswer((_) => Future.value(ContactData("1111")));

    ContactBloc bloc = new ContactBloc(mockRepo);

    test("basic contact get test", () {
      bloc.setPostal.add(new PostalData("12"));
      bloc.contactData.listen((contact) {
        expect(contact.phoneNumber, "1111");
      });
    });
  });
}
