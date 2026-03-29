import 'package:chess_app/data/models/users/user.dart';
import 'package:chess_app/features/social/enums/social_activity_status_enum.dart';
import 'package:chess_app/features/social/cubit/social_state.dart';
import 'package:chess_app/features/social/enums/social_tabs_enum.dart';
import 'package:chess_app/features/social/enums/social_user_status_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialState> {
  static final List<User> initialUsers = [
    User(status: UserStatus.online, activity: UserActivityStatus.inMenu),
    User(status: UserStatus.online, activity: UserActivityStatus.inMenu),
    User(status: UserStatus.idle, activity: UserActivityStatus.playing),
  ];

  SocialCubit() : super(SocialState(users: initialUsers));

  void switchToFriends() =>
      emit(state.copyWith(currentTab: SocialTabs.friends));

  void switchToGlobal() => emit(state.copyWith(currentTab: SocialTabs.global));

  // void updateStatus(UserStatus newStatus) {
  //   emit(state.copyWith(userStatus: newStatus));
  // }

  // void updateActivity(UserActivityStatus newActivity) {
  //   emit(state.copyWith(activity: newActivity));
  // }
}
