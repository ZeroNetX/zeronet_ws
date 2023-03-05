import 'package:zeronet_ws/models/models.dart';

class Cert {
  final String authAddress;
  final String authType;
  final String authUserName;
  final String domain;
  final bool selected;

  const Cert({
    required this.authAddress,
    required this.authType,
    required this.authUserName,
    required this.domain,
    required this.selected,
  });

  factory Cert.fromJson(JSONMap map) {
    return Cert(
      authAddress: map['auth_address'],
      authType: map['auth_type'],
      authUserName: map['auth_user_name'],
      domain: map['domain'],
      selected: map['selected'],
    );
  }
}
