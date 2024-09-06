// import 'dart:async';
// import 'dart:developer' as dart_tools show log;
// import 'package:itask/shared/components/extensions.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' show join;
//
// import '../models/task.dart';
// import 'db_exceptions.dart';
//
// class TasksDbService {
//   /// Singleton Pattern
//   static final TasksDbService _sharedInstance = TasksDbService._privateConstructor();
//
//   TasksDbService._privateConstructor() {
//     _activeTasksStreamController = StreamController<Set<Task>>.broadcast(onListen: () => _activeTasksStreamController.add(_activeTasks));
//     _doneTasksStreamController = StreamController<Set<Task>>.broadcast(onListen: () => _doneTasksStreamController.add(_doneTasks));
//     _archivedTasksStreamController = StreamController<Set<Task>>.broadcast(onListen: () => _archivedTasksStreamController.add(_archivedTasks));
//     _deletedTasksStreamController = StreamController<Set<Task>>.broadcast(onListen: () => _deletedTasksStreamController.add(_deletedTasks));
//   }
//
//   factory TasksDbService() => _sharedInstance;
//
//   Database? _tasksDatabase;
//
//   Set<Task> _tasks = {};
//
//   Set<Task> get _activeTasks => _tasks.where((element) => element.taskState == TaskState.active).toSet();
//
//   Set<Task> get _doneTasks => _tasks.where((element) => element.taskState == TaskState.done).toSet();
//
//   Set<Task> get _archivedTasks => _tasks.where((element) => element.taskState == TaskState.archived).toSet();
//
//   Set<Task> get _deletedTasks => _tasks.where((element) => element.taskState == TaskState.recentlyDeleted).toSet();
//
//   late final StreamController<Set<Task>> _activeTasksStreamController;
//   late final StreamController<Set<Task>> _doneTasksStreamController;
//   late final StreamController<Set<Task>> _archivedTasksStreamController;
//   late final StreamController<Set<Task>> _deletedTasksStreamController;
//
//   Stream<Set<Task>> get activeTasksStream => _activeTasksStreamController.stream;
//
//   Stream<Set<Task>> get doneTasksStream => _doneTasksStreamController.stream;
//
//   Stream<Set<Task>> get archivedTasksStream => _archivedTasksStreamController.stream;
//
//   Stream<Set<Task>> get deletedTasksStream => _deletedTasksStreamController.stream;
//
//   // event.takeWhile((value) => value.taskState == TaskState.active) == event.where((element) => element.taskState == TaskState.active));
//
//   Future<void> open() async {
//     final db = _tasksDatabase;
//     if (db != null && db.isOpen) {
//       await getAllTasks();
//       return;
//     }
//
//     try {
//       final appDocumentsDirectory = await getApplicationDocumentsDirectory();
//       final databasePath = join(appDocumentsDirectory.path, tasksDbFileName);
//       _tasksDatabase = await openDatabase(databasePath);
//
//       await _tasksDatabase!.execute(tasksTableCreationSqlString);
//       await _cacheTasks();
//     } on MissingPlatformDirectoryException {
//       throw UnableToGetDocumentsDirectory();
//     } catch (e) {
//       dart_tools.log("Error while opening Tasks Database : \n${e.toString()}");
//     }
//   }
//
//   void _checkOpenedDbOrThrow() {
//     if (_tasksDatabase == null) {
//       throw DatabaseIsNotOpen();
//     }
//   }
//
//   Future<void> _cacheTasks() async {
//     _checkOpenedDbOrThrow();
//     final tasksRows = await _tasksDatabase!.query(tasksTable);
//     _tasks = tasksRows.map((e) => Task.fromDb(e)).toSet();
//     _activeTasksStreamController.add(_activeTasks);
//     _doneTasksStreamController.add(_doneTasks);
//     _archivedTasksStreamController.add(_archivedTasks);
//     _doneTasksStreamController.add(_deletedTasks);
//   }
//
//   Future<Set<Task>> getAllTasks() async {
//     _checkOpenedDbOrThrow();
//     final tasksRows = await _tasksDatabase!.query(tasksTable);
//     return tasksRows.map((e) => Task.fromDb(e)).toSet();
//   }
//
//   Future<Task> _checkExistenceOfTask({required int taskId}) async {
//     final checkedTask = await getTask(taskId: taskId);
//
//     if (checkedTask == null) {
//       throw CouldNotFindTask();
//     } else {
//       return checkedTask;
//     }
//   }
//
//   Future<Task?> getTask({required int taskId}) async {
//     _checkOpenedDbOrThrow();
//     final results = await _tasksDatabase!.query(tasksTable, where: "${DbColumns.id.string} = $taskId");
//     if (results.isEmpty) {
//       return null;
//     } else {
//       return Task.fromDb(results.first);
//     }
//   }
//
//   Future<Task> insertTask({required String title, required String dateTime}) async {
//     _checkOpenedDbOrThrow();
//     final taskId = await _tasksDatabase!.insert(tasksTable, {
//       DbColumns.title.string: title,
//       DbColumns.dateTime.string: dateTime,
//       DbColumns.taskState.string: TaskState.active.value,
//     });
//
//     final newTask = await getTask(taskId: taskId);
//     _tasks.add(newTask!);
//     _activeTasksStreamController.add(_activeTasks);
//     return newTask;
//   }
//
//   Future<void> updateActiveTask({required int oldTaskId, required String newTitle, required String newDateTime}) async {
//     _checkOpenedDbOrThrow();
//     await _checkExistenceOfTask(taskId: oldTaskId);
//     final updatedCount = await _tasksDatabase!.update(
//       tasksTable,
//       {DbColumns.title.string: newTitle, DbColumns.dateTime.string: newDateTime},
//       where: "${DbColumns.id.string} = $oldTaskId",
//     );
//     if (updatedCount == 0) {
//       throw CouldNotUpdateTask();
//     } else {
//       _tasks.removeWhere((element) => oldTaskId == element.id);
//       _tasks.add(await getTask(taskId: oldTaskId) as Task); // as id did not change
//       _activeTasksStreamController.add(_tasks);
//     }
//   }
//
//   Future<void> updateState({required int taskId, required TaskState newState}) async {
//     _checkOpenedDbOrThrow();
//     await _checkExistenceOfTask(taskId: taskId);
//
//     final updatedCount = await _tasksDatabase!.update(
//       tasksTable,
//       {DbColumns.taskState.string: newState.value},
//       where: "${DbColumns.id.string} = $taskId",
//     );
//     if (updatedCount == 0) {
//       throw CouldNotUpdateTask();
//     } else {
//       _tasks.removeWhere((element) => element.id == taskId);
//       _tasks.add(await getTask(taskId: taskId) as Task); // as id did not change
//       _updateAll();
//     }
//   }
//
//   void _updateAll() {
//     _activeTasksStreamController.add(_activeTasks);
//     _doneTasksStreamController.add(_doneTasks);
//     _archivedTasksStreamController.add(_archivedTasks);
//     _deletedTasksStreamController.add(_deletedTasks);
//   }
//
//   Future<void> permanentlyDelete({required int taskId}) async {
//     _checkOpenedDbOrThrow();
//     _checkExistenceOfTask(taskId: taskId);
//     final numberOfTasksDeleted = await _tasksDatabase!.delete(tasksTable, where: "${DbColumns.id.string} = $taskId");
//
//     if (numberOfTasksDeleted == 0) {
//       throw CouldNotDeleteTask();
//     } else {
//       _tasks.removeWhere((task) => task.id == taskId);
//       _updateAll();
//     }
//   }
//
//   Future<void> close() async {
//     if (_tasksDatabase == null) {
//       throw DatabaseIsNotOpen();
//     } else {
//       await _tasksDatabase!.close();
//       _tasksDatabase = null;
//     }
//   }
// }
//
// const tasksTableCreationSqlString = ''' CREATE TABLE IF NOT EXISTS "#tasksTable" (
//           "{DbColumns.id.string}"	INTEGER NOT NULL,
//           "{DbColumns.title.string}"	TEXT NOT NULL,
//           "{DbColumns.dateTime.string}"	TEXT NOT NULL,
//           "{DbColumns.taskState.string}"	TEXT NOT NULL,
//           PRIMARY KEY("{DbColumns.id.string}" AUTOINCREMENT)
//         );''';
