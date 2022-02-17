import 'package:expense_tracker/services/api/income_client.dart';
import 'package:expense_tracker/services/cubits/income_sources/income_source_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSource extends StatefulWidget {
  const AddSource({Key? key}) : super(key: key);

  @override
  State<AddSource> createState() => _AddSourceState();
}

class _AddSourceState extends State<AddSource> {
  final IncomeClient _apiClient = IncomeClient();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  late IncomeSourceCubit _incomeSourceCubit;
  bool _isLoading = false;

  bool? _isSecure = true;

  Future<void> _addSource(BuildContext context) async {
    if (_title.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: const Text('Title can\'t be blank'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK I got  it!!'))
                ],
              ));
      return;
    }
    setState(() => _isLoading = !_isLoading);
    bool? _isResponse = await _apiClient.addIncomeSource(_title.text,
        desc: _desc.text, isSecure: _isSecure);
    setState(() => _isLoading = !_isLoading);
    if (_isResponse == true) {
      _incomeSourceCubit.refreshSources();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New Source added  successfully')));
    }
  }

  @override
  void initState() {
    super.initState();
    _incomeSourceCubit = BlocProvider.of<IncomeSourceCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final double _screenX = MediaQuery.of(context).size.width;
    final double _screenY = MediaQuery.of(context).size.height;
    return SizedBox(
      height: _screenY * .5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                  hintText: 'Title',
                  helperText: 'Maximum 50 characters alowed'),
            ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 3,
              controller: _desc,
              decoration: const InputDecoration(
                  hintText: 'Description',
                  helperText: 'Maximum 250 characters alowed'),
            ),
            ListTile(
              dense: true,
              leading: Checkbox(
                  activeColor: Theme.of(context).colorScheme.secondary,
                  value: _isSecure,
                  onChanged: (bool? value) =>
                      setState(() => _isSecure = value)),
              title: const Text('Wheather this source is secure?'),
            ),
            const Divider(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    fixedSize: Size(_screenX, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () async => {await _addSource(context)},
                child: Text(_isLoading ? 'Adding...' : 'Add Income Source',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
