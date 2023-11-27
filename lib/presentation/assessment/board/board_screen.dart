import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_bloc/presentation/assessment/board/bloc/board_bloc.dart';
import 'package:hrm_bloc/presentation/assessment/board/bloc/board_event.dart';
import 'package:hrm_bloc/presentation/assessment/board/bloc/board_state.dart';
import '../../../widgets/custom_loader.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key});

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  final BoardBloc _boardBloc = BoardBloc();
  @override
  void initState() {
    _boardBloc.add(BoardEventInitial());
    super.initState();
  }

  TextEditingController serchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _boardBloc.add(BoardEventInitial());
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Board'),
            actions: [
              IconButton(
                  onPressed: () {
                    _buildFilter(context);
                  },
                  icon: const Icon(Icons.filter_1_sharp))
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          floatingActionButton: _floatingButton(),
          body: BlocConsumer<BoardBloc, BoardState>(
            bloc: _boardBloc,
            builder: (context, state) {
              if (state is BoardStateLoading) {
                return const Center(
                  child: CustomLoader(),
                );
              }
              if (state is BoardStateLoaded) {
                var users = state.boards;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          onTap: () {},
                          title: Text(users[index]['title']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _boardBloc.add(BoardDeleteEvent(
                                      id: users[index]['id'].toString()));
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _boardBloc.add(
                                      BoardUpdateNavEvent(user: users[index]));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is BoardStateError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(state.message),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _boardBloc.add(BoardEventInitial());
                      },
                      child: const Text('Retry'),
                    )
                  ],
                );
              }
              return const SizedBox();
            },
            listener: (context, state) {
              if (state is BoardStateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }

              if (state is BoardStateAddNav) {
                Navigator.pushNamed(context, '/add_board');
              }
              if (state is BoardStateUpdateNav) {
                Navigator.pushNamed(context, '/add_board',
                    arguments: state.user);
              }
              if (state is BoardStateDelete) {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/board", (route) => false);
              }
            },
          )),
    );
  }

  Future<dynamic> _buildFilter(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _boardBloc.add(BoardEventInitial(search: serchController.text));
                serchController.clear();
              },
              child: const Text('Apply'),
            ),
          ],
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: serchController,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  FloatingActionButton _floatingButton() {
    return FloatingActionButton(
      onPressed: () {
        _boardBloc.add(BoardAddNavEvent());
      },
      child: const Icon(Icons.add),
    );
  }
}
