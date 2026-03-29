import 'package:chess_app/data/models/users/user.dart';
import 'package:chess_app/features/social/enums/social_tabs_enum.dart';
import 'package:chess_app/features/social/enums/social_user_status_enum.dart';

import '../enums/social_activity_status_enum.dart' show UserActivityStatus;

class SocialState {
  final SocialTabs currentTab;
  final List<User> users;

  const SocialState({
    this.currentTab = SocialTabs.friends,
    this.users = const [
      User(status: UserStatus.online, activity: UserActivityStatus.playing),
      User(status: UserStatus.offline, activity: UserActivityStatus.inMenu),
      User(status: UserStatus.idle, activity: UserActivityStatus.playing),
    ],
  });

  SocialState copyWith({SocialTabs? currentTab, List<User>? users}) {
    return SocialState(
      currentTab: currentTab ?? this.currentTab,
      users: users ?? this.users,
    );
  }
}
