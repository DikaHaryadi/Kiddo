import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:textspeech/util/shimmer.dart';

class ContentShimmer extends StatelessWidget {
  const ContentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(
              children: [
                const DShimmerEffect(
                  width: 60,
                  height: 60,
                  radius: 10.0,
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFfcf4f1),
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DShimmerEffect(
                          width: 100,
                          height: 20,
                          radius: 10.0,
                        ),
                        SizedBox(height: 8),
                        DShimmerEffect(
                          width: 150,
                          height: 20,
                          radius: 10.0,
                        )
                      ],
                    ),
                  ),
                ),
                const DShimmerEffect(
                    width: 50,
                    height: 50,
                    radius: 10.0,
                    boxShape: BoxShape.circle)
              ],
            ));
      },
    );
  }
}
