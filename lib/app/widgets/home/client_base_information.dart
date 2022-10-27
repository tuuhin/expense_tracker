import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/user_info/base_information_cubit.dart';
import '../loading/base_information_shimmer.dart';
import '../widgets.dart';

class ClientBaseInfomation extends StatefulWidget {
  const ClientBaseInfomation({Key? key}) : super(key: key);

  @override
  State<ClientBaseInfomation> createState() => _ClientBaseInfomationState();
}

class _ClientBaseInfomationState extends State<ClientBaseInfomation> {
  final List<String> _title = [
    'Total Expense',
    'Total Income',
    'Montly Expense',
    'Monthly Income'
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<BaseInformationCubit>().getBaseOverView();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseInformationCubit, BaseInformationState>(
      builder: (context, state) {
        if (state is BaseInformationLoading) {
          return const BaseInforamtionShimmer();
        }
        if (state is BaseInformationLoadSucess) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: index == 0 ? 0 : 10),
              child: BaseInformationCards(
                amount: state.data.toList[index],
                title: _title[index],
                backGroundColor:
                    index % 2 == 0 ? null : Theme.of(context).primaryColor,
              ),
            ),
          );
        } else {
          return const Text('none');
        }
      },
    );
  }
}
