import 'package:quiver/core.dart';

class ContactData {
  final List<Contact> contacts;

  ContactData(this.contacts);
}

class Contact {
  final String phoneNumber;
  final String name;

  Contact(this.phoneNumber,this.name);

  @override
  int get hashCode {
    return hash2(phoneNumber,name);
  }

  @override
  bool operator ==(other) {
    return other is Contact && this.phoneNumber == other.phoneNumber;
  }


}

