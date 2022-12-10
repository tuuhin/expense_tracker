import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EntriesLoadingCard extends StatelessWidget {
  const EntriesLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 50.0,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.4),
                highlightColor: Colors.white38,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          childCount: 10,
        ),
      );
}
