import 'package:chess_app/features/social/cubit/social_state.dart';
import 'package:chess_app/features/social/enums/social_tabs_enum.dart';
import 'package:chess_app/features/social/widgets/social_friends_section.dart';
import 'package:chess_app/features/social/widgets/social_toggle.dart';
import 'package:chess_app/features/social/cubit/social_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit(),
      child: SocialBody(),
    );
  }
}

class SocialBody extends StatelessWidget {
  const SocialBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SocialToggle(),
              BlocBuilder<SocialCubit, SocialState>(
                builder: (context, state) {
                  if (SocialTabs.friends == state.currentTab) {
                    return SocialFriends(socialState: state);
                  } else {
                    return Text("Global");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
