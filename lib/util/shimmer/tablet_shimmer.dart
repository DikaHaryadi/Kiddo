import 'package:flutter/material.dart';

class TabletShimmer extends StatelessWidget {
  const TabletShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SizedBox(height: 200, child: CircularProgressIndicator()),
      ),
    );
  }
}
