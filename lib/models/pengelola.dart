import 'package:drift/drift.dart';

@DataClassName('Pengelolaan')
class Pengelola extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get uang => integer()();
  IntColumn get type => integer()();
  TextColumn get jenis => text()();
  TextColumn get catatan => text()();
  DateTimeColumn get transaksidate => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}
