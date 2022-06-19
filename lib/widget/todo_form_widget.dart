import 'package:flutter/material.dart';

class TodoFormWidget extends StatefulWidget {
  final String title;
  final String timer;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;
  final ValueChanged<String> onChangedTimer;

  const TodoFormWidget({
    Key? key,
    this.title = '',
    this.timer = '' ,
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedTimer,
    required this.onChangedDescription,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  State<TodoFormWidget> createState() => _TodoFormWidgetState();
}

class _TodoFormWidgetState extends State<TodoFormWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(height: 8),
          buildClock(),
          const SizedBox(height: 8),
          buildDescription(),
          const SizedBox(height: 16),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: widget.title,
        onChanged: widget.onChangedTitle,
        validator: (title) {
          if (title!.isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 3,
        initialValue: widget.description,
        onChanged: widget.onChangedDescription,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Description',
        ),
      );

  Widget buildClock() => TextFormField(
    keyboardType: TextInputType.number,
        maxLines: 1,
        initialValue: widget.timer,
        onChanged: widget.onChangedTimer,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Timer',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: widget.onSavedTodo,
          child: const Text('Save'),
        ),
      );
}
