import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:vasa/models/akuns.dart';
import 'package:vasa/models/rekenings.dart';
import 'package:vasa/models/pengelola.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Rekenings, Akuns, Pengelola])
class AppDatabase extends _$AppDatabase {
  AppDatabase(NativeDatabase nativeDatabase) : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
      );

  Future<List<Pengelolaan>> getTransactionsByTypeAndDate(int type, DateTime selectedDate) {
    return (select(pengelola)
          ..where((t) => t.type.equals(type) & t.transaksidate.equals(selectedDate)))
        .get();
  }

  Future<int> getTotalByTypeAndDate(int type, DateTime selectedDate) async {
    final query = select(pengelola)
      ..where((t) => t.type.equals(type) & t.transaksidate.equals(selectedDate));
    
    final List<Pengelolaan> result = await query.get();
    int total = 0;
    for (var transaction in result) {
      total += transaction.uang;
    }
    return total;
  }

  Future<int> getTotalByTypeAndYear(int type, int year) async {
    final query = select(pengelola)
      ..where((t) => t.type.equals(type) & t.transaksidate.year.equals(year));
    final List<Pengelolaan> result = await query.get();
    int total = 0;
    for (var transaction in result) {
      total += transaction.uang;
    }
    return total;
  }

  Future<int> getTotalByTypeAndMonth(int type, int year, int month) async {
    final query = select(pengelola)
      ..where((t) =>
          t.type.equals(type) & 
          t.transaksidate.year.equals(year) & 
          t.transaksidate.month.equals(month));
    final List<Pengelolaan> result = await query.get();
    int total = 0;
    for (var transaction in result) {
      total += transaction.uang;
    }
    return total;
  }

  Future<List<Pengelolaan>> getAllTransactions() {
    return select(pengelola).get();
  }

  Future<int> insertTransaction(PengelolaCompanion entry) {
    return into(pengelola).insert(entry);
  }

  Future updateTransaction(Pengelolaan entry) {
    return update(pengelola).replace(entry);
  }

  Future<Pengelolaan> getTransactionById(int id) {
    return (select(pengelola)..where((t) => t.id.equals(id))).getSingle();
  }

  Future deleteTransaction(int id) {
    return (delete(pengelola)..where((t) => t.id.equals(id))).go();
  }

  Future<List<Pengelolaan>> getPengelolaanByMonth(DateTime startDate, DateTime endDate) {
    return (select(pengelola)
          ..where((tbl) => tbl.transaksidate.isBetweenValues(startDate, endDate))
          ..orderBy([
            (t) => OrderingTerm(expression: t.transaksidate, mode: OrderingMode.asc),
          ]))
        .get();
  }
    Future<List<Rekening>> getRekeningByjenis(String jenis) {
    return (select(rekenings)..where((t) => t.jenis.equals(jenis))).get();
  }
  Future<List<Rekening>> getAllRekenings() {
    return select(rekenings).get();
  }
    Future deleteRekening(int id) {
    return (delete(rekenings)..where((t) => t.id.equals(id))).go();
  }
  Future<int> getTotalRekening(String jenis) async {
    final query = select(rekenings)
      ..where((t) =>
          t.jenis.equals(jenis));
    final List<Rekening> result = await query.get();
    int total = 0;
    for (var rekening in result) {
      total += rekening.uang;
    }
    return total;
  }
 Future<int> insertRekening(RekeningsCompanion entry) {
    return into(rekenings).insert(entry);
  }
  Future updateRekening(Rekening entry) {
    return update(rekenings).replace(entry);
  }
  // wan live sahre
  Future<void> deleteAllPengelola() {
  return delete(pengelola).go();
  }

  Future<void> deleteAllRekenings() {
  return delete(rekenings).go();
  }

}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
