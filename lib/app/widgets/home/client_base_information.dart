import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets.dart';
import '../../../context/context.dart';

class ClientBaseInfomation extends StatelessWidget {
  const ClientBaseInfomation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<BaseInformationCubit, BaseInformationState>(
        listener: (context, state) => state.whenOrNull(
          failed: (_, message) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message))),
          errorWithData: (_, __, message) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message))),
        ),
        builder: (context, state) => state.when(
          loading: () => const BaseInforamtionShimmer(),
          success: (data, _) => BaseInfoData(data: data),
          failed: (err, message) => BaseInfoFailed(message: message),
          errorWithData: (_, data, __) => BaseInfoData(data: data),
        ),
      );
}
