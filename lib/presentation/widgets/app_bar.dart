import 'package:chess_app/presentation/widgets/chess_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChessAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChessAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomPaint(
                size: Size(35, 35),
                painter: ChessLogo(color: colorScheme.primary),
              ),
              Text("Chess"),
            ],
          ),
          Image.network(
            width: 40.w,
            height: 40.h,
            "https://banner2.cleanpng.com/20180614/cff/kisspng-computer-icons-user-profile-head-icon-5b22c5b086e357.9839733815290054885525.jpg",
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
