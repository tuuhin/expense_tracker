import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 80.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.black12,
                  highlightColor: Colors.white38,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ),
            childCount: 10,
          ),
        ),
      );
}
