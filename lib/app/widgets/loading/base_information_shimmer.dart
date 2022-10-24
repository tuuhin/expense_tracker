import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BaseInforamtionShimmer extends StatelessWidget {
  const BaseInforamtionShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          4,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 18),
            child: SizedBox(
              width: 150.0,
              child: Shimmer.fromColors(
                direction: ShimmerDirection.ltr,
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.white38,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ));
  }
}
