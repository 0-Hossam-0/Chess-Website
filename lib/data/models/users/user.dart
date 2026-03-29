import 'package:chess_app/features/social/enums/social_activity_status_enum.dart';
import 'package:chess_app/features/social/enums/social_user_status_enum.dart';

class User {
  final UserStatus status;
  final UserActivityStatus activity;

  const User({required this.status, required this.activity});

  User copyWith({UserStatus? status, UserActivityStatus? activity}) {
    return User(
      status: status ?? this.status,
      activity: activity ?? this.activity,
    );
  }
}
