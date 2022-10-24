import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/user_info/base_information_cubit.dart';
import '../loading/base_information_shimmer.dart';

class ClientBaseInfomation extends StatefulWidget {
  const ClientBaseInfomation({Key? key}) : super(key: key);

  @override
  State<ClientBaseInfomation> createState() => _ClientBaseInfomationState();
}

class _ClientBaseInfomationState extends State<ClientBaseInfomation> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<BaseInformationCubit>().getBaseOverView();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (context.read<BaseInformationCubit>().state
    //       is BaseInformationLoadSucess) {
    //     for (var i = 0; i < 4; i++) {
    //       context
    //           .read<BaseInformationCubit>()
    //           .listKey
    //           .currentState
    //           ?.insertItem(0);
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseInformationCubit, BaseInformationState>(
      builder: (context, state) {
        if (state is BaseInformationLoading) {
          return const BaseInforamtionShimmer();
        }
        if (state is BaseInformationLoadSucess) {
          return AnimatedList(
            key: context.read<BaseInformationCubit>().listKey,
            itemBuilder: (context, index, animation) => Text(index.toString()),
          );
        } else {
          return Text('none');
        }
      },
    );
  }
}
