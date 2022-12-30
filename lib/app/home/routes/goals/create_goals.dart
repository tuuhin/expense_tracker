import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../context/context.dart';
import '../../../widgets/widgets.dart';
import '../../../../domain/models/models.dart';

class CreateGoals extends StatefulWidget {
  final GoalsModel? goal;
  final bool isUpdate;
  const CreateGoals({super.key, this.goal, this.isUpdate = false})
      : assert(isUpdate ? goal != null : true);

  @override
  State<CreateGoals> createState() => _CreateGoalsState();
}

class _CreateGoalsState extends State<CreateGoals> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _price;
  late TextEditingController _collected;

  File? _file;
  String? _imageURL;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _pickImage(ImageSource source) async {
    try {
      XFile? file =
          await ImagePicker().pickImage(source: source, imageQuality: 50);
      if (file == null) return;
      setState(() => _file = File(file.path));
    } on PlatformException {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
            const SnackBar(content: Text("Platform exception occured")));
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
  }

  void _clearImage() =>
      setState(() => _imageURL != null ? _imageURL = null : _file = null);

  void _imagePickerSheet() async => await showModalBottomSheet(
        context: context,
        builder: (context) => ImagePickerModal(
          camera: () => _pickImage(ImageSource.camera),
          gallery: () => _pickImage(ImageSource.gallery),
          clear: _clearImage,
        ),
      );

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(
      text: widget.isUpdate ? widget.goal?.title : null,
    );
    _desc = TextEditingController(
      text: widget.isUpdate ? widget.goal?.desc : null,
    );
    _price = TextEditingController(
      text: widget.isUpdate ? widget.goal?.price.toString() : null,
    );
    _collected = TextEditingController(
      text: widget.isUpdate ? widget.goal?.collected.toString() : null,
    );
    _imageURL = widget.isUpdate ? widget.goal?.imageUrl : null;
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

    context.read<GoalsBloc>().updateGoal(
          widget.goal!.copyWith(
            title: _title.text,
            desc: _desc.text.isEmpty ? null : _desc.text,
            collected: double.parse(_collected.text),
            price: double.parse(_price.text),
            imageUrl: _file?.path,
          ),
        );
    Navigator.of(context).popUntil((route) => route.settings.name == '/goals');
  }

  void _addGoal() {
    if (!_formKey.currentState!.validate()) return;
    context.read<GoalsBloc>().createGoal(
          CreateGoalModel(
            title: _title.text,
            desc: _desc.text.isEmpty ? null : _desc.text,
            collected: double.parse(_collected.text),
            price: double.parse(_price.text),
            imageUrl: _file?.path,
          ),
        );
    Navigator.of(context).popUntil((route) => route.settings.name == '/goals');
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
                    onTap: _imagePickerSheet,
                    child: GoalImagePicker(imageURL: _imageURL, file: _file),
                  ),
                ),
                const Divider(),
                CreateGoalForm(
                  title: _title,
                  desc: _desc,
                  price: _price,
                  collected: _collected,
                )
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
