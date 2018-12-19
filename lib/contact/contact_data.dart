import 'package:quiver/core.dart';

class ContactData {
  final List<Contact> contacts;

  ContactData(this.contacts);

  @override
  bool operator ==(other) {
    return other is ContactData && this.contacts == other.contacts;
  }

  @override
  int get hashCode {
    return hash2(contacts, 1);
  }
}

class EmptyContactData extends ContactData {
  EmptyContactData() : super([]);
}

class Contact {
  final String phoneNumber;
  final String name;
  final String imgUrl;

  Contact(this.phoneNumber, this.name,
      {this.imgUrl =
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-EN2wkpax0yP9U26S5wG2GgqEEspDujX-939pT_B3JJUamwQA"});

  @override
  int get hashCode {
    return hash2(phoneNumber, name);
  }

  @override
  bool operator ==(other) {
    return other is Contact && this.phoneNumber == other.phoneNumber;
  }
}
