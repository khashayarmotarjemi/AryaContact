import 'package:quiver/core.dart';

class PostalData {
  final String postalCode;

  PostalData(this.postalCode);

  @override
  bool operator ==(other) {
   return other is PostalData && this.postalCode == other.postalCode;
  }

  @override
  int get hashCode {
    return hash2(this.postalCode,1);
  }


}