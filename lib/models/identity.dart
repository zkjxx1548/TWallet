import 'package:json_annotation/json_annotation.dart';

part 'identity.g.dart';

@JsonSerializable()
class Identity {
  String name;
  String priKey;
  String pubKey;
  String address;

  Identity({this.name, this.priKey, this.pubKey, this.address});

  factory Identity.fromJson(Map<String, dynamic> json) => _$IdentityFromJson(json);

  Map<String, dynamic> toJson() => _$IdentityToJson(this);
}
