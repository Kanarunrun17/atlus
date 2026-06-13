// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PinsTable extends Pins with TableInfo<$PinsTable, Pin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proposerMeta = const VerificationMeta(
    'proposer',
  );
  @override
  late final GeneratedColumn<String> proposer = GeneratedColumn<String>(
    'proposer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoBase64Meta = const VerificationMeta(
    'photoBase64',
  );
  @override
  late final GeneratedColumn<String> photoBase64 = GeneratedColumn<String>(
    'photo_base64',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _visitedAtMeta = const VerificationMeta(
    'visitedAt',
  );
  @override
  late final GeneratedColumn<DateTime> visitedAt = GeneratedColumn<DateTime>(
    'visited_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    latitude,
    longitude,
    name,
    kind,
    proposer,
    rating,
    comment,
    photoBase64,
    visitedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pins';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pin> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('proposer')) {
      context.handle(
        _proposerMeta,
        proposer.isAcceptableOrUnknown(data['proposer']!, _proposerMeta),
      );
    } else if (isInserting) {
      context.missing(_proposerMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('photo_base64')) {
      context.handle(
        _photoBase64Meta,
        photoBase64.isAcceptableOrUnknown(
          data['photo_base64']!,
          _photoBase64Meta,
        ),
      );
    }
    if (data.containsKey('visited_at')) {
      context.handle(
        _visitedAtMeta,
        visitedAt.isAcceptableOrUnknown(data['visited_at']!, _visitedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pin(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      proposer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proposer'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      photoBase64: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_base64'],
      ),
      visitedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}visited_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PinsTable createAlias(String alias) {
    return $PinsTable(attachedDatabase, alias);
  }
}

class Pin extends DataClass implements Insertable<Pin> {
  final int id;
  final double latitude;
  final double longitude;
  final String name;

  /// 種別: visited(行った) / planned(予定) / anniversary(記念日)
  final String kind;

  /// 提案者: me(自分) / partner(パートナー)
  final String proposer;

  /// ★評価 (1〜5, nullable)
  final int? rating;
  final String? comment;

  /// 写真（Base64エンコードした画像データ, nullable）
  final String? photoBase64;

  /// 訪問日 (nullable)
  final DateTime? visitedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Pin({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.kind,
    required this.proposer,
    this.rating,
    this.comment,
    this.photoBase64,
    this.visitedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['name'] = Variable<String>(name);
    map['kind'] = Variable<String>(kind);
    map['proposer'] = Variable<String>(proposer);
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || photoBase64 != null) {
      map['photo_base64'] = Variable<String>(photoBase64);
    }
    if (!nullToAbsent || visitedAt != null) {
      map['visited_at'] = Variable<DateTime>(visitedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PinsCompanion toCompanion(bool nullToAbsent) {
    return PinsCompanion(
      id: Value(id),
      latitude: Value(latitude),
      longitude: Value(longitude),
      name: Value(name),
      kind: Value(kind),
      proposer: Value(proposer),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      photoBase64: photoBase64 == null && nullToAbsent
          ? const Value.absent()
          : Value(photoBase64),
      visitedAt: visitedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(visitedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Pin.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pin(
      id: serializer.fromJson<int>(json['id']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      name: serializer.fromJson<String>(json['name']),
      kind: serializer.fromJson<String>(json['kind']),
      proposer: serializer.fromJson<String>(json['proposer']),
      rating: serializer.fromJson<int?>(json['rating']),
      comment: serializer.fromJson<String?>(json['comment']),
      photoBase64: serializer.fromJson<String?>(json['photoBase64']),
      visitedAt: serializer.fromJson<DateTime?>(json['visitedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'name': serializer.toJson<String>(name),
      'kind': serializer.toJson<String>(kind),
      'proposer': serializer.toJson<String>(proposer),
      'rating': serializer.toJson<int?>(rating),
      'comment': serializer.toJson<String?>(comment),
      'photoBase64': serializer.toJson<String?>(photoBase64),
      'visitedAt': serializer.toJson<DateTime?>(visitedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Pin copyWith({
    int? id,
    double? latitude,
    double? longitude,
    String? name,
    String? kind,
    String? proposer,
    Value<int?> rating = const Value.absent(),
    Value<String?> comment = const Value.absent(),
    Value<String?> photoBase64 = const Value.absent(),
    Value<DateTime?> visitedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Pin(
    id: id ?? this.id,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    name: name ?? this.name,
    kind: kind ?? this.kind,
    proposer: proposer ?? this.proposer,
    rating: rating.present ? rating.value : this.rating,
    comment: comment.present ? comment.value : this.comment,
    photoBase64: photoBase64.present ? photoBase64.value : this.photoBase64,
    visitedAt: visitedAt.present ? visitedAt.value : this.visitedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Pin copyWithCompanion(PinsCompanion data) {
    return Pin(
      id: data.id.present ? data.id.value : this.id,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      name: data.name.present ? data.name.value : this.name,
      kind: data.kind.present ? data.kind.value : this.kind,
      proposer: data.proposer.present ? data.proposer.value : this.proposer,
      rating: data.rating.present ? data.rating.value : this.rating,
      comment: data.comment.present ? data.comment.value : this.comment,
      photoBase64: data.photoBase64.present
          ? data.photoBase64.value
          : this.photoBase64,
      visitedAt: data.visitedAt.present ? data.visitedAt.value : this.visitedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pin(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('proposer: $proposer, ')
          ..write('rating: $rating, ')
          ..write('comment: $comment, ')
          ..write('photoBase64: $photoBase64, ')
          ..write('visitedAt: $visitedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    latitude,
    longitude,
    name,
    kind,
    proposer,
    rating,
    comment,
    photoBase64,
    visitedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pin &&
          other.id == this.id &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.name == this.name &&
          other.kind == this.kind &&
          other.proposer == this.proposer &&
          other.rating == this.rating &&
          other.comment == this.comment &&
          other.photoBase64 == this.photoBase64 &&
          other.visitedAt == this.visitedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PinsCompanion extends UpdateCompanion<Pin> {
  final Value<int> id;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<String> name;
  final Value<String> kind;
  final Value<String> proposer;
  final Value<int?> rating;
  final Value<String?> comment;
  final Value<String?> photoBase64;
  final Value<DateTime?> visitedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PinsCompanion({
    this.id = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.name = const Value.absent(),
    this.kind = const Value.absent(),
    this.proposer = const Value.absent(),
    this.rating = const Value.absent(),
    this.comment = const Value.absent(),
    this.photoBase64 = const Value.absent(),
    this.visitedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PinsCompanion.insert({
    this.id = const Value.absent(),
    required double latitude,
    required double longitude,
    required String name,
    required String kind,
    required String proposer,
    this.rating = const Value.absent(),
    this.comment = const Value.absent(),
    this.photoBase64 = const Value.absent(),
    this.visitedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : latitude = Value(latitude),
       longitude = Value(longitude),
       name = Value(name),
       kind = Value(kind),
       proposer = Value(proposer),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Pin> custom({
    Expression<int>? id,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? name,
    Expression<String>? kind,
    Expression<String>? proposer,
    Expression<int>? rating,
    Expression<String>? comment,
    Expression<String>? photoBase64,
    Expression<DateTime>? visitedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (name != null) 'name': name,
      if (kind != null) 'kind': kind,
      if (proposer != null) 'proposer': proposer,
      if (rating != null) 'rating': rating,
      if (comment != null) 'comment': comment,
      if (photoBase64 != null) 'photo_base64': photoBase64,
      if (visitedAt != null) 'visited_at': visitedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PinsCompanion copyWith({
    Value<int>? id,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<String>? name,
    Value<String>? kind,
    Value<String>? proposer,
    Value<int?>? rating,
    Value<String?>? comment,
    Value<String?>? photoBase64,
    Value<DateTime?>? visitedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PinsCompanion(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      kind: kind ?? this.kind,
      proposer: proposer ?? this.proposer,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      photoBase64: photoBase64 ?? this.photoBase64,
      visitedAt: visitedAt ?? this.visitedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (proposer.present) {
      map['proposer'] = Variable<String>(proposer.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (photoBase64.present) {
      map['photo_base64'] = Variable<String>(photoBase64.value);
    }
    if (visitedAt.present) {
      map['visited_at'] = Variable<DateTime>(visitedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PinsCompanion(')
          ..write('id: $id, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('name: $name, ')
          ..write('kind: $kind, ')
          ..write('proposer: $proposer, ')
          ..write('rating: $rating, ')
          ..write('comment: $comment, ')
          ..write('photoBase64: $photoBase64, ')
          ..write('visitedAt: $visitedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AnniversariesTable extends Anniversaries
    with TableInfo<$AnniversariesTable, Anniversary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnniversariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recurringMeta = const VerificationMeta(
    'recurring',
  );
  @override
  late final GeneratedColumn<bool> recurring = GeneratedColumn<bool>(
    'recurring',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("recurring" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, date, recurring, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'anniversaries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Anniversary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('recurring')) {
      context.handle(
        _recurringMeta,
        recurring.isAcceptableOrUnknown(data['recurring']!, _recurringMeta),
      );
    } else if (isInserting) {
      context.missing(_recurringMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Anniversary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Anniversary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      recurring: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}recurring'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AnniversariesTable createAlias(String alias) {
    return $AnniversariesTable(attachedDatabase, alias);
  }
}

class Anniversary extends DataClass implements Insertable<Anniversary> {
  final int id;
  final String title;

  /// 記念日の日付
  final DateTime date;

  /// 毎年繰り返すかどうか
  final bool recurring;
  final DateTime createdAt;
  const Anniversary({
    required this.id,
    required this.title,
    required this.date,
    required this.recurring,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['date'] = Variable<DateTime>(date);
    map['recurring'] = Variable<bool>(recurring);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AnniversariesCompanion toCompanion(bool nullToAbsent) {
    return AnniversariesCompanion(
      id: Value(id),
      title: Value(title),
      date: Value(date),
      recurring: Value(recurring),
      createdAt: Value(createdAt),
    );
  }

  factory Anniversary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Anniversary(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      date: serializer.fromJson<DateTime>(json['date']),
      recurring: serializer.fromJson<bool>(json['recurring']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'date': serializer.toJson<DateTime>(date),
      'recurring': serializer.toJson<bool>(recurring),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Anniversary copyWith({
    int? id,
    String? title,
    DateTime? date,
    bool? recurring,
    DateTime? createdAt,
  }) => Anniversary(
    id: id ?? this.id,
    title: title ?? this.title,
    date: date ?? this.date,
    recurring: recurring ?? this.recurring,
    createdAt: createdAt ?? this.createdAt,
  );
  Anniversary copyWithCompanion(AnniversariesCompanion data) {
    return Anniversary(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      date: data.date.present ? data.date.value : this.date,
      recurring: data.recurring.present ? data.recurring.value : this.recurring,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Anniversary(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('recurring: $recurring, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, date, recurring, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Anniversary &&
          other.id == this.id &&
          other.title == this.title &&
          other.date == this.date &&
          other.recurring == this.recurring &&
          other.createdAt == this.createdAt);
}

class AnniversariesCompanion extends UpdateCompanion<Anniversary> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> date;
  final Value<bool> recurring;
  final Value<DateTime> createdAt;
  const AnniversariesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.date = const Value.absent(),
    this.recurring = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AnniversariesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required DateTime date,
    required bool recurring,
    required DateTime createdAt,
  }) : title = Value(title),
       date = Value(date),
       recurring = Value(recurring),
       createdAt = Value(createdAt);
  static Insertable<Anniversary> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? date,
    Expression<bool>? recurring,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (date != null) 'date': date,
      if (recurring != null) 'recurring': recurring,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AnniversariesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<DateTime>? date,
    Value<bool>? recurring,
    Value<DateTime>? createdAt,
  }) {
    return AnniversariesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      recurring: recurring ?? this.recurring,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (recurring.present) {
      map['recurring'] = Variable<bool>(recurring.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnniversariesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('recurring: $recurring, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PinsTable pins = $PinsTable(this);
  late final $AnniversariesTable anniversaries = $AnniversariesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [pins, anniversaries];
}

typedef $$PinsTableCreateCompanionBuilder =
    PinsCompanion Function({
      Value<int> id,
      required double latitude,
      required double longitude,
      required String name,
      required String kind,
      required String proposer,
      Value<int?> rating,
      Value<String?> comment,
      Value<String?> photoBase64,
      Value<DateTime?> visitedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$PinsTableUpdateCompanionBuilder =
    PinsCompanion Function({
      Value<int> id,
      Value<double> latitude,
      Value<double> longitude,
      Value<String> name,
      Value<String> kind,
      Value<String> proposer,
      Value<int?> rating,
      Value<String?> comment,
      Value<String?> photoBase64,
      Value<DateTime?> visitedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$PinsTableFilterComposer extends Composer<_$AppDatabase, $PinsTable> {
  $$PinsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proposer => $composableBuilder(
    column: $table.proposer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoBase64 => $composableBuilder(
    column: $table.photoBase64,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get visitedAt => $composableBuilder(
    column: $table.visitedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PinsTableOrderingComposer extends Composer<_$AppDatabase, $PinsTable> {
  $$PinsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proposer => $composableBuilder(
    column: $table.proposer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoBase64 => $composableBuilder(
    column: $table.photoBase64,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get visitedAt => $composableBuilder(
    column: $table.visitedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PinsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PinsTable> {
  $$PinsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get proposer =>
      $composableBuilder(column: $table.proposer, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<String> get photoBase64 => $composableBuilder(
    column: $table.photoBase64,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get visitedAt =>
      $composableBuilder(column: $table.visitedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PinsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PinsTable,
          Pin,
          $$PinsTableFilterComposer,
          $$PinsTableOrderingComposer,
          $$PinsTableAnnotationComposer,
          $$PinsTableCreateCompanionBuilder,
          $$PinsTableUpdateCompanionBuilder,
          (Pin, BaseReferences<_$AppDatabase, $PinsTable, Pin>),
          Pin,
          PrefetchHooks Function()
        > {
  $$PinsTableTableManager(_$AppDatabase db, $PinsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PinsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PinsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PinsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String> proposer = const Value.absent(),
                Value<int?> rating = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<String?> photoBase64 = const Value.absent(),
                Value<DateTime?> visitedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PinsCompanion(
                id: id,
                latitude: latitude,
                longitude: longitude,
                name: name,
                kind: kind,
                proposer: proposer,
                rating: rating,
                comment: comment,
                photoBase64: photoBase64,
                visitedAt: visitedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double latitude,
                required double longitude,
                required String name,
                required String kind,
                required String proposer,
                Value<int?> rating = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<String?> photoBase64 = const Value.absent(),
                Value<DateTime?> visitedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => PinsCompanion.insert(
                id: id,
                latitude: latitude,
                longitude: longitude,
                name: name,
                kind: kind,
                proposer: proposer,
                rating: rating,
                comment: comment,
                photoBase64: photoBase64,
                visitedAt: visitedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PinsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PinsTable,
      Pin,
      $$PinsTableFilterComposer,
      $$PinsTableOrderingComposer,
      $$PinsTableAnnotationComposer,
      $$PinsTableCreateCompanionBuilder,
      $$PinsTableUpdateCompanionBuilder,
      (Pin, BaseReferences<_$AppDatabase, $PinsTable, Pin>),
      Pin,
      PrefetchHooks Function()
    >;
typedef $$AnniversariesTableCreateCompanionBuilder =
    AnniversariesCompanion Function({
      Value<int> id,
      required String title,
      required DateTime date,
      required bool recurring,
      required DateTime createdAt,
    });
typedef $$AnniversariesTableUpdateCompanionBuilder =
    AnniversariesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<DateTime> date,
      Value<bool> recurring,
      Value<DateTime> createdAt,
    });

class $$AnniversariesTableFilterComposer
    extends Composer<_$AppDatabase, $AnniversariesTable> {
  $$AnniversariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get recurring => $composableBuilder(
    column: $table.recurring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnniversariesTableOrderingComposer
    extends Composer<_$AppDatabase, $AnniversariesTable> {
  $$AnniversariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get recurring => $composableBuilder(
    column: $table.recurring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnniversariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnniversariesTable> {
  $$AnniversariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get recurring =>
      $composableBuilder(column: $table.recurring, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AnniversariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnniversariesTable,
          Anniversary,
          $$AnniversariesTableFilterComposer,
          $$AnniversariesTableOrderingComposer,
          $$AnniversariesTableAnnotationComposer,
          $$AnniversariesTableCreateCompanionBuilder,
          $$AnniversariesTableUpdateCompanionBuilder,
          (
            Anniversary,
            BaseReferences<_$AppDatabase, $AnniversariesTable, Anniversary>,
          ),
          Anniversary,
          PrefetchHooks Function()
        > {
  $$AnniversariesTableTableManager(_$AppDatabase db, $AnniversariesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnniversariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnniversariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnniversariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<bool> recurring = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AnniversariesCompanion(
                id: id,
                title: title,
                date: date,
                recurring: recurring,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required DateTime date,
                required bool recurring,
                required DateTime createdAt,
              }) => AnniversariesCompanion.insert(
                id: id,
                title: title,
                date: date,
                recurring: recurring,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnniversariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnniversariesTable,
      Anniversary,
      $$AnniversariesTableFilterComposer,
      $$AnniversariesTableOrderingComposer,
      $$AnniversariesTableAnnotationComposer,
      $$AnniversariesTableCreateCompanionBuilder,
      $$AnniversariesTableUpdateCompanionBuilder,
      (
        Anniversary,
        BaseReferences<_$AppDatabase, $AnniversariesTable, Anniversary>,
      ),
      Anniversary,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PinsTableTableManager get pins => $$PinsTableTableManager(_db, _db.pins);
  $$AnniversariesTableTableManager get anniversaries =>
      $$AnniversariesTableTableManager(_db, _db.anniversaries);
}
