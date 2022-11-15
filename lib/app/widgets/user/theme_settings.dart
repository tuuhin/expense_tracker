import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/domain/enums/theme_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({Key? key}) : super(key: key);

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  late ThemeCubit _themeCubit;
  @override
  void didChangeDependencies() {
    _themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const ListTile(
                minVerticalPadding: 0,
                dense: true,
                title: Text('Theme'),
              ),
              const Divider(),
              RadioListTile<ThemeEnum>(
                title: const Text('Light'),
                value: ThemeEnum.light,
                groupValue: _themeCubit.themeEnum,
                dense: true,
                onChanged: (ThemeEnum? mode) {
                  if (mode != null) {
                    _themeCubit.changeTheme(mode);
                  }
                },
              ),
              RadioListTile<ThemeEnum>(
                dense: true,
                title: const Text('Dark'),
                value: ThemeEnum.dark,
                groupValue: _themeCubit.themeEnum,
                onChanged: (ThemeEnum? value) {
                  if (value != null) {
                    _themeCubit.changeTheme(value);
                  }
                },
              ),
              RadioListTile<ThemeEnum>(
                dense: true,
                title: const Text('System'),
                value: ThemeEnum.system,
                groupValue: _themeCubit.themeEnum,
                onChanged: (ThemeEnum? value) {
                  if (value != null) {
                    _themeCubit.changeTheme(value);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
