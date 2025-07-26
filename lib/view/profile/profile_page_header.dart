import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class ProfilePageHeader extends StatelessWidget {
  const ProfilePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal:  16.0, vertical: 2),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/logo1.png'),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Milad AlNser',
                  style: TextStyle(
                    fontSize: 20 * textScale,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Miladalnser@gmail.com',
                  style: TextStyle(
                    fontSize: 18 * textScale,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
