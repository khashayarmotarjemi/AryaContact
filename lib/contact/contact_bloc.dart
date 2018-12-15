import 'dart:async';

import 'package:maps_test/postal/postal_data.dart';
import 'package:rxdart/rxdart.dart';

class ContactBloc {
  // Inputs
  Sink<PostalData> setPostal;

  // Outputs
  Stream<ContactData> contactData;

  final List<StreamSubscription<dynamic>> _subscriptions;

  factory ContactBloc(ContactRepository repository) {
    final contactDataController =
        BehaviorSubject<ContactData>(sync: true, seedValue: null);

    final setPostalController = StreamController<PostalData>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      setPostalController.stream.listen((postalData) {
        Observable.fromFuture(repository.getContactData(postalData))
            .pipe(contactDataController);
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

class ContactData {
  final String phoneNumber;

  ContactData(this.phoneNumber);
}

abstract class ContactRepository {
  Future<ContactData> getContactData(PostalData postal);
}
