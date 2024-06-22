import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tokens_response.g.dart';

@immutable
@JsonSerializable()
class TokensResponse {
  final String token;
  final String refreshToken;

  const TokensResponse({
    required this.token,
    required this.refreshToken,
  });

  factory TokensResponse.fromJson(Map<String, dynamic> json) =>
      _$TokensResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokensResponseToJson(this);
}
