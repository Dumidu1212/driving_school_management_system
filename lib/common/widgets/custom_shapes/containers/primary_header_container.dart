import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';


class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.only(bottom: 0),

        /// -- If [size.isFinite': is not true.in Stack] error occurred ->  Read README.md file
        child: SizedBox(
          child: Stack(
            children: [
              /// -- Background Custom Shapes
              // Positioned(
              //     top: -150,
              //     right: -250,
              //     child: CircularContainer(
              //         backgroundColor: TColors.textWhite.withOpacity(0.1))),
              // Positioned(
              //     top: 100,
              //     right: -300,
              //     child: CircularContainer(
              //         backgroundColor: TColors.textWhite.withOpacity(0.1))),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
