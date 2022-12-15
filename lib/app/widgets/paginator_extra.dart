import 'package:flutter/material.dart';

class PaginatorLoadMore extends StatelessWidget {
  const PaginatorLoadMore({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(height: 10),
          Text(
            "Loading More",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}

class PaginatorLoadMoreFailed extends StatelessWidget {
  final String message;
  const PaginatorLoadMoreFailed({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/flaticons/fail.png"),
            const SizedBox(width: 20),
            Text(message)
          ],
        ),
      ),
    );
  }
}

class PaginatorEnd extends StatelessWidget {
  final String message;

  const PaginatorEnd({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          message,
          // textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
