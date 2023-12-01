import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/core/app_export.dart';

import '../../../../widgets/custom_loader.dart';
import '../bloc/task/task_bloc.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskBloc _taskBloc = TaskBloc();
  @override
  void initState() {
    _taskBloc.add(TaskInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<TaskBloc, TaskState>(
          bloc: _taskBloc,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child:  CustomLoader());
            } else if (state is TaskLoaded) {
              return ListView.builder(
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.tasks[index].taskName!),
                     
                      trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  });
            } else if (state is TaskError) {
              return Center(
                child: Text(state.message),
              );
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTask');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
