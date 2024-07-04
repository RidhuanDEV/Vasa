import 'package:drift/drift.dart';


class Akuns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get imagePath => text()();
  TextColumn get nama => text()();
}