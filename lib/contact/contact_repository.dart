import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/postal/postal_data.dart';

abstract class ContactRepository {
  Future<ContactData> getContactData(PostalData postal);
}