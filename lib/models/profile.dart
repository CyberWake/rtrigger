import 'package:flutter/cupertino.dart';

class UserProfile {
  final String username;
  final String userId;
  final String email;
  final String address;
  final int phone;
  final String imageUrl;

  UserProfile(
      {@required this.username,
      @required this.userId,
      @required this.email,
      @required this.address,
      @required this.phone,
      @required this.imageUrl});
}
