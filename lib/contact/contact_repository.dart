import 'package:maps_test/contact/contact_data.dart';
import 'package:maps_test/postal/postal_data.dart';

abstract class ContactRepository {
  Future<ContactData> getContactData(PostalData postal);
}