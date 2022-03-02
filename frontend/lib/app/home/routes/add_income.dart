import 'package:expense_tracker/app/home/routes/bottomsheet/add_source.dart';
import 'package:expense_tracker/app/widgets/income_list_tile.dart';
import 'package:expense_tracker/services/api/income_client.dart';
import 'package:expense_tracker/services/cubits/income_sources/income_source_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({Key? key}) : super(key: key);

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _value = TextEditingController();
  final TextEditingController _description = TextEditingController();
  late IncomeSourceCubit _incomeSourceCubit;
  bool _isLoading = false;

  final OutlinedBorder _bottomSheetBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)));

  void _showBottomSheet(BuildContext context) => showModalBottomSheet(
      shape: _bottomSheetBorder,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const AddSource(),
          ));

  void _addNewIncome(BuildContext context) async {
    final IncomeClient _clt = IncomeClient();
    if (_title.text.isEmpty || _value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Either one of title or amount is blank')));
      return;
    }
    if (num.tryParse(_value.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Amount should alaways be a number.')));
      return;
    }
    if (_incomeSourceCubit.sources.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('add A source')));
      return;
    }
    setState(() => _isLoading = !_isLoading);
    bool? success = await _clt.addNewIncome(
        title: _title.text,
        amount: num.parse(_value.text),
        desc: _description.text,
        sources: _incomeSourceCubit.sources);
    setState(() => _isLoading = !_isLoading);
    if (success == true) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Income added succeessfully')));
      _title.text = '';
      _description.text = '';
      _value.text = '';
      _incomeSourceCubit.refreshSources();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Income failed to be added')));
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
    final IncomeSourceCubit _incomeSources =
        BlocProvider.of<IncomeSourceCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Add Income'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              Theme.of(context).scaffoldBackgroundColor,
            ])),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 70),
              TextField(
                controller: _title,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    labelText: 'Title',
                    helperText: 'Income title can be of maximum 50 characters'),
              ),
              const SizedBox(height: 15),
              TextField(
                maxLines: 3,
                controller: _description,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'Description',
                    helperText:
                        'Add a income description for future preference'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                trailing: IconButton(
                    onPressed: () => _incomeSources.refreshSources(),
                    icon: const Icon(Icons.refresh)),
                title: const Text('Sources'),
                subtitle: const Text('Select your income sources'),
              ),
              SizedBox(
                height: _screenY * .2,
                child: BlocBuilder<IncomeSourceCubit, IncomeSourceState>(
                  builder: (context, state) {
                    if (state is IncomeSourceLoad) {
                      _incomeSources.loadData();
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is IncomeSourceLoaded) {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.models.length,
                          itemBuilder: (context, int item) =>
                              IncomeSourceListTile(
                                id: state.models[item]!.id,
                                title: state.models[item]!.title,
                                subtitle: state.models[item]!.desc ?? '',
                              ));
                    }
                    if (state is IncomeSourceLoadFailed) {
                      return const Icon(Icons.no_backpack);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(_screenX, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  onPressed: () => _showBottomSheet(context),
                  child: Text('Add new  Sources',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white))),
              const Divider(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(_screenX, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  onPressed: () => _addNewIncome(context),
                  child: Text(_isLoading ? 'Adding..' : 'Add Income',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
