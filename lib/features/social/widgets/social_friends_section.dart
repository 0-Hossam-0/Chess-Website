import 'package:chess_app/features/social/cubit/social_cubit.dart';
import 'package:chess_app/features/social/cubit/social_state.dart';
import 'package:chess_app/features/social/enums/social_user_status_enum.dart';
import 'package:chess_app/features/social/widgets/social_friend_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialFriends extends StatelessWidget {
  const SocialFriends({super.key, required this.socialState});
  final SocialState socialState;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<SocialCubit, SocialState>(
        builder: (context, state) {
          final onlineUsers = state.users
              .where((user) => user.status == UserStatus.online)
              .toList();

          return Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Online -- 3"),
              for (var user in onlineUsers) SocialFriendWidget(user: user),
              // onlineUsers
              //     .map((user) => SocialFriendWidget(user: user))
              //     .toList(),

              // SocialFriendWidget(user: user),
              // SocialFriendWidget(user: user),
              // Text("Offline -- 1"),
              // SocialFriendWidget(user: user),
            ],
          );
        },
      ),
    );
  }
}
