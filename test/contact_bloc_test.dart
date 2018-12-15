import 'package:maps_test/contact/contact_bloc.dart';
import 'package:maps_test/contact/contact_data.dart';
import 'package:maps_test/contact/contact_repository.dart';
import 'package:maps_test/postal/postal_data.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

class MockContactRepo extends Mock implements ContactRepository {}

void main() {
  group('contact bloc', () {
    MockContactRepo mockRepo = new MockContactRepo();
    when(mockRepo.getContactData(new PostalData("12"))).thenAnswer(
        (_) => Future.value(ContactData([new Contact("1111", "khashayar")])));

    ContactBloc bloc = new ContactBloc(mockRepo);

    test("basic contact get test", () {
      bloc.setPostal.add(new PostalData("12"));
      bloc.contactData.listen((contact) {
        expect(contact.contacts[0], new Contact("1111", "khashayar"));
      });
    });
  });
}
