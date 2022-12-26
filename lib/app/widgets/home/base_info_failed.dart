import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';

class BaseInfoFailed extends StatelessWidget {
  final String message;
  const BaseInfoFailed({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/flaticons/error.png", scale: 1.25),
          Text(message, style: Theme.of(context).textTheme.caption),
          TextButton(
            onPressed: context.read<BaseInformationCubit>().refresh,
            child: Text(
              "Try again",
              style: TextStyle(
                  color: Colors.red[400], fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
