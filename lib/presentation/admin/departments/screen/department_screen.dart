import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/core/app_export.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/department/department_bloc.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/department/department_event.dart';
import 'package:hrm_bloc/presentation/admin/departments/blocs/department/department_state.dart';
import 'package:hrm_bloc/widgets/custom_loader.dart';
import '../widgets/department_tile_widget.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({super.key});

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  final DepartmentBloc _departmentBloc = DepartmentBloc();
  @override
  void initState() {
    _departmentBloc.add(DepartmentInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Department'),
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
          _departmentBloc.add(DepartmentInitialEvent());
        },
        child: BlocConsumer<DepartmentBloc, DepartmentState>(
            bloc: _departmentBloc,
            listener: (context, state) {
              print(state);
              if (state is DepartmentDeleteState) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Department Deleted Successfully"),
                  duration: Duration(seconds: 2),
                ));
                Navigator.pushNamedAndRemoveUntil(
                    context, "/department", (route) => false);
              }
            },
            builder: (context, state) {
              if (state is DepartmentLoadingState) {
                return const Center(child: CustomLoader());
              }
              if (state is DepartmentListSuccessState) {
                return ListView.builder(
                  itemCount: state.departmentList.length,
                  itemBuilder: (context, index) {
                    return DepartmentTileWidget(
                      departmentBloc: _departmentBloc,
                      state: state,
                      index: index,
                    );
                  },
                );
              }
              if (state is DepartmentListFailedState) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/addDepartment');
        },
      ),
    );
  }
}
