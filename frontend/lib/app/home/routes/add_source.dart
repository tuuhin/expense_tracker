import 'package:expense_tracker/services/api/api_client.dart';
import 'package:flutter/material.dart';

class AddSource extends StatefulWidget {
  const AddSource({Key? key}) : super(key: key);

  @override
  State<AddSource> createState() => _AddSourceState();
}

class _AddSourceState extends State<AddSource> {
  final ApiClient _apiClient = ApiClient();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  bool? _isSecure = true;

  Future<void> _addSource(BuildContext context) async {
    if (_title.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                content: const Text('Title can\'t be blank'),
              ));
      return;
    }
    print('hi');
    await _apiClient.addIncomeSource(_title.text,
        desc: _desc.text, isSecure: _isSecure);
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                  hintText: 'Title',
                  helperText: 'Maximum 50 characters alowed'),
            ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 4,
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
                child: Text('Add Income Source',
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
