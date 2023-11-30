import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/department/department_bloc.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/department/department_event.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/department/department_state.dart';
import 'package:hrm_bloc/presentation/admin/projects/blocs/project/project_bloc.dart';
import 'package:hrm_bloc/presentation/admin/projects/blocs/project/project_event.dart';
import 'package:hrm_bloc/presentation/admin/projects/blocs/project/project_state.dart';
import 'package:hrm_bloc/presentation/admin/projects/widgets/project_tile_widget.dart';
import 'package:hrm_bloc/widgets/custom_loader.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final ProjectBloc _projectBloc = ProjectBloc();
  @override
  void initState() {
    _projectBloc.add(ProjectInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _projectBloc.add(ProjectInitialEvent());
        },
        child: BlocConsumer<ProjectBloc, ProjectState>(
            bloc: _projectBloc,
            listener: (context, state) {
              print(state);
              if (state is ProjectDeleteState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Project Deleted Successfully"),
                  duration: Duration(seconds: 2),
                ));
                Navigator.pushNamedAndRemoveUntil(
                    context, "/project", (route) => false);
              }
            },
            builder: (context, state) {
              if (state is ProjectLoadingState) {
                return const Center(child: CustomLoader());
              }
              if (state is ProjectListSuccessState) {
                return ListView.builder(
                  itemCount: state.ProjectList.length,
                  itemBuilder: (context, index) {
                    return ProjectTileWidget(
                      projectBloc: _projectBloc,
                      state: state,
                      index: index,
                    );
                  },
                );
              }
              if (state is ProjectListFailedState) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addProject');
        },
      ),
    );
  }
}
