import 'package:flutter/material.dart';
import 'app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String initials;
  final double radius;
  final bool showEditButton;
  final VoidCallback? onEditTap;

  const ProfileAvatar({
    super.key,
    required this.initials,
    this.radius = 56,
    this.showEditButton = true,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.white,
            child: Text(
              initials,
              style: TextStyle(
                fontSize: radius * 0.64,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
        if (showEditButton)
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: onEditTap ??
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Edit profile picture'),
                        backgroundColor: Color(0xFF10B981),
                      ),
                    );
                  },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.edit_rounded,
                  color: AppColors.primary,
                  size: radius * 0.36,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
