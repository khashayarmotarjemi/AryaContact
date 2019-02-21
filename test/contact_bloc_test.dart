import 'package:arya_contact/contact/contact_bloc.dart';
import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/contact/contact_repository.dart';
import 'package:arya_contact/postal/postal_data.dart';
import 'package:arya_contact/search/address_search_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

class MockContactRepo extends Mock implements ContactRepository {}

void main() {
  group('contact bloc', () {
    MockContactRepo mockRepo = new MockContactRepo();
    when(mockRepo.getContactData(new PostalData("12"))).thenAnswer(
        (_) => Future.value(ContactData([new Contact("1111", "khashayar",1)])));

    ContactBloc bloc = new ContactBloc(mockRepo);

    test("basic contact get test", () {
      bloc.setPostal.add(new PostalData("12"));
      bloc.contactData.listen((contact) {
        expect(contact.contacts[0], new Contact("1111", "khashayar",1));
      });

      /*     print("\n*********************\n");

      postalBloc.postalData.listen(contactsBloc.setPostal.add);

      postalBloc.setLocation.add(LatLng(32,32));

      contactsBloc.contactData.listen((contactsData) {
        print(contactsData.contacts.length);
        print("\n*********************\n");
      });*/
    });
  });
}
