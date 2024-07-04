// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RekeningsTable extends Rekenings
    with TableInfo<$RekeningsTable, Rekening> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RekeningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _namaRekeningMeta =
      const VerificationMeta('namaRekening');
  @override
  late final GeneratedColumn<String> namaRekening = GeneratedColumn<String>(
      'nama_rekening', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uangMeta = const VerificationMeta('uang');
  @override
  late final GeneratedColumn<int> uang = GeneratedColumn<int>(
      'uang', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _jenisMeta = const VerificationMeta('jenis');
  @override
  late final GeneratedColumn<String> jenis = GeneratedColumn<String>(
      'jenis', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _catatanMeta =
      const VerificationMeta('catatan');
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
      'catatan', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, namaRekening, uang, jenis, catatan];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rekenings';
  @override
  VerificationContext validateIntegrity(Insertable<Rekening> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_rekening')) {
      context.handle(
          _namaRekeningMeta,
          namaRekening.isAcceptableOrUnknown(
              data['nama_rekening']!, _namaRekeningMeta));
    } else if (isInserting) {
      context.missing(_namaRekeningMeta);
    }
    if (data.containsKey('uang')) {
      context.handle(
          _uangMeta, uang.isAcceptableOrUnknown(data['uang']!, _uangMeta));
    } else if (isInserting) {
      context.missing(_uangMeta);
    }
    if (data.containsKey('jenis')) {
      context.handle(
          _jenisMeta, jenis.isAcceptableOrUnknown(data['jenis']!, _jenisMeta));
    } else if (isInserting) {
      context.missing(_jenisMeta);
    }
    if (data.containsKey('catatan')) {
      context.handle(_catatanMeta,
          catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta));
    } else if (isInserting) {
      context.missing(_catatanMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Rekening map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Rekening(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      namaRekening: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama_rekening'])!,
      uang: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}uang'])!,
      jenis: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}jenis'])!,
      catatan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}catatan'])!,
    );
  }

  @override
  $RekeningsTable createAlias(String alias) {
    return $RekeningsTable(attachedDatabase, alias);
  }
}

class Rekening extends DataClass implements Insertable<Rekening> {
  final int id;
  final String namaRekening;
  final int uang;
  final String jenis;
  final String catatan;
  const Rekening(
      {required this.id,
      required this.namaRekening,
      required this.uang,
      required this.jenis,
      required this.catatan});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_rekening'] = Variable<String>(namaRekening);
    map['uang'] = Variable<int>(uang);
    map['jenis'] = Variable<String>(jenis);
    map['catatan'] = Variable<String>(catatan);
    return map;
  }

  RekeningsCompanion toCompanion(bool nullToAbsent) {
    return RekeningsCompanion(
      id: Value(id),
      namaRekening: Value(namaRekening),
      uang: Value(uang),
      jenis: Value(jenis),
      catatan: Value(catatan),
    );
  }

  factory Rekening.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Rekening(
      id: serializer.fromJson<int>(json['id']),
      namaRekening: serializer.fromJson<String>(json['namaRekening']),
      uang: serializer.fromJson<int>(json['uang']),
      jenis: serializer.fromJson<String>(json['jenis']),
      catatan: serializer.fromJson<String>(json['catatan']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaRekening': serializer.toJson<String>(namaRekening),
      'uang': serializer.toJson<int>(uang),
      'jenis': serializer.toJson<String>(jenis),
      'catatan': serializer.toJson<String>(catatan),
    };
  }

  Rekening copyWith(
          {int? id,
          String? namaRekening,
          int? uang,
          String? jenis,
          String? catatan}) =>
      Rekening(
        id: id ?? this.id,
        namaRekening: namaRekening ?? this.namaRekening,
        uang: uang ?? this.uang,
        jenis: jenis ?? this.jenis,
        catatan: catatan ?? this.catatan,
      );
  @override
  String toString() {
    return (StringBuffer('Rekening(')
          ..write('id: $id, ')
          ..write('namaRekening: $namaRekening, ')
          ..write('uang: $uang, ')
          ..write('jenis: $jenis, ')
          ..write('catatan: $catatan')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, namaRekening, uang, jenis, catatan);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rekening &&
          other.id == this.id &&
          other.namaRekening == this.namaRekening &&
          other.uang == this.uang &&
          other.jenis == this.jenis &&
          other.catatan == this.catatan);
}

class RekeningsCompanion extends UpdateCompanion<Rekening> {
  final Value<int> id;
  final Value<String> namaRekening;
  final Value<int> uang;
  final Value<String> jenis;
  final Value<String> catatan;
  const RekeningsCompanion({
    this.id = const Value.absent(),
    this.namaRekening = const Value.absent(),
    this.uang = const Value.absent(),
    this.jenis = const Value.absent(),
    this.catatan = const Value.absent(),
  });
  RekeningsCompanion.insert({
    this.id = const Value.absent(),
    required String namaRekening,
    required int uang,
    required String jenis,
    required String catatan,
  })  : namaRekening = Value(namaRekening),
        uang = Value(uang),
        jenis = Value(jenis),
        catatan = Value(catatan);
  static Insertable<Rekening> custom({
    Expression<int>? id,
    Expression<String>? namaRekening,
    Expression<int>? uang,
    Expression<String>? jenis,
    Expression<String>? catatan,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaRekening != null) 'nama_rekening': namaRekening,
      if (uang != null) 'uang': uang,
      if (jenis != null) 'jenis': jenis,
      if (catatan != null) 'catatan': catatan,
    });
  }

  RekeningsCompanion copyWith(
      {Value<int>? id,
      Value<String>? namaRekening,
      Value<int>? uang,
      Value<String>? jenis,
      Value<String>? catatan}) {
    return RekeningsCompanion(
      id: id ?? this.id,
      namaRekening: namaRekening ?? this.namaRekening,
      uang: uang ?? this.uang,
      jenis: jenis ?? this.jenis,
      catatan: catatan ?? this.catatan,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaRekening.present) {
      map['nama_rekening'] = Variable<String>(namaRekening.value);
    }
    if (uang.present) {
      map['uang'] = Variable<int>(uang.value);
    }
    if (jenis.present) {
      map['jenis'] = Variable<String>(jenis.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RekeningsCompanion(')
          ..write('id: $id, ')
          ..write('namaRekening: $namaRekening, ')
          ..write('uang: $uang, ')
          ..write('jenis: $jenis, ')
          ..write('catatan: $catatan')
          ..write(')'))
        .toString();
  }
}

class $AkunsTable extends Akuns with TableInfo<$AkunsTable, Akun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AkunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
      'nama', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, imagePath, nama];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'akuns';
  @override
  VerificationContext validateIntegrity(Insertable<Akun> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
          _namaMeta, nama.isAcceptableOrUnknown(data['nama']!, _namaMeta));
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Akun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Akun(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path'])!,
      nama: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama'])!,
    );
  }

  @override
  $AkunsTable createAlias(String alias) {
    return $AkunsTable(attachedDatabase, alias);
  }
}

class Akun extends DataClass implements Insertable<Akun> {
  final int id;
  final String imagePath;
  final String nama;
  const Akun({required this.id, required this.imagePath, required this.nama});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['image_path'] = Variable<String>(imagePath);
    map['nama'] = Variable<String>(nama);
    return map;
  }

  AkunsCompanion toCompanion(bool nullToAbsent) {
    return AkunsCompanion(
      id: Value(id),
      imagePath: Value(imagePath),
      nama: Value(nama),
    );
  }

  factory Akun.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Akun(
      id: serializer.fromJson<int>(json['id']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      nama: serializer.fromJson<String>(json['nama']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'imagePath': serializer.toJson<String>(imagePath),
      'nama': serializer.toJson<String>(nama),
    };
  }

  Akun copyWith({int? id, String? imagePath, String? nama}) => Akun(
        id: id ?? this.id,
        imagePath: imagePath ?? this.imagePath,
        nama: nama ?? this.nama,
      );
  @override
  String toString() {
    return (StringBuffer('Akun(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('nama: $nama')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imagePath, nama);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Akun &&
          other.id == this.id &&
          other.imagePath == this.imagePath &&
          other.nama == this.nama);
}

class AkunsCompanion extends UpdateCompanion<Akun> {
  final Value<int> id;
  final Value<String> imagePath;
  final Value<String> nama;
  const AkunsCompanion({
    this.id = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.nama = const Value.absent(),
  });
  AkunsCompanion.insert({
    this.id = const Value.absent(),
    required String imagePath,
    required String nama,
  })  : imagePath = Value(imagePath),
        nama = Value(nama);
  static Insertable<Akun> custom({
    Expression<int>? id,
    Expression<String>? imagePath,
    Expression<String>? nama,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imagePath != null) 'image_path': imagePath,
      if (nama != null) 'nama': nama,
    });
  }

  AkunsCompanion copyWith(
      {Value<int>? id, Value<String>? imagePath, Value<String>? nama}) {
    return AkunsCompanion(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      nama: nama ?? this.nama,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AkunsCompanion(')
          ..write('id: $id, ')
          ..write('imagePath: $imagePath, ')
          ..write('nama: $nama')
          ..write(')'))
        .toString();
  }
}

class $PengelolaTable extends Pengelola
    with TableInfo<$PengelolaTable, Pengelolaan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PengelolaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uangMeta = const VerificationMeta('uang');
  @override
  late final GeneratedColumn<int> uang = GeneratedColumn<int>(
      'uang', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
      'type', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _jenisMeta = const VerificationMeta('jenis');
  @override
  late final GeneratedColumn<String> jenis = GeneratedColumn<String>(
      'jenis', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _catatanMeta =
      const VerificationMeta('catatan');
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
      'catatan', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _transaksidateMeta =
      const VerificationMeta('transaksidate');
  @override
  late final GeneratedColumn<DateTime> transaksidate =
      GeneratedColumn<DateTime>('transaksidate', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uang,
        type,
        jenis,
        catatan,
        transaksidate,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pengelola';

  get date => null;
  @override
  VerificationContext validateIntegrity(Insertable<Pengelolaan> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uang')) {
      context.handle(
          _uangMeta, uang.isAcceptableOrUnknown(data['uang']!, _uangMeta));
    } else if (isInserting) {
      context.missing(_uangMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('jenis')) {
      context.handle(
          _jenisMeta, jenis.isAcceptableOrUnknown(data['jenis']!, _jenisMeta));
    } else if (isInserting) {
      context.missing(_jenisMeta);
    }
    if (data.containsKey('catatan')) {
      context.handle(_catatanMeta,
          catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta));
    } else if (isInserting) {
      context.missing(_catatanMeta);
    }
    if (data.containsKey('transaksidate')) {
      context.handle(
          _transaksidateMeta,
          transaksidate.isAcceptableOrUnknown(
              data['transaksidate']!, _transaksidateMeta));
    } else if (isInserting) {
      context.missing(_transaksidateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pengelolaan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pengelolaan(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uang: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}uang'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      jenis: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}jenis'])!,
      catatan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}catatan'])!,
      transaksidate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}transaksidate'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $PengelolaTable createAlias(String alias) {
    return $PengelolaTable(attachedDatabase, alias);
  }
}

class Pengelolaan extends DataClass implements Insertable<Pengelolaan> {
  final int id;
  final int uang;
  final int type;
  final String jenis;
  final String catatan;
  final DateTime transaksidate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const Pengelolaan(
      {required this.id,
      required this.uang,
      required this.type,
      required this.jenis,
      required this.catatan,
      required this.transaksidate,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uang'] = Variable<int>(uang);
    map['type'] = Variable<int>(type);
    map['jenis'] = Variable<String>(jenis);
    map['catatan'] = Variable<String>(catatan);
    map['transaksidate'] = Variable<DateTime>(transaksidate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  PengelolaCompanion toCompanion(bool nullToAbsent) {
    return PengelolaCompanion(
      id: Value(id),
      uang: Value(uang),
      type: Value(type),
      jenis: Value(jenis),
      catatan: Value(catatan),
      transaksidate: Value(transaksidate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Pengelolaan.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pengelolaan(
      id: serializer.fromJson<int>(json['id']),
      uang: serializer.fromJson<int>(json['uang']),
      type: serializer.fromJson<int>(json['type']),
      jenis: serializer.fromJson<String>(json['jenis']),
      catatan: serializer.fromJson<String>(json['catatan']),
      transaksidate: serializer.fromJson<DateTime>(json['transaksidate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uang': serializer.toJson<int>(uang),
      'type': serializer.toJson<int>(type),
      'jenis': serializer.toJson<String>(jenis),
      'catatan': serializer.toJson<String>(catatan),
      'transaksidate': serializer.toJson<DateTime>(transaksidate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Pengelolaan copyWith(
          {int? id,
          int? uang,
          int? type,
          String? jenis,
          String? catatan,
          DateTime? transaksidate,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      Pengelolaan(
        id: id ?? this.id,
        uang: uang ?? this.uang,
        type: type ?? this.type,
        jenis: jenis ?? this.jenis,
        catatan: catatan ?? this.catatan,
        transaksidate: transaksidate ?? this.transaksidate,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Pengelolaan(')
          ..write('id: $id, ')
          ..write('uang: $uang, ')
          ..write('type: $type, ')
          ..write('jenis: $jenis, ')
          ..write('catatan: $catatan, ')
          ..write('transaksidate: $transaksidate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uang, type, jenis, catatan, transaksidate,
      createdAt, updatedAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pengelolaan &&
          other.id == this.id &&
          other.uang == this.uang &&
          other.type == this.type &&
          other.jenis == this.jenis &&
          other.catatan == this.catatan &&
          other.transaksidate == this.transaksidate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class PengelolaCompanion extends UpdateCompanion<Pengelolaan> {
  final Value<int> id;
  final Value<int> uang;
  final Value<int> type;
  final Value<String> jenis;
  final Value<String> catatan;
  final Value<DateTime> transaksidate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const PengelolaCompanion({
    this.id = const Value.absent(),
    this.uang = const Value.absent(),
    this.type = const Value.absent(),
    this.jenis = const Value.absent(),
    this.catatan = const Value.absent(),
    this.transaksidate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  PengelolaCompanion.insert({
    this.id = const Value.absent(),
    required int uang,
    required int type,
    required String jenis,
    required String catatan,
    required DateTime transaksidate,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
  })  : uang = Value(uang),
        type = Value(type),
        jenis = Value(jenis),
        catatan = Value(catatan),
        transaksidate = Value(transaksidate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Pengelolaan> custom({
    Expression<int>? id,
    Expression<int>? uang,
    Expression<int>? type,
    Expression<String>? jenis,
    Expression<String>? catatan,
    Expression<DateTime>? transaksidate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uang != null) 'uang': uang,
      if (type != null) 'type': type,
      if (jenis != null) 'jenis': jenis,
      if (catatan != null) 'catatan': catatan,
      if (transaksidate != null) 'transaksidate': transaksidate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  PengelolaCompanion copyWith(
      {Value<int>? id,
      Value<int>? uang,
      Value<int>? type,
      Value<String>? jenis,
      Value<String>? catatan,
      Value<DateTime>? transaksidate,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return PengelolaCompanion(
      id: id ?? this.id,
      uang: uang ?? this.uang,
      type: type ?? this.type,
      jenis: jenis ?? this.jenis,
      catatan: catatan ?? this.catatan,
      transaksidate: transaksidate ?? this.transaksidate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uang.present) {
      map['uang'] = Variable<int>(uang.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (jenis.present) {
      map['jenis'] = Variable<String>(jenis.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    if (transaksidate.present) {
      map['transaksidate'] = Variable<DateTime>(transaksidate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PengelolaCompanion(')
          ..write('id: $id, ')
          ..write('uang: $uang, ')
          ..write('type: $type, ')
          ..write('jenis: $jenis, ')
          ..write('catatan: $catatan, ')
          ..write('transaksidate: $transaksidate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $RekeningsTable rekenings = $RekeningsTable(this);
  late final $AkunsTable akuns = $AkunsTable(this);
  late final $PengelolaTable pengelola = $PengelolaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [rekenings, akuns, pengelola];
}

typedef $$RekeningsTableInsertCompanionBuilder = RekeningsCompanion Function({
  Value<int> id,
  required String namaRekening,
  required int uang,
  required String jenis,
  required String catatan,
});
typedef $$RekeningsTableUpdateCompanionBuilder = RekeningsCompanion Function({
  Value<int> id,
  Value<String> namaRekening,
  Value<int> uang,
  Value<String> jenis,
  Value<String> catatan,
});

class $$RekeningsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RekeningsTable,
    Rekening,
    $$RekeningsTableFilterComposer,
    $$RekeningsTableOrderingComposer,
    $$RekeningsTableProcessedTableManager,
    $$RekeningsTableInsertCompanionBuilder,
    $$RekeningsTableUpdateCompanionBuilder> {
  $$RekeningsTableTableManager(_$AppDatabase db, $RekeningsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$RekeningsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$RekeningsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$RekeningsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> namaRekening = const Value.absent(),
            Value<int> uang = const Value.absent(),
            Value<String> jenis = const Value.absent(),
            Value<String> catatan = const Value.absent(),
          }) =>
              RekeningsCompanion(
            id: id,
            namaRekening: namaRekening,
            uang: uang,
            jenis: jenis,
            catatan: catatan,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String namaRekening,
            required int uang,
            required String jenis,
            required String catatan,
          }) =>
              RekeningsCompanion.insert(
            id: id,
            namaRekening: namaRekening,
            uang: uang,
            jenis: jenis,
            catatan: catatan,
          ),
        ));
}

class $$RekeningsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $RekeningsTable,
    Rekening,
    $$RekeningsTableFilterComposer,
    $$RekeningsTableOrderingComposer,
    $$RekeningsTableProcessedTableManager,
    $$RekeningsTableInsertCompanionBuilder,
    $$RekeningsTableUpdateCompanionBuilder> {
  $$RekeningsTableProcessedTableManager(super.$state);
}

class $$RekeningsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $RekeningsTable> {
  $$RekeningsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get namaRekening => $state.composableBuilder(
      column: $state.table.namaRekening,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get uang => $state.composableBuilder(
      column: $state.table.uang,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get jenis => $state.composableBuilder(
      column: $state.table.jenis,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get catatan => $state.composableBuilder(
      column: $state.table.catatan,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$RekeningsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $RekeningsTable> {
  $$RekeningsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get namaRekening => $state.composableBuilder(
      column: $state.table.namaRekening,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get uang => $state.composableBuilder(
      column: $state.table.uang,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get jenis => $state.composableBuilder(
      column: $state.table.jenis,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get catatan => $state.composableBuilder(
      column: $state.table.catatan,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AkunsTableInsertCompanionBuilder = AkunsCompanion Function({
  Value<int> id,
  required String imagePath,
  required String nama,
});
typedef $$AkunsTableUpdateCompanionBuilder = AkunsCompanion Function({
  Value<int> id,
  Value<String> imagePath,
  Value<String> nama,
});

class $$AkunsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AkunsTable,
    Akun,
    $$AkunsTableFilterComposer,
    $$AkunsTableOrderingComposer,
    $$AkunsTableProcessedTableManager,
    $$AkunsTableInsertCompanionBuilder,
    $$AkunsTableUpdateCompanionBuilder> {
  $$AkunsTableTableManager(_$AppDatabase db, $AkunsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AkunsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AkunsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$AkunsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String> imagePath = const Value.absent(),
            Value<String> nama = const Value.absent(),
          }) =>
              AkunsCompanion(
            id: id,
            imagePath: imagePath,
            nama: nama,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required String imagePath,
            required String nama,
          }) =>
              AkunsCompanion.insert(
            id: id,
            imagePath: imagePath,
            nama: nama,
          ),
        ));
}

class $$AkunsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $AkunsTable,
    Akun,
    $$AkunsTableFilterComposer,
    $$AkunsTableOrderingComposer,
    $$AkunsTableProcessedTableManager,
    $$AkunsTableInsertCompanionBuilder,
    $$AkunsTableUpdateCompanionBuilder> {
  $$AkunsTableProcessedTableManager(super.$state);
}

class $$AkunsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AkunsTable> {
  $$AkunsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get imagePath => $state.composableBuilder(
      column: $state.table.imagePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get nama => $state.composableBuilder(
      column: $state.table.nama,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AkunsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AkunsTable> {
  $$AkunsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get imagePath => $state.composableBuilder(
      column: $state.table.imagePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get nama => $state.composableBuilder(
      column: $state.table.nama,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PengelolaTableInsertCompanionBuilder = PengelolaCompanion Function({
  Value<int> id,
  required int uang,
  required int type,
  required String jenis,
  required String catatan,
  required DateTime transaksidate,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$PengelolaTableUpdateCompanionBuilder = PengelolaCompanion Function({
  Value<int> id,
  Value<int> uang,
  Value<int> type,
  Value<String> jenis,
  Value<String> catatan,
  Value<DateTime> transaksidate,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
});

class $$PengelolaTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PengelolaTable,
    Pengelolaan,
    $$PengelolaTableFilterComposer,
    $$PengelolaTableOrderingComposer,
    $$PengelolaTableProcessedTableManager,
    $$PengelolaTableInsertCompanionBuilder,
    $$PengelolaTableUpdateCompanionBuilder> {
  $$PengelolaTableTableManager(_$AppDatabase db, $PengelolaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PengelolaTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PengelolaTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$PengelolaTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<int> uang = const Value.absent(),
            Value<int> type = const Value.absent(),
            Value<String> jenis = const Value.absent(),
            Value<String> catatan = const Value.absent(),
            Value<DateTime> transaksidate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              PengelolaCompanion(
            id: id,
            uang: uang,
            type: type,
            jenis: jenis,
            catatan: catatan,
            transaksidate: transaksidate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            required int uang,
            required int type,
            required String jenis,
            required String catatan,
            required DateTime transaksidate,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              PengelolaCompanion.insert(
            id: id,
            uang: uang,
            type: type,
            jenis: jenis,
            catatan: catatan,
            transaksidate: transaksidate,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
        ));
}

class $$PengelolaTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $PengelolaTable,
    Pengelolaan,
    $$PengelolaTableFilterComposer,
    $$PengelolaTableOrderingComposer,
    $$PengelolaTableProcessedTableManager,
    $$PengelolaTableInsertCompanionBuilder,
    $$PengelolaTableUpdateCompanionBuilder> {
  $$PengelolaTableProcessedTableManager(super.$state);
}

class $$PengelolaTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PengelolaTable> {
  $$PengelolaTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get uang => $state.composableBuilder(
      column: $state.table.uang,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get jenis => $state.composableBuilder(
      column: $state.table.jenis,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get catatan => $state.composableBuilder(
      column: $state.table.catatan,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get transaksidate => $state.composableBuilder(
      column: $state.table.transaksidate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PengelolaTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PengelolaTable> {
  $$PengelolaTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get uang => $state.composableBuilder(
      column: $state.table.uang,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get jenis => $state.composableBuilder(
      column: $state.table.jenis,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get catatan => $state.composableBuilder(
      column: $state.table.catatan,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get transaksidate => $state.composableBuilder(
      column: $state.table.transaksidate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$RekeningsTableTableManager get rekenings =>
      $$RekeningsTableTableManager(_db, _db.rekenings);
  $$AkunsTableTableManager get akuns =>
      $$AkunsTableTableManager(_db, _db.akuns);
  $$PengelolaTableTableManager get pengelola =>
      $$PengelolaTableTableManager(_db, _db.pengelola);
}
