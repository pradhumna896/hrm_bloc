import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_bloc/presentation/assessment/board/bloc/board_bloc.dart';
import 'package:hrm_bloc/presentation/assessment/board/bloc/board_event.dart';
import 'package:hrm_bloc/presentation/assessment/board/bloc/board_state.dart';
import 'package:hrm_bloc/widgets/custom_drodown.dart';
import 'package:hrm_bloc/widgets/custom_loader.dart';

class AddBoardScreen extends StatefulWidget {
  const AddBoardScreen({super.key});

  @override
  State<AddBoardScreen> createState() => _AddBoardScreenState();
}

class _AddBoardScreenState extends State<AddBoardScreen> {
  final BoardBloc _boardBloc = BoardBloc();
  TextEditingController titleController = TextEditingController();
  String? projectId;

  @override
  void initState() {
    _boardBloc.add(ProjectDropDownEvent());

    super.initState();
  }

  var data;
  getData(context) {
    data = ModalRoute.of(context)!.settings.arguments as Map;
    titleController.text = data['title'];
    projectId = data['id'].toString();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) getData(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Board'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/board', (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<BoardBloc, BoardState>(
          bloc: _boardBloc,
          listener: (context, state) {
            if (state is BoardStateAdd) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/board', (route) => false);
            }
            if (state is BoardStateUpdate) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/board', (route) => false);
            }
            if(state is BoardStateError){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(children: [
                     SizedBox(
                      height: 20.h,
                    ),
                    CustomDropdown(
                      labelText: "projects",
                      selectedItem:
                          data != null ? data['project_id'].toString() : null,
                      listName: state is BoardStateProjectDropDown
                          ? state.projects
                              .map((e) => e['project_name'].toString())
                              .toList()
                          : [],
                      onChng: (value) {
                        for (var ele in state is BoardStateProjectDropDown
                            ? state.projects
                            : []) {
                          if (ele['project_name'] == value) {
                            projectId = ele['id'].toString();
                          }
                        }
                      },
                    ),
                     SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                     SizedBox(
                      height: 20.h,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (data != null) {
                            _boardBloc.add(BoardUpdateEvent(
                                id: data['id'].toString(),
                                projectId: projectId.toString(),
                                title: titleController.text));
                          } else {
                            _boardBloc.add(BoardAddEvent(
                                projectId: projectId,
                                title: titleController.text));
                          }
                        },
                        child: const Text("Submit"))
                  ]),
                  if (state is BoardStateLoading)
                    const Center(
                      child: CustomLoader(),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
