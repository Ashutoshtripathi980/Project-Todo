import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import '../model/todo.dart';
import '../page/edit_todo_page.dart';
import '../provider/todos.dart';
import '../utils.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;
  final bool completed;
  const TodoWidget({
    required this.todo,
    Key? key,
    required this.completed,
  }) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Slidable(
            actionPane: const SlidableDrawerActionPane(),
            key: Key(widget.todo.id.toString()),
            actions: [
              IconSlideAction(
                color: Colors.green,
                onTap: () => editTodo(context, widget.todo),
                caption: 'Edit',
                icon: Icons.edit,
              )
            ],
            secondaryActions: [
              IconSlideAction(
                color: Colors.red,
                caption: 'Delete',
                onTap: () => deleteTodo(context, widget.todo),
                icon: Icons.delete,
              )
            ],
            child: buildTodo(context),
          ),
        ),
      );

  Widget buildTodo(BuildContext context) => GestureDetector(
        onTap: () => editTodo(context, widget.todo),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Column(
                children: [
                  widget.completed == true
                      ? SizedBox(
                          height: 50,
                          width: 100,
                          child: SizedBox.expand(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                SlideCountdown(
                                    duration: Duration(
                                        minutes: int.parse(widget.todo.timer)),
                                    slideDirection: SlideDirection.up,
                                    fade: true,
                                    onDone: () {
                                      final provider =
                                          Provider.of<TodosProvider>(context,
                                              listen: false);
                                      final isDone = provider
                                          .toggleTodoStatus(widget.todo);
                                      Utils.showSnackBar(
                                        context,
                                        isDone
                                            ? 'Task completed'
                                            : 'Task marked incomplete',
                                      );
                                      setState(() {});
                                    },
                                    icon: const Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Icons.alarm,
                                          color: Colors.white,
                                          size: 20,
                                        )))
                              ])),
                        )
                      : Container(),
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    checkColor: Colors.white,
                    value: widget.todo.isDone,
                    onChanged: (_) {
                      final provider =
                          Provider.of<TodosProvider>(context, listen: false);
                      final isDone = provider.toggleTodoStatus(widget.todo);
                      Utils.showSnackBar(
                        context,
                        isDone ? 'Task completed' : 'Task marked incomplete',
                      );
                    },
                  )
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.todo.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    if (widget.todo.description.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          widget.todo.description,
                          style: const TextStyle(fontSize: 20, height: 1.5),
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}
