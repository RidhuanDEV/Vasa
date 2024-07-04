import 'package:drift/drift.dart';

class Rekenings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get namaRekening => text()();
  IntColumn get uang => integer()();
  TextColumn get jenis => text()();
  TextColumn get catatan => text()();
}

