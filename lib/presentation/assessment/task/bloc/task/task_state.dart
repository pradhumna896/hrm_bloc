part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskLoaded extends TaskState {
  final List<dynamic> tasks;
  TaskLoaded(this.tasks);
}

final class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}


