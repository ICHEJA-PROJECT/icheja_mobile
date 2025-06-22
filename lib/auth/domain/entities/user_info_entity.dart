import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final int id;
  final String name;
  final String token;

  const UserInfo({
    required this.id,
    required this.name,
    required this.token,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['data']['userInfo']['id'],
      name: json['data']['userInfo']['name'],
      token: json['data']['token'],
    );
  }

  @override
  List<Object?> get props => [id, name, token];
}
