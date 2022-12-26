import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../data/local/storage.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({Key? key}) : super(key: key);

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  late ThemeCubit _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _theme = context.read<ThemeCubit>();
  }

  void onChange(ThemeEnum? mode) => _theme.changeTheme(mode);

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Themming",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const Divider(),
                  RadioListTile<ThemeEnum>(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Light',
                        style: Theme.of(context).textTheme.subtitle1),
                    value: ThemeEnum.light,
                    groupValue: _theme.themeEnum,
                    dense: true,
                    onChanged: onChange,
                  ),
                  RadioListTile<ThemeEnum>(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Dark',
                        style: Theme.of(context).textTheme.subtitle1),
                    value: ThemeEnum.dark,
                    groupValue: _theme.themeEnum,
                    onChanged: onChange,
                  ),
                  RadioListTile<ThemeEnum>(
                    contentPadding: EdgeInsets.zero,
                    title: Text('System',
                        style: Theme.of(context).textTheme.subtitle1),
                    value: ThemeEnum.system,
                    groupValue: _theme.themeEnum,
                    onChanged: onChange,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
