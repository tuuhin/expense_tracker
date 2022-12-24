import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/widgets.dart';

class CreateGoals extends StatefulWidget {
  final GoalsModel? goal;
  final bool isUpdate;
  const CreateGoals({
    super.key,
    this.goal,
    this.isUpdate = false,
  }) : assert(isUpdate ? goal != null : true);

  @override
  State<CreateGoals> createState() => _CreateGoalsState();
}

class _CreateGoalsState extends State<CreateGoals> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _price;
  late TextEditingController _collected;

  File? _receipt;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _pickImage() => showModalBottomSheet(
        context: context,
        builder: (context) =>
            ReceiptPicker(setFile: (file) => setState(() => _receipt = file)),
      );

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(
        text: widget.isUpdate && widget.goal != null ? widget.goal?.title : '');
    _desc = TextEditingController(
        text: widget.isUpdate && widget.goal != null ? widget.goal?.desc : '');
    _price = TextEditingController(
      text: widget.isUpdate && widget.goal != null
          ? widget.goal!.price.toString()
          : '',
    );
    _collected = TextEditingController(
      text: widget.isUpdate && widget.goal != null
          ? widget.goal!.collected.toString()
          : '',
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _price.dispose();
    _collected.dispose();

    super.dispose();
  }

  void _updateGoal() async {
    if (!_formKey.currentState!.validate()) return;
    if (widget.isUpdate && widget.goal != null) {
      context.read<GoalsBloc>().updateGoal(
            widget.goal!.copyWith(
              title: _title.text,
              desc: _desc.text.isEmpty ? null : _desc.text,
              collected: double.parse(_collected.text),
              price: double.parse(_price.text),
              imageUrl: _receipt?.path,
            ),
          );
    }
  }

  void _addGoal() async {
    if (!_formKey.currentState!.validate()) return;
    context.read<GoalsBloc>().createGoal(
          CreateGoalModel(
            title: _title.text,
            desc: _desc.text.isEmpty ? null : _desc.text,
            collected: double.parse(_collected.text),
            price: double.parse(_price.text),
            imageUrl: _receipt?.path,
          ),
        );
    Navigator.of(context)
        .popUntil((route) => route.settings.name == '/goals' ? true : false);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:
          AppBar(title: Text(widget.isUpdate ? 'Update Goal' : 'Create Goal')),
      body: BlocListener<UiEventCubit<GoalsModel>, UiEventState<GoalsModel>>(
        bloc: context.read<GoalsBloc>().uiEvent,
        listener: (context, state) => state.whenOrNull(
          showSnackBar: (message, data) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message))),
          showDialog: (message, content, data) => showDialog(
              context: context,
              builder: (context) =>
                  UiEventDialog(title: message, content: content)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox.square(
                  dimension: size.width * .4,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _receipt != null
                          ? DropImageShadow(
                              scale: 1,
                              borderRadius: 10,
                              offset: const Offset(10, 10),
                              blurRadius: 10,
                              image: Image.file(_receipt!, fit: BoxFit.fill),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black26, width: 2),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black12,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.camera, color: Colors.black26),
                                  Text(
                                    'Add Image',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black26),
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
                const Divider(),
                TextFormField(
                  validator: (value) => value != null && value.isEmpty
                      ? "Enter some title"
                      : null,
                  controller: _title,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Someday I will get that',
                    labelText: 'Title',
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _desc,
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'This is my only wish.I will someday have that',
                    hintStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      letterSpacing: 0.125,
                    ),
                    labelText: 'Goal Description',
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) => value != null && value.isEmpty
                      ? 'Enter some price'
                      : value != null && double.tryParse(value) == null
                          ? 'ENter valid number not characters'
                          : null,
                  controller: _price,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Actual Price',
                    hintText: "500",
                    prefixIcon: Icon(Icons.money),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _collected,
                  validator: (value) =>
                      value != null && double.tryParse(value) == null
                          ? "Enter valid number not characters"
                          : null,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    fillColor: Colors.black12,
                    hintText: "100",
                    labelText: 'Collected Amount',
                    prefixIcon: Icon(Icons.money),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width, 50),
              backgroundColor: Theme.of(context).colorScheme.secondary),
          onPressed: widget.isUpdate ? _updateGoal : _addGoal,
          child: Text(
            widget.isUpdate ? 'Update Goal' : 'Create Goal',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
