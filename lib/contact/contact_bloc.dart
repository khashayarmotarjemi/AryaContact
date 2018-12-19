import 'dart:async';

import 'package:arya_contact/contact/contact_data.dart';
import 'package:arya_contact/contact/contact_repository.dart';
import 'package:arya_contact/postal/postal_data.dart';
import 'package:rxdart/rxdart.dart';

class ContactBloc {
  // Inputs
  Sink<PostalData> setPostal;
  Sink<void> reset;

  // Outputs
  Stream<ContactData> contactData;

  final List<StreamSubscription<dynamic>> _subscriptions;

  factory ContactBloc(ContactRepository repository) {
    final contactDataController = BehaviorSubject<ContactData>(
        sync: true, seedValue: new ContactData([]));

    final setPostalController = StreamController<PostalData>(sync: true);
    final resetController = StreamController<void>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      setPostalController.stream.listen((postalData) {
        repository
            .getContactData(postalData)
            .then(contactDataController.sink.add);
      }),
      resetController.stream.listen((_) {
        setPostalController.sink.add(new EmptyPostalData());
      })
    ];

    return ContactBloc._(
        contactDataController, setPostalController, subscriptions);
  }

  ContactBloc._(this.contactData, this.setPostal, this._subscriptions);

  void close() {
    setPostal.close();
    _subscriptions.clear();
  }
}
