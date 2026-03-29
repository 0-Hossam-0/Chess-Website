import 'package:chess_app/data/models/users/user.dart';
import 'package:chess_app/features/social/enums/social_activity_status_enum.dart';
import 'package:chess_app/features/social/cubit/social_state.dart';
import 'package:chess_app/features/social/enums/social_user_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialFriendWidget extends StatelessWidget {
  const SocialFriendWidget({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final dividerTheme = theme.dividerTheme;
    final isOnline = user.status == UserStatus.online;
    final isPlaying = user.activity == UserActivityStatus.playing;
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: BoxBorder.all(
          color: dividerTheme.color ?? Colors.black,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      width: 40.w,
                      height: 40.h,
                      opacity: isOnline
                          ? AlwaysStoppedAnimation(1)
                          : AlwaysStoppedAnimation(0.5),
                      "assets/images/google_logo.png",
                    ),
                  ),
                  Positioned(
                    right: -3,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: getStatusColor(user.status),
                        border: BoxBorder.all(
                          color: colorScheme.surface,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hossam Ahmed",
                    style: TextStyle(
                      color: isOnline ? Colors.white : Colors.grey,
                    ),
                  ),
                  Text(
                    getActivityString(user),
                    style: TextStyle(color: dividerTheme.color),
                  ),
                ],
              ),
            ],
          ),
          if (isOnline)
            _actionButton(
              isPlaying ? colorScheme.primary : colorScheme.surface,
              isPlaying ? Colors.transparent : dividerTheme.color!,
            ),
        ],
      ),
    );
  }

  Widget _actionButton(Color buttonColor, Color borderColor) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor),
          ),
        ),
        minimumSize: WidgetStateProperty.all(const Size(100, 35)),
        backgroundColor: WidgetStateProperty.all(buttonColor),
      ),
      child: Text("Challenge", style: TextStyle(color: Colors.white)),
    );
  }

  Color getStatusColor(UserStatus userStatus) {
    switch (userStatus) {
      case UserStatus.online:
        return Colors.green;
      case UserStatus.idle:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String getActivityString(User user) {
    if (user.status == UserStatus.offline) return "Offline";
    switch (user.activity) {
      case UserActivityStatus.playing:
        return "Playing";
      default:
        return "In Menu";
    }
  }
}
