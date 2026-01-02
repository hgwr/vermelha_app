// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CharactersTable extends Characters
    with TableInfo<$CharactersTable, Character> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharactersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _maxHpMeta = const VerificationMeta('maxHp');
  @override
  late final GeneratedColumn<int> maxHp = GeneratedColumn<int>(
      'max_hp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _maxMpMeta = const VerificationMeta('maxMp');
  @override
  late final GeneratedColumn<int> maxMp = GeneratedColumn<int>(
      'max_mp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _hpMeta = const VerificationMeta('hp');
  @override
  late final GeneratedColumn<int> hp = GeneratedColumn<int>(
      'hp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _mpMeta = const VerificationMeta('mp');
  @override
  late final GeneratedColumn<int> mp = GeneratedColumn<int>(
      'mp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _attackMeta = const VerificationMeta('attack');
  @override
  late final GeneratedColumn<int> attack = GeneratedColumn<int>(
      'attack', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _defenseMeta =
      const VerificationMeta('defense');
  @override
  late final GeneratedColumn<int> defense = GeneratedColumn<int>(
      'defense', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _magicPowerMeta =
      const VerificationMeta('magicPower');
  @override
  late final GeneratedColumn<int> magicPower = GeneratedColumn<int>(
      'magic_power', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<int> speed = GeneratedColumn<int>(
      'speed', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _jobIdMeta = const VerificationMeta('jobId');
  @override
  late final GeneratedColumn<int> jobId = GeneratedColumn<int>(
      'job_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _expMeta = const VerificationMeta('exp');
  @override
  late final GeneratedColumn<int> exp = GeneratedColumn<int>(
      'exp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
      'is_active', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _partyPositionMeta =
      const VerificationMeta('partyPosition');
  @override
  late final GeneratedColumn<int> partyPosition = GeneratedColumn<int>(
      'party_position', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _jobBonusMeta =
      const VerificationMeta('jobBonus');
  @override
  late final GeneratedColumn<String> jobBonus = GeneratedColumn<String>(
      'job_bonus', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        level,
        maxHp,
        maxMp,
        hp,
        mp,
        attack,
        defense,
        magicPower,
        speed,
        jobId,
        exp,
        isActive,
        partyPosition,
        jobBonus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character';
  @override
  VerificationContext validateIntegrity(Insertable<Character> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('max_hp')) {
      context.handle(
          _maxHpMeta, maxHp.isAcceptableOrUnknown(data['max_hp']!, _maxHpMeta));
    } else if (isInserting) {
      context.missing(_maxHpMeta);
    }
    if (data.containsKey('max_mp')) {
      context.handle(
          _maxMpMeta, maxMp.isAcceptableOrUnknown(data['max_mp']!, _maxMpMeta));
    } else if (isInserting) {
      context.missing(_maxMpMeta);
    }
    if (data.containsKey('hp')) {
      context.handle(_hpMeta, hp.isAcceptableOrUnknown(data['hp']!, _hpMeta));
    } else if (isInserting) {
      context.missing(_hpMeta);
    }
    if (data.containsKey('mp')) {
      context.handle(_mpMeta, mp.isAcceptableOrUnknown(data['mp']!, _mpMeta));
    } else if (isInserting) {
      context.missing(_mpMeta);
    }
    if (data.containsKey('attack')) {
      context.handle(_attackMeta,
          attack.isAcceptableOrUnknown(data['attack']!, _attackMeta));
    } else if (isInserting) {
      context.missing(_attackMeta);
    }
    if (data.containsKey('defense')) {
      context.handle(_defenseMeta,
          defense.isAcceptableOrUnknown(data['defense']!, _defenseMeta));
    } else if (isInserting) {
      context.missing(_defenseMeta);
    }
    if (data.containsKey('magic_power')) {
      context.handle(
          _magicPowerMeta,
          magicPower.isAcceptableOrUnknown(
              data['magic_power']!, _magicPowerMeta));
    } else if (isInserting) {
      context.missing(_magicPowerMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
          _speedMeta, speed.isAcceptableOrUnknown(data['speed']!, _speedMeta));
    } else if (isInserting) {
      context.missing(_speedMeta);
    }
    if (data.containsKey('job_id')) {
      context.handle(
          _jobIdMeta, jobId.isAcceptableOrUnknown(data['job_id']!, _jobIdMeta));
    }
    if (data.containsKey('exp')) {
      context.handle(
          _expMeta, exp.isAcceptableOrUnknown(data['exp']!, _expMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('party_position')) {
      context.handle(
          _partyPositionMeta,
          partyPosition.isAcceptableOrUnknown(
              data['party_position']!, _partyPositionMeta));
    }
    if (data.containsKey('job_bonus')) {
      context.handle(_jobBonusMeta,
          jobBonus.isAcceptableOrUnknown(data['job_bonus']!, _jobBonusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Character map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Character(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      maxHp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_hp'])!,
      maxMp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_mp'])!,
      hp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}hp'])!,
      mp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mp'])!,
      attack: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}attack'])!,
      defense: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}defense'])!,
      magicPower: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}magic_power'])!,
      speed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}speed'])!,
      jobId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}job_id']),
      exp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}exp'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_active'])!,
      partyPosition: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}party_position']),
      jobBonus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_bonus']),
    );
  }

  @override
  $CharactersTable createAlias(String alias) {
    return $CharactersTable(attachedDatabase, alias);
  }
}

class Character extends DataClass implements Insertable<Character> {
  final int id;
  final String name;
  final int level;
  final int maxHp;
  final int maxMp;
  final int hp;
  final int mp;
  final int attack;
  final int defense;
  final int magicPower;
  final int speed;
  final int? jobId;
  final int exp;
  final int isActive;
  final int? partyPosition;
  final String? jobBonus;
  const Character(
      {required this.id,
      required this.name,
      required this.level,
      required this.maxHp,
      required this.maxMp,
      required this.hp,
      required this.mp,
      required this.attack,
      required this.defense,
      required this.magicPower,
      required this.speed,
      this.jobId,
      required this.exp,
      required this.isActive,
      this.partyPosition,
      this.jobBonus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['level'] = Variable<int>(level);
    map['max_hp'] = Variable<int>(maxHp);
    map['max_mp'] = Variable<int>(maxMp);
    map['hp'] = Variable<int>(hp);
    map['mp'] = Variable<int>(mp);
    map['attack'] = Variable<int>(attack);
    map['defense'] = Variable<int>(defense);
    map['magic_power'] = Variable<int>(magicPower);
    map['speed'] = Variable<int>(speed);
    if (!nullToAbsent || jobId != null) {
      map['job_id'] = Variable<int>(jobId);
    }
    map['exp'] = Variable<int>(exp);
    map['is_active'] = Variable<int>(isActive);
    if (!nullToAbsent || partyPosition != null) {
      map['party_position'] = Variable<int>(partyPosition);
    }
    if (!nullToAbsent || jobBonus != null) {
      map['job_bonus'] = Variable<String>(jobBonus);
    }
    return map;
  }

  CharactersCompanion toCompanion(bool nullToAbsent) {
    return CharactersCompanion(
      id: Value(id),
      name: Value(name),
      level: Value(level),
      maxHp: Value(maxHp),
      maxMp: Value(maxMp),
      hp: Value(hp),
      mp: Value(mp),
      attack: Value(attack),
      defense: Value(defense),
      magicPower: Value(magicPower),
      speed: Value(speed),
      jobId:
          jobId == null && nullToAbsent ? const Value.absent() : Value(jobId),
      exp: Value(exp),
      isActive: Value(isActive),
      partyPosition: partyPosition == null && nullToAbsent
          ? const Value.absent()
          : Value(partyPosition),
      jobBonus: jobBonus == null && nullToAbsent
          ? const Value.absent()
          : Value(jobBonus),
    );
  }

  factory Character.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Character(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      level: serializer.fromJson<int>(json['level']),
      maxHp: serializer.fromJson<int>(json['maxHp']),
      maxMp: serializer.fromJson<int>(json['maxMp']),
      hp: serializer.fromJson<int>(json['hp']),
      mp: serializer.fromJson<int>(json['mp']),
      attack: serializer.fromJson<int>(json['attack']),
      defense: serializer.fromJson<int>(json['defense']),
      magicPower: serializer.fromJson<int>(json['magicPower']),
      speed: serializer.fromJson<int>(json['speed']),
      jobId: serializer.fromJson<int?>(json['jobId']),
      exp: serializer.fromJson<int>(json['exp']),
      isActive: serializer.fromJson<int>(json['isActive']),
      partyPosition: serializer.fromJson<int?>(json['partyPosition']),
      jobBonus: serializer.fromJson<String?>(json['jobBonus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'level': serializer.toJson<int>(level),
      'maxHp': serializer.toJson<int>(maxHp),
      'maxMp': serializer.toJson<int>(maxMp),
      'hp': serializer.toJson<int>(hp),
      'mp': serializer.toJson<int>(mp),
      'attack': serializer.toJson<int>(attack),
      'defense': serializer.toJson<int>(defense),
      'magicPower': serializer.toJson<int>(magicPower),
      'speed': serializer.toJson<int>(speed),
      'jobId': serializer.toJson<int?>(jobId),
      'exp': serializer.toJson<int>(exp),
      'isActive': serializer.toJson<int>(isActive),
      'partyPosition': serializer.toJson<int?>(partyPosition),
      'jobBonus': serializer.toJson<String?>(jobBonus),
    };
  }

  Character copyWith(
          {int? id,
          String? name,
          int? level,
          int? maxHp,
          int? maxMp,
          int? hp,
          int? mp,
          int? attack,
          int? defense,
          int? magicPower,
          int? speed,
          Value<int?> jobId = const Value.absent(),
          int? exp,
          int? isActive,
          Value<int?> partyPosition = const Value.absent(),
          Value<String?> jobBonus = const Value.absent()}) =>
      Character(
        id: id ?? this.id,
        name: name ?? this.name,
        level: level ?? this.level,
        maxHp: maxHp ?? this.maxHp,
        maxMp: maxMp ?? this.maxMp,
        hp: hp ?? this.hp,
        mp: mp ?? this.mp,
        attack: attack ?? this.attack,
        defense: defense ?? this.defense,
        magicPower: magicPower ?? this.magicPower,
        speed: speed ?? this.speed,
        jobId: jobId.present ? jobId.value : this.jobId,
        exp: exp ?? this.exp,
        isActive: isActive ?? this.isActive,
        partyPosition:
            partyPosition.present ? partyPosition.value : this.partyPosition,
        jobBonus: jobBonus.present ? jobBonus.value : this.jobBonus,
      );
  Character copyWithCompanion(CharactersCompanion data) {
    return Character(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      level: data.level.present ? data.level.value : this.level,
      maxHp: data.maxHp.present ? data.maxHp.value : this.maxHp,
      maxMp: data.maxMp.present ? data.maxMp.value : this.maxMp,
      hp: data.hp.present ? data.hp.value : this.hp,
      mp: data.mp.present ? data.mp.value : this.mp,
      attack: data.attack.present ? data.attack.value : this.attack,
      defense: data.defense.present ? data.defense.value : this.defense,
      magicPower:
          data.magicPower.present ? data.magicPower.value : this.magicPower,
      speed: data.speed.present ? data.speed.value : this.speed,
      jobId: data.jobId.present ? data.jobId.value : this.jobId,
      exp: data.exp.present ? data.exp.value : this.exp,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      partyPosition: data.partyPosition.present
          ? data.partyPosition.value
          : this.partyPosition,
      jobBonus: data.jobBonus.present ? data.jobBonus.value : this.jobBonus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Character(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('maxHp: $maxHp, ')
          ..write('maxMp: $maxMp, ')
          ..write('hp: $hp, ')
          ..write('mp: $mp, ')
          ..write('attack: $attack, ')
          ..write('defense: $defense, ')
          ..write('magicPower: $magicPower, ')
          ..write('speed: $speed, ')
          ..write('jobId: $jobId, ')
          ..write('exp: $exp, ')
          ..write('isActive: $isActive, ')
          ..write('partyPosition: $partyPosition, ')
          ..write('jobBonus: $jobBonus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      level,
      maxHp,
      maxMp,
      hp,
      mp,
      attack,
      defense,
      magicPower,
      speed,
      jobId,
      exp,
      isActive,
      partyPosition,
      jobBonus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Character &&
          other.id == this.id &&
          other.name == this.name &&
          other.level == this.level &&
          other.maxHp == this.maxHp &&
          other.maxMp == this.maxMp &&
          other.hp == this.hp &&
          other.mp == this.mp &&
          other.attack == this.attack &&
          other.defense == this.defense &&
          other.magicPower == this.magicPower &&
          other.speed == this.speed &&
          other.jobId == this.jobId &&
          other.exp == this.exp &&
          other.isActive == this.isActive &&
          other.partyPosition == this.partyPosition &&
          other.jobBonus == this.jobBonus);
}

class CharactersCompanion extends UpdateCompanion<Character> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> level;
  final Value<int> maxHp;
  final Value<int> maxMp;
  final Value<int> hp;
  final Value<int> mp;
  final Value<int> attack;
  final Value<int> defense;
  final Value<int> magicPower;
  final Value<int> speed;
  final Value<int?> jobId;
  final Value<int> exp;
  final Value<int> isActive;
  final Value<int?> partyPosition;
  final Value<String?> jobBonus;
  const CharactersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.level = const Value.absent(),
    this.maxHp = const Value.absent(),
    this.maxMp = const Value.absent(),
    this.hp = const Value.absent(),
    this.mp = const Value.absent(),
    this.attack = const Value.absent(),
    this.defense = const Value.absent(),
    this.magicPower = const Value.absent(),
    this.speed = const Value.absent(),
    this.jobId = const Value.absent(),
    this.exp = const Value.absent(),
    this.isActive = const Value.absent(),
    this.partyPosition = const Value.absent(),
    this.jobBonus = const Value.absent(),
  });
  CharactersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int level,
    required int maxHp,
    required int maxMp,
    required int hp,
    required int mp,
    required int attack,
    required int defense,
    required int magicPower,
    required int speed,
    this.jobId = const Value.absent(),
    this.exp = const Value.absent(),
    this.isActive = const Value.absent(),
    this.partyPosition = const Value.absent(),
    this.jobBonus = const Value.absent(),
  })  : name = Value(name),
        level = Value(level),
        maxHp = Value(maxHp),
        maxMp = Value(maxMp),
        hp = Value(hp),
        mp = Value(mp),
        attack = Value(attack),
        defense = Value(defense),
        magicPower = Value(magicPower),
        speed = Value(speed);
  static Insertable<Character> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? level,
    Expression<int>? maxHp,
    Expression<int>? maxMp,
    Expression<int>? hp,
    Expression<int>? mp,
    Expression<int>? attack,
    Expression<int>? defense,
    Expression<int>? magicPower,
    Expression<int>? speed,
    Expression<int>? jobId,
    Expression<int>? exp,
    Expression<int>? isActive,
    Expression<int>? partyPosition,
    Expression<String>? jobBonus,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (level != null) 'level': level,
      if (maxHp != null) 'max_hp': maxHp,
      if (maxMp != null) 'max_mp': maxMp,
      if (hp != null) 'hp': hp,
      if (mp != null) 'mp': mp,
      if (attack != null) 'attack': attack,
      if (defense != null) 'defense': defense,
      if (magicPower != null) 'magic_power': magicPower,
      if (speed != null) 'speed': speed,
      if (jobId != null) 'job_id': jobId,
      if (exp != null) 'exp': exp,
      if (isActive != null) 'is_active': isActive,
      if (partyPosition != null) 'party_position': partyPosition,
      if (jobBonus != null) 'job_bonus': jobBonus,
    });
  }

  CharactersCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? level,
      Value<int>? maxHp,
      Value<int>? maxMp,
      Value<int>? hp,
      Value<int>? mp,
      Value<int>? attack,
      Value<int>? defense,
      Value<int>? magicPower,
      Value<int>? speed,
      Value<int?>? jobId,
      Value<int>? exp,
      Value<int>? isActive,
      Value<int?>? partyPosition,
      Value<String?>? jobBonus}) {
    return CharactersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      maxHp: maxHp ?? this.maxHp,
      maxMp: maxMp ?? this.maxMp,
      hp: hp ?? this.hp,
      mp: mp ?? this.mp,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      magicPower: magicPower ?? this.magicPower,
      speed: speed ?? this.speed,
      jobId: jobId ?? this.jobId,
      exp: exp ?? this.exp,
      isActive: isActive ?? this.isActive,
      partyPosition: partyPosition ?? this.partyPosition,
      jobBonus: jobBonus ?? this.jobBonus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (maxHp.present) {
      map['max_hp'] = Variable<int>(maxHp.value);
    }
    if (maxMp.present) {
      map['max_mp'] = Variable<int>(maxMp.value);
    }
    if (hp.present) {
      map['hp'] = Variable<int>(hp.value);
    }
    if (mp.present) {
      map['mp'] = Variable<int>(mp.value);
    }
    if (attack.present) {
      map['attack'] = Variable<int>(attack.value);
    }
    if (defense.present) {
      map['defense'] = Variable<int>(defense.value);
    }
    if (magicPower.present) {
      map['magic_power'] = Variable<int>(magicPower.value);
    }
    if (speed.present) {
      map['speed'] = Variable<int>(speed.value);
    }
    if (jobId.present) {
      map['job_id'] = Variable<int>(jobId.value);
    }
    if (exp.present) {
      map['exp'] = Variable<int>(exp.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (partyPosition.present) {
      map['party_position'] = Variable<int>(partyPosition.value);
    }
    if (jobBonus.present) {
      map['job_bonus'] = Variable<String>(jobBonus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharactersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('maxHp: $maxHp, ')
          ..write('maxMp: $maxMp, ')
          ..write('hp: $hp, ')
          ..write('mp: $mp, ')
          ..write('attack: $attack, ')
          ..write('defense: $defense, ')
          ..write('magicPower: $magicPower, ')
          ..write('speed: $speed, ')
          ..write('jobId: $jobId, ')
          ..write('exp: $exp, ')
          ..write('isActive: $isActive, ')
          ..write('partyPosition: $partyPosition, ')
          ..write('jobBonus: $jobBonus')
          ..write(')'))
        .toString();
  }
}

class $StatusParametersTable extends StatusParameters
    with TableInfo<$StatusParametersTable, StatusParameter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatusParametersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _characterIdMeta =
      const VerificationMeta('characterId');
  @override
  late final GeneratedColumn<int> characterId = GeneratedColumn<int>(
      'character_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES character (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, name, characterId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'status_parameter';
  @override
  VerificationContext validateIntegrity(Insertable<StatusParameter> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('character_id')) {
      context.handle(
          _characterIdMeta,
          characterId.isAcceptableOrUnknown(
              data['character_id']!, _characterIdMeta));
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StatusParameter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatusParameter(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      characterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}character_id'])!,
    );
  }

  @override
  $StatusParametersTable createAlias(String alias) {
    return $StatusParametersTable(attachedDatabase, alias);
  }
}

class StatusParameter extends DataClass implements Insertable<StatusParameter> {
  final int id;
  final String name;
  final int characterId;
  const StatusParameter(
      {required this.id, required this.name, required this.characterId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['character_id'] = Variable<int>(characterId);
    return map;
  }

  StatusParametersCompanion toCompanion(bool nullToAbsent) {
    return StatusParametersCompanion(
      id: Value(id),
      name: Value(name),
      characterId: Value(characterId),
    );
  }

  factory StatusParameter.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatusParameter(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      characterId: serializer.fromJson<int>(json['characterId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'characterId': serializer.toJson<int>(characterId),
    };
  }

  StatusParameter copyWith({int? id, String? name, int? characterId}) =>
      StatusParameter(
        id: id ?? this.id,
        name: name ?? this.name,
        characterId: characterId ?? this.characterId,
      );
  StatusParameter copyWithCompanion(StatusParametersCompanion data) {
    return StatusParameter(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      characterId:
          data.characterId.present ? data.characterId.value : this.characterId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StatusParameter(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('characterId: $characterId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, characterId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatusParameter &&
          other.id == this.id &&
          other.name == this.name &&
          other.characterId == this.characterId);
}

class StatusParametersCompanion extends UpdateCompanion<StatusParameter> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> characterId;
  const StatusParametersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.characterId = const Value.absent(),
  });
  StatusParametersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int characterId,
  })  : name = Value(name),
        characterId = Value(characterId);
  static Insertable<StatusParameter> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? characterId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (characterId != null) 'character_id': characterId,
    });
  }

  StatusParametersCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? characterId}) {
    return StatusParametersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      characterId: characterId ?? this.characterId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (characterId.present) {
      map['character_id'] = Variable<int>(characterId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatusParametersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('characterId: $characterId')
          ..write(')'))
        .toString();
  }
}

class $BattleRulesTable extends BattleRules
    with TableInfo<$BattleRulesTable, BattleRule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BattleRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ownerIdMeta =
      const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<int> ownerId = GeneratedColumn<int>(
      'owner_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES character (id)'));
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _conditionUuidMeta =
      const VerificationMeta('conditionUuid');
  @override
  late final GeneratedColumn<String> conditionUuid = GeneratedColumn<String>(
      'condition_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionUuidMeta =
      const VerificationMeta('actionUuid');
  @override
  late final GeneratedColumn<String> actionUuid = GeneratedColumn<String>(
      'action_uuid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetUuidMeta =
      const VerificationMeta('targetUuid');
  @override
  late final GeneratedColumn<String> targetUuid = GeneratedColumn<String>(
      'target_uuid', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ownerId, priority, name, conditionUuid, actionUuid, targetUuid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'battle_rule';
  @override
  VerificationContext validateIntegrity(Insertable<BattleRule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('condition_uuid')) {
      context.handle(
          _conditionUuidMeta,
          conditionUuid.isAcceptableOrUnknown(
              data['condition_uuid']!, _conditionUuidMeta));
    } else if (isInserting) {
      context.missing(_conditionUuidMeta);
    }
    if (data.containsKey('action_uuid')) {
      context.handle(
          _actionUuidMeta,
          actionUuid.isAcceptableOrUnknown(
              data['action_uuid']!, _actionUuidMeta));
    } else if (isInserting) {
      context.missing(_actionUuidMeta);
    }
    if (data.containsKey('target_uuid')) {
      context.handle(
          _targetUuidMeta,
          targetUuid.isAcceptableOrUnknown(
              data['target_uuid']!, _targetUuidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BattleRule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BattleRule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ownerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}owner_id'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      conditionUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}condition_uuid'])!,
      actionUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action_uuid'])!,
      targetUuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}target_uuid']),
    );
  }

  @override
  $BattleRulesTable createAlias(String alias) {
    return $BattleRulesTable(attachedDatabase, alias);
  }
}

class BattleRule extends DataClass implements Insertable<BattleRule> {
  final int id;
  final int ownerId;
  final int priority;
  final String name;
  final String conditionUuid;
  final String actionUuid;
  final String? targetUuid;
  const BattleRule(
      {required this.id,
      required this.ownerId,
      required this.priority,
      required this.name,
      required this.conditionUuid,
      required this.actionUuid,
      this.targetUuid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner_id'] = Variable<int>(ownerId);
    map['priority'] = Variable<int>(priority);
    map['name'] = Variable<String>(name);
    map['condition_uuid'] = Variable<String>(conditionUuid);
    map['action_uuid'] = Variable<String>(actionUuid);
    if (!nullToAbsent || targetUuid != null) {
      map['target_uuid'] = Variable<String>(targetUuid);
    }
    return map;
  }

  BattleRulesCompanion toCompanion(bool nullToAbsent) {
    return BattleRulesCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      priority: Value(priority),
      name: Value(name),
      conditionUuid: Value(conditionUuid),
      actionUuid: Value(actionUuid),
      targetUuid: targetUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(targetUuid),
    );
  }

  factory BattleRule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BattleRule(
      id: serializer.fromJson<int>(json['id']),
      ownerId: serializer.fromJson<int>(json['ownerId']),
      priority: serializer.fromJson<int>(json['priority']),
      name: serializer.fromJson<String>(json['name']),
      conditionUuid: serializer.fromJson<String>(json['conditionUuid']),
      actionUuid: serializer.fromJson<String>(json['actionUuid']),
      targetUuid: serializer.fromJson<String?>(json['targetUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ownerId': serializer.toJson<int>(ownerId),
      'priority': serializer.toJson<int>(priority),
      'name': serializer.toJson<String>(name),
      'conditionUuid': serializer.toJson<String>(conditionUuid),
      'actionUuid': serializer.toJson<String>(actionUuid),
      'targetUuid': serializer.toJson<String?>(targetUuid),
    };
  }

  BattleRule copyWith(
          {int? id,
          int? ownerId,
          int? priority,
          String? name,
          String? conditionUuid,
          String? actionUuid,
          Value<String?> targetUuid = const Value.absent()}) =>
      BattleRule(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        priority: priority ?? this.priority,
        name: name ?? this.name,
        conditionUuid: conditionUuid ?? this.conditionUuid,
        actionUuid: actionUuid ?? this.actionUuid,
        targetUuid: targetUuid.present ? targetUuid.value : this.targetUuid,
      );
  BattleRule copyWithCompanion(BattleRulesCompanion data) {
    return BattleRule(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      priority: data.priority.present ? data.priority.value : this.priority,
      name: data.name.present ? data.name.value : this.name,
      conditionUuid: data.conditionUuid.present
          ? data.conditionUuid.value
          : this.conditionUuid,
      actionUuid:
          data.actionUuid.present ? data.actionUuid.value : this.actionUuid,
      targetUuid:
          data.targetUuid.present ? data.targetUuid.value : this.targetUuid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BattleRule(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('priority: $priority, ')
          ..write('name: $name, ')
          ..write('conditionUuid: $conditionUuid, ')
          ..write('actionUuid: $actionUuid, ')
          ..write('targetUuid: $targetUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, ownerId, priority, name, conditionUuid, actionUuid, targetUuid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BattleRule &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.priority == this.priority &&
          other.name == this.name &&
          other.conditionUuid == this.conditionUuid &&
          other.actionUuid == this.actionUuid &&
          other.targetUuid == this.targetUuid);
}

class BattleRulesCompanion extends UpdateCompanion<BattleRule> {
  final Value<int> id;
  final Value<int> ownerId;
  final Value<int> priority;
  final Value<String> name;
  final Value<String> conditionUuid;
  final Value<String> actionUuid;
  final Value<String?> targetUuid;
  const BattleRulesCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.priority = const Value.absent(),
    this.name = const Value.absent(),
    this.conditionUuid = const Value.absent(),
    this.actionUuid = const Value.absent(),
    this.targetUuid = const Value.absent(),
  });
  BattleRulesCompanion.insert({
    this.id = const Value.absent(),
    required int ownerId,
    required int priority,
    required String name,
    required String conditionUuid,
    required String actionUuid,
    this.targetUuid = const Value.absent(),
  })  : ownerId = Value(ownerId),
        priority = Value(priority),
        name = Value(name),
        conditionUuid = Value(conditionUuid),
        actionUuid = Value(actionUuid);
  static Insertable<BattleRule> custom({
    Expression<int>? id,
    Expression<int>? ownerId,
    Expression<int>? priority,
    Expression<String>? name,
    Expression<String>? conditionUuid,
    Expression<String>? actionUuid,
    Expression<String>? targetUuid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (priority != null) 'priority': priority,
      if (name != null) 'name': name,
      if (conditionUuid != null) 'condition_uuid': conditionUuid,
      if (actionUuid != null) 'action_uuid': actionUuid,
      if (targetUuid != null) 'target_uuid': targetUuid,
    });
  }

  BattleRulesCompanion copyWith(
      {Value<int>? id,
      Value<int>? ownerId,
      Value<int>? priority,
      Value<String>? name,
      Value<String>? conditionUuid,
      Value<String>? actionUuid,
      Value<String?>? targetUuid}) {
    return BattleRulesCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      priority: priority ?? this.priority,
      name: name ?? this.name,
      conditionUuid: conditionUuid ?? this.conditionUuid,
      actionUuid: actionUuid ?? this.actionUuid,
      targetUuid: targetUuid ?? this.targetUuid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<int>(ownerId.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (conditionUuid.present) {
      map['condition_uuid'] = Variable<String>(conditionUuid.value);
    }
    if (actionUuid.present) {
      map['action_uuid'] = Variable<String>(actionUuid.value);
    }
    if (targetUuid.present) {
      map['target_uuid'] = Variable<String>(targetUuid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BattleRulesCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('priority: $priority, ')
          ..write('name: $name, ')
          ..write('conditionUuid: $conditionUuid, ')
          ..write('actionUuid: $actionUuid, ')
          ..write('targetUuid: $targetUuid')
          ..write(')'))
        .toString();
  }
}

class $GameStatesTable extends GameStates
    with TableInfo<$GameStatesTable, GameState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _goldMeta = const VerificationMeta('gold');
  @override
  late final GeneratedColumn<int> gold = GeneratedColumn<int>(
      'gold', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _maxReachedFloorMeta =
      const VerificationMeta('maxReachedFloor');
  @override
  late final GeneratedColumn<int> maxReachedFloor = GeneratedColumn<int>(
      'max_reached_floor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _activeFloorMeta =
      const VerificationMeta('activeFloor');
  @override
  late final GeneratedColumn<int> activeFloor = GeneratedColumn<int>(
      'active_floor', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _battleCountOnFloorMeta =
      const VerificationMeta('battleCountOnFloor');
  @override
  late final GeneratedColumn<int> battleCountOnFloor = GeneratedColumn<int>(
      'battle_count_on_floor', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _battlesToUnlockNextFloorMeta =
      const VerificationMeta('battlesToUnlockNextFloor');
  @override
  late final GeneratedColumn<int> battlesToUnlockNextFloor =
      GeneratedColumn<int>('battles_to_unlock_next_floor', aliasedName, false,
          type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _eventLogMeta =
      const VerificationMeta('eventLog');
  @override
  late final GeneratedColumn<String> eventLog = GeneratedColumn<String>(
      'event_log', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isPausedMeta =
      const VerificationMeta('isPaused');
  @override
  late final GeneratedColumn<int> isPaused = GeneratedColumn<int>(
      'is_paused', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _seedMeta = const VerificationMeta('seed');
  @override
  late final GeneratedColumn<String> seed = GeneratedColumn<String>(
      'seed', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        gold,
        maxReachedFloor,
        activeFloor,
        battleCountOnFloor,
        battlesToUnlockNextFloor,
        eventLog,
        isPaused,
        seed
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_state';
  @override
  VerificationContext validateIntegrity(Insertable<GameState> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gold')) {
      context.handle(
          _goldMeta, gold.isAcceptableOrUnknown(data['gold']!, _goldMeta));
    } else if (isInserting) {
      context.missing(_goldMeta);
    }
    if (data.containsKey('max_reached_floor')) {
      context.handle(
          _maxReachedFloorMeta,
          maxReachedFloor.isAcceptableOrUnknown(
              data['max_reached_floor']!, _maxReachedFloorMeta));
    } else if (isInserting) {
      context.missing(_maxReachedFloorMeta);
    }
    if (data.containsKey('active_floor')) {
      context.handle(
          _activeFloorMeta,
          activeFloor.isAcceptableOrUnknown(
              data['active_floor']!, _activeFloorMeta));
    }
    if (data.containsKey('battle_count_on_floor')) {
      context.handle(
          _battleCountOnFloorMeta,
          battleCountOnFloor.isAcceptableOrUnknown(
              data['battle_count_on_floor']!, _battleCountOnFloorMeta));
    } else if (isInserting) {
      context.missing(_battleCountOnFloorMeta);
    }
    if (data.containsKey('battles_to_unlock_next_floor')) {
      context.handle(
          _battlesToUnlockNextFloorMeta,
          battlesToUnlockNextFloor.isAcceptableOrUnknown(
              data['battles_to_unlock_next_floor']!,
              _battlesToUnlockNextFloorMeta));
    } else if (isInserting) {
      context.missing(_battlesToUnlockNextFloorMeta);
    }
    if (data.containsKey('event_log')) {
      context.handle(_eventLogMeta,
          eventLog.isAcceptableOrUnknown(data['event_log']!, _eventLogMeta));
    }
    if (data.containsKey('is_paused')) {
      context.handle(_isPausedMeta,
          isPaused.isAcceptableOrUnknown(data['is_paused']!, _isPausedMeta));
    }
    if (data.containsKey('seed')) {
      context.handle(
          _seedMeta, seed.isAcceptableOrUnknown(data['seed']!, _seedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameState(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      gold: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gold'])!,
      maxReachedFloor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_reached_floor'])!,
      activeFloor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}active_floor']),
      battleCountOnFloor: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}battle_count_on_floor'])!,
      battlesToUnlockNextFloor: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}battles_to_unlock_next_floor'])!,
      eventLog: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_log']),
      isPaused: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}is_paused'])!,
      seed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}seed']),
    );
  }

  @override
  $GameStatesTable createAlias(String alias) {
    return $GameStatesTable(attachedDatabase, alias);
  }
}

class GameState extends DataClass implements Insertable<GameState> {
  final int id;
  final int gold;
  final int maxReachedFloor;
  final int? activeFloor;
  final int battleCountOnFloor;
  final int battlesToUnlockNextFloor;
  final String? eventLog;
  final int isPaused;
  final String? seed;
  const GameState(
      {required this.id,
      required this.gold,
      required this.maxReachedFloor,
      this.activeFloor,
      required this.battleCountOnFloor,
      required this.battlesToUnlockNextFloor,
      this.eventLog,
      required this.isPaused,
      this.seed});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gold'] = Variable<int>(gold);
    map['max_reached_floor'] = Variable<int>(maxReachedFloor);
    if (!nullToAbsent || activeFloor != null) {
      map['active_floor'] = Variable<int>(activeFloor);
    }
    map['battle_count_on_floor'] = Variable<int>(battleCountOnFloor);
    map['battles_to_unlock_next_floor'] =
        Variable<int>(battlesToUnlockNextFloor);
    if (!nullToAbsent || eventLog != null) {
      map['event_log'] = Variable<String>(eventLog);
    }
    map['is_paused'] = Variable<int>(isPaused);
    if (!nullToAbsent || seed != null) {
      map['seed'] = Variable<String>(seed);
    }
    return map;
  }

  GameStatesCompanion toCompanion(bool nullToAbsent) {
    return GameStatesCompanion(
      id: Value(id),
      gold: Value(gold),
      maxReachedFloor: Value(maxReachedFloor),
      activeFloor: activeFloor == null && nullToAbsent
          ? const Value.absent()
          : Value(activeFloor),
      battleCountOnFloor: Value(battleCountOnFloor),
      battlesToUnlockNextFloor: Value(battlesToUnlockNextFloor),
      eventLog: eventLog == null && nullToAbsent
          ? const Value.absent()
          : Value(eventLog),
      isPaused: Value(isPaused),
      seed: seed == null && nullToAbsent ? const Value.absent() : Value(seed),
    );
  }

  factory GameState.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameState(
      id: serializer.fromJson<int>(json['id']),
      gold: serializer.fromJson<int>(json['gold']),
      maxReachedFloor: serializer.fromJson<int>(json['maxReachedFloor']),
      activeFloor: serializer.fromJson<int?>(json['activeFloor']),
      battleCountOnFloor: serializer.fromJson<int>(json['battleCountOnFloor']),
      battlesToUnlockNextFloor:
          serializer.fromJson<int>(json['battlesToUnlockNextFloor']),
      eventLog: serializer.fromJson<String?>(json['eventLog']),
      isPaused: serializer.fromJson<int>(json['isPaused']),
      seed: serializer.fromJson<String?>(json['seed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gold': serializer.toJson<int>(gold),
      'maxReachedFloor': serializer.toJson<int>(maxReachedFloor),
      'activeFloor': serializer.toJson<int?>(activeFloor),
      'battleCountOnFloor': serializer.toJson<int>(battleCountOnFloor),
      'battlesToUnlockNextFloor':
          serializer.toJson<int>(battlesToUnlockNextFloor),
      'eventLog': serializer.toJson<String?>(eventLog),
      'isPaused': serializer.toJson<int>(isPaused),
      'seed': serializer.toJson<String?>(seed),
    };
  }

  GameState copyWith(
          {int? id,
          int? gold,
          int? maxReachedFloor,
          Value<int?> activeFloor = const Value.absent(),
          int? battleCountOnFloor,
          int? battlesToUnlockNextFloor,
          Value<String?> eventLog = const Value.absent(),
          int? isPaused,
          Value<String?> seed = const Value.absent()}) =>
      GameState(
        id: id ?? this.id,
        gold: gold ?? this.gold,
        maxReachedFloor: maxReachedFloor ?? this.maxReachedFloor,
        activeFloor: activeFloor.present ? activeFloor.value : this.activeFloor,
        battleCountOnFloor: battleCountOnFloor ?? this.battleCountOnFloor,
        battlesToUnlockNextFloor:
            battlesToUnlockNextFloor ?? this.battlesToUnlockNextFloor,
        eventLog: eventLog.present ? eventLog.value : this.eventLog,
        isPaused: isPaused ?? this.isPaused,
        seed: seed.present ? seed.value : this.seed,
      );
  GameState copyWithCompanion(GameStatesCompanion data) {
    return GameState(
      id: data.id.present ? data.id.value : this.id,
      gold: data.gold.present ? data.gold.value : this.gold,
      maxReachedFloor: data.maxReachedFloor.present
          ? data.maxReachedFloor.value
          : this.maxReachedFloor,
      activeFloor:
          data.activeFloor.present ? data.activeFloor.value : this.activeFloor,
      battleCountOnFloor: data.battleCountOnFloor.present
          ? data.battleCountOnFloor.value
          : this.battleCountOnFloor,
      battlesToUnlockNextFloor: data.battlesToUnlockNextFloor.present
          ? data.battlesToUnlockNextFloor.value
          : this.battlesToUnlockNextFloor,
      eventLog: data.eventLog.present ? data.eventLog.value : this.eventLog,
      isPaused: data.isPaused.present ? data.isPaused.value : this.isPaused,
      seed: data.seed.present ? data.seed.value : this.seed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameState(')
          ..write('id: $id, ')
          ..write('gold: $gold, ')
          ..write('maxReachedFloor: $maxReachedFloor, ')
          ..write('activeFloor: $activeFloor, ')
          ..write('battleCountOnFloor: $battleCountOnFloor, ')
          ..write('battlesToUnlockNextFloor: $battlesToUnlockNextFloor, ')
          ..write('eventLog: $eventLog, ')
          ..write('isPaused: $isPaused, ')
          ..write('seed: $seed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, gold, maxReachedFloor, activeFloor,
      battleCountOnFloor, battlesToUnlockNextFloor, eventLog, isPaused, seed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameState &&
          other.id == this.id &&
          other.gold == this.gold &&
          other.maxReachedFloor == this.maxReachedFloor &&
          other.activeFloor == this.activeFloor &&
          other.battleCountOnFloor == this.battleCountOnFloor &&
          other.battlesToUnlockNextFloor == this.battlesToUnlockNextFloor &&
          other.eventLog == this.eventLog &&
          other.isPaused == this.isPaused &&
          other.seed == this.seed);
}

class GameStatesCompanion extends UpdateCompanion<GameState> {
  final Value<int> id;
  final Value<int> gold;
  final Value<int> maxReachedFloor;
  final Value<int?> activeFloor;
  final Value<int> battleCountOnFloor;
  final Value<int> battlesToUnlockNextFloor;
  final Value<String?> eventLog;
  final Value<int> isPaused;
  final Value<String?> seed;
  const GameStatesCompanion({
    this.id = const Value.absent(),
    this.gold = const Value.absent(),
    this.maxReachedFloor = const Value.absent(),
    this.activeFloor = const Value.absent(),
    this.battleCountOnFloor = const Value.absent(),
    this.battlesToUnlockNextFloor = const Value.absent(),
    this.eventLog = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.seed = const Value.absent(),
  });
  GameStatesCompanion.insert({
    this.id = const Value.absent(),
    required int gold,
    required int maxReachedFloor,
    this.activeFloor = const Value.absent(),
    required int battleCountOnFloor,
    required int battlesToUnlockNextFloor,
    this.eventLog = const Value.absent(),
    this.isPaused = const Value.absent(),
    this.seed = const Value.absent(),
  })  : gold = Value(gold),
        maxReachedFloor = Value(maxReachedFloor),
        battleCountOnFloor = Value(battleCountOnFloor),
        battlesToUnlockNextFloor = Value(battlesToUnlockNextFloor);
  static Insertable<GameState> custom({
    Expression<int>? id,
    Expression<int>? gold,
    Expression<int>? maxReachedFloor,
    Expression<int>? activeFloor,
    Expression<int>? battleCountOnFloor,
    Expression<int>? battlesToUnlockNextFloor,
    Expression<String>? eventLog,
    Expression<int>? isPaused,
    Expression<String>? seed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gold != null) 'gold': gold,
      if (maxReachedFloor != null) 'max_reached_floor': maxReachedFloor,
      if (activeFloor != null) 'active_floor': activeFloor,
      if (battleCountOnFloor != null)
        'battle_count_on_floor': battleCountOnFloor,
      if (battlesToUnlockNextFloor != null)
        'battles_to_unlock_next_floor': battlesToUnlockNextFloor,
      if (eventLog != null) 'event_log': eventLog,
      if (isPaused != null) 'is_paused': isPaused,
      if (seed != null) 'seed': seed,
    });
  }

  GameStatesCompanion copyWith(
      {Value<int>? id,
      Value<int>? gold,
      Value<int>? maxReachedFloor,
      Value<int?>? activeFloor,
      Value<int>? battleCountOnFloor,
      Value<int>? battlesToUnlockNextFloor,
      Value<String?>? eventLog,
      Value<int>? isPaused,
      Value<String?>? seed}) {
    return GameStatesCompanion(
      id: id ?? this.id,
      gold: gold ?? this.gold,
      maxReachedFloor: maxReachedFloor ?? this.maxReachedFloor,
      activeFloor: activeFloor ?? this.activeFloor,
      battleCountOnFloor: battleCountOnFloor ?? this.battleCountOnFloor,
      battlesToUnlockNextFloor:
          battlesToUnlockNextFloor ?? this.battlesToUnlockNextFloor,
      eventLog: eventLog ?? this.eventLog,
      isPaused: isPaused ?? this.isPaused,
      seed: seed ?? this.seed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gold.present) {
      map['gold'] = Variable<int>(gold.value);
    }
    if (maxReachedFloor.present) {
      map['max_reached_floor'] = Variable<int>(maxReachedFloor.value);
    }
    if (activeFloor.present) {
      map['active_floor'] = Variable<int>(activeFloor.value);
    }
    if (battleCountOnFloor.present) {
      map['battle_count_on_floor'] = Variable<int>(battleCountOnFloor.value);
    }
    if (battlesToUnlockNextFloor.present) {
      map['battles_to_unlock_next_floor'] =
          Variable<int>(battlesToUnlockNextFloor.value);
    }
    if (eventLog.present) {
      map['event_log'] = Variable<String>(eventLog.value);
    }
    if (isPaused.present) {
      map['is_paused'] = Variable<int>(isPaused.value);
    }
    if (seed.present) {
      map['seed'] = Variable<String>(seed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameStatesCompanion(')
          ..write('id: $id, ')
          ..write('gold: $gold, ')
          ..write('maxReachedFloor: $maxReachedFloor, ')
          ..write('activeFloor: $activeFloor, ')
          ..write('battleCountOnFloor: $battleCountOnFloor, ')
          ..write('battlesToUnlockNextFloor: $battlesToUnlockNextFloor, ')
          ..write('eventLog: $eventLog, ')
          ..write('isPaused: $isPaused, ')
          ..write('seed: $seed')
          ..write(')'))
        .toString();
  }
}

class $CharacterInventoriesTable extends CharacterInventories
    with TableInfo<$CharacterInventoriesTable, CharacterInventory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterInventoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _characterIdMeta =
      const VerificationMeta('characterId');
  @override
  late final GeneratedColumn<int> characterId = GeneratedColumn<int>(
      'character_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES character (id)'));
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, characterId, itemId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_inventory';
  @override
  VerificationContext validateIntegrity(Insertable<CharacterInventory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('character_id')) {
      context.handle(
          _characterIdMeta,
          characterId.isAcceptableOrUnknown(
              data['character_id']!, _characterIdMeta));
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CharacterInventory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterInventory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      characterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}character_id'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
    );
  }

  @override
  $CharacterInventoriesTable createAlias(String alias) {
    return $CharacterInventoriesTable(attachedDatabase, alias);
  }
}

class CharacterInventory extends DataClass
    implements Insertable<CharacterInventory> {
  final int id;
  final int characterId;
  final String itemId;
  const CharacterInventory(
      {required this.id, required this.characterId, required this.itemId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['character_id'] = Variable<int>(characterId);
    map['item_id'] = Variable<String>(itemId);
    return map;
  }

  CharacterInventoriesCompanion toCompanion(bool nullToAbsent) {
    return CharacterInventoriesCompanion(
      id: Value(id),
      characterId: Value(characterId),
      itemId: Value(itemId),
    );
  }

  factory CharacterInventory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterInventory(
      id: serializer.fromJson<int>(json['id']),
      characterId: serializer.fromJson<int>(json['characterId']),
      itemId: serializer.fromJson<String>(json['itemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'characterId': serializer.toJson<int>(characterId),
      'itemId': serializer.toJson<String>(itemId),
    };
  }

  CharacterInventory copyWith({int? id, int? characterId, String? itemId}) =>
      CharacterInventory(
        id: id ?? this.id,
        characterId: characterId ?? this.characterId,
        itemId: itemId ?? this.itemId,
      );
  CharacterInventory copyWithCompanion(CharacterInventoriesCompanion data) {
    return CharacterInventory(
      id: data.id.present ? data.id.value : this.id,
      characterId:
          data.characterId.present ? data.characterId.value : this.characterId,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterInventory(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('itemId: $itemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, characterId, itemId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterInventory &&
          other.id == this.id &&
          other.characterId == this.characterId &&
          other.itemId == this.itemId);
}

class CharacterInventoriesCompanion
    extends UpdateCompanion<CharacterInventory> {
  final Value<int> id;
  final Value<int> characterId;
  final Value<String> itemId;
  const CharacterInventoriesCompanion({
    this.id = const Value.absent(),
    this.characterId = const Value.absent(),
    this.itemId = const Value.absent(),
  });
  CharacterInventoriesCompanion.insert({
    this.id = const Value.absent(),
    required int characterId,
    required String itemId,
  })  : characterId = Value(characterId),
        itemId = Value(itemId);
  static Insertable<CharacterInventory> custom({
    Expression<int>? id,
    Expression<int>? characterId,
    Expression<String>? itemId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (characterId != null) 'character_id': characterId,
      if (itemId != null) 'item_id': itemId,
    });
  }

  CharacterInventoriesCompanion copyWith(
      {Value<int>? id, Value<int>? characterId, Value<String>? itemId}) {
    return CharacterInventoriesCompanion(
      id: id ?? this.id,
      characterId: characterId ?? this.characterId,
      itemId: itemId ?? this.itemId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (characterId.present) {
      map['character_id'] = Variable<int>(characterId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterInventoriesCompanion(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('itemId: $itemId')
          ..write(')'))
        .toString();
  }
}

class $CharacterEquipmentsTable extends CharacterEquipments
    with TableInfo<$CharacterEquipmentsTable, CharacterEquipment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterEquipmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _characterIdMeta =
      const VerificationMeta('characterId');
  @override
  late final GeneratedColumn<int> characterId = GeneratedColumn<int>(
      'character_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES character (id)'));
  static const VerificationMeta _slotMeta = const VerificationMeta('slot');
  @override
  late final GeneratedColumn<String> slot = GeneratedColumn<String>(
      'slot', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
      'item_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, characterId, slot, itemId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_equipment';
  @override
  VerificationContext validateIntegrity(Insertable<CharacterEquipment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('character_id')) {
      context.handle(
          _characterIdMeta,
          characterId.isAcceptableOrUnknown(
              data['character_id']!, _characterIdMeta));
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('slot')) {
      context.handle(
          _slotMeta, slot.isAcceptableOrUnknown(data['slot']!, _slotMeta));
    } else if (isInserting) {
      context.missing(_slotMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CharacterEquipment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterEquipment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      characterId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}character_id'])!,
      slot: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slot'])!,
      itemId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_id'])!,
    );
  }

  @override
  $CharacterEquipmentsTable createAlias(String alias) {
    return $CharacterEquipmentsTable(attachedDatabase, alias);
  }
}

class CharacterEquipment extends DataClass
    implements Insertable<CharacterEquipment> {
  final int id;
  final int characterId;
  final String slot;
  final String itemId;
  const CharacterEquipment(
      {required this.id,
      required this.characterId,
      required this.slot,
      required this.itemId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['character_id'] = Variable<int>(characterId);
    map['slot'] = Variable<String>(slot);
    map['item_id'] = Variable<String>(itemId);
    return map;
  }

  CharacterEquipmentsCompanion toCompanion(bool nullToAbsent) {
    return CharacterEquipmentsCompanion(
      id: Value(id),
      characterId: Value(characterId),
      slot: Value(slot),
      itemId: Value(itemId),
    );
  }

  factory CharacterEquipment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterEquipment(
      id: serializer.fromJson<int>(json['id']),
      characterId: serializer.fromJson<int>(json['characterId']),
      slot: serializer.fromJson<String>(json['slot']),
      itemId: serializer.fromJson<String>(json['itemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'characterId': serializer.toJson<int>(characterId),
      'slot': serializer.toJson<String>(slot),
      'itemId': serializer.toJson<String>(itemId),
    };
  }

  CharacterEquipment copyWith(
          {int? id, int? characterId, String? slot, String? itemId}) =>
      CharacterEquipment(
        id: id ?? this.id,
        characterId: characterId ?? this.characterId,
        slot: slot ?? this.slot,
        itemId: itemId ?? this.itemId,
      );
  CharacterEquipment copyWithCompanion(CharacterEquipmentsCompanion data) {
    return CharacterEquipment(
      id: data.id.present ? data.id.value : this.id,
      characterId:
          data.characterId.present ? data.characterId.value : this.characterId,
      slot: data.slot.present ? data.slot.value : this.slot,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterEquipment(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('slot: $slot, ')
          ..write('itemId: $itemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, characterId, slot, itemId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterEquipment &&
          other.id == this.id &&
          other.characterId == this.characterId &&
          other.slot == this.slot &&
          other.itemId == this.itemId);
}

class CharacterEquipmentsCompanion extends UpdateCompanion<CharacterEquipment> {
  final Value<int> id;
  final Value<int> characterId;
  final Value<String> slot;
  final Value<String> itemId;
  const CharacterEquipmentsCompanion({
    this.id = const Value.absent(),
    this.characterId = const Value.absent(),
    this.slot = const Value.absent(),
    this.itemId = const Value.absent(),
  });
  CharacterEquipmentsCompanion.insert({
    this.id = const Value.absent(),
    required int characterId,
    required String slot,
    required String itemId,
  })  : characterId = Value(characterId),
        slot = Value(slot),
        itemId = Value(itemId);
  static Insertable<CharacterEquipment> custom({
    Expression<int>? id,
    Expression<int>? characterId,
    Expression<String>? slot,
    Expression<String>? itemId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (characterId != null) 'character_id': characterId,
      if (slot != null) 'slot': slot,
      if (itemId != null) 'item_id': itemId,
    });
  }

  CharacterEquipmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? characterId,
      Value<String>? slot,
      Value<String>? itemId}) {
    return CharacterEquipmentsCompanion(
      id: id ?? this.id,
      characterId: characterId ?? this.characterId,
      slot: slot ?? this.slot,
      itemId: itemId ?? this.itemId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (characterId.present) {
      map['character_id'] = Variable<int>(characterId.value);
    }
    if (slot.present) {
      map['slot'] = Variable<String>(slot.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterEquipmentsCompanion(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('slot: $slot, ')
          ..write('itemId: $itemId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CharactersTable characters = $CharactersTable(this);
  late final $StatusParametersTable statusParameters =
      $StatusParametersTable(this);
  late final $BattleRulesTable battleRules = $BattleRulesTable(this);
  late final $GameStatesTable gameStates = $GameStatesTable(this);
  late final $CharacterInventoriesTable characterInventories =
      $CharacterInventoriesTable(this);
  late final $CharacterEquipmentsTable characterEquipments =
      $CharacterEquipmentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        characters,
        statusParameters,
        battleRules,
        gameStates,
        characterInventories,
        characterEquipments
      ];
}

typedef $$CharactersTableCreateCompanionBuilder = CharactersCompanion Function({
  Value<int> id,
  required String name,
  required int level,
  required int maxHp,
  required int maxMp,
  required int hp,
  required int mp,
  required int attack,
  required int defense,
  required int magicPower,
  required int speed,
  Value<int?> jobId,
  Value<int> exp,
  Value<int> isActive,
  Value<int?> partyPosition,
  Value<String?> jobBonus,
});
typedef $$CharactersTableUpdateCompanionBuilder = CharactersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> level,
  Value<int> maxHp,
  Value<int> maxMp,
  Value<int> hp,
  Value<int> mp,
  Value<int> attack,
  Value<int> defense,
  Value<int> magicPower,
  Value<int> speed,
  Value<int?> jobId,
  Value<int> exp,
  Value<int> isActive,
  Value<int?> partyPosition,
  Value<String?> jobBonus,
});

final class $$CharactersTableReferences
    extends BaseReferences<_$AppDatabase, $CharactersTable, Character> {
  $$CharactersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StatusParametersTable, List<StatusParameter>>
      _statusParametersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.statusParameters,
              aliasName: $_aliasNameGenerator(
                  db.characters.id, db.statusParameters.characterId));

  $$StatusParametersTableProcessedTableManager get statusParametersRefs {
    final manager = $$StatusParametersTableTableManager(
            $_db, $_db.statusParameters)
        .filter((f) => f.characterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_statusParametersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$BattleRulesTable, List<BattleRule>>
      _battleRulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.battleRules,
          aliasName:
              $_aliasNameGenerator(db.characters.id, db.battleRules.ownerId));

  $$BattleRulesTableProcessedTableManager get battleRulesRefs {
    final manager = $$BattleRulesTableTableManager($_db, $_db.battleRules)
        .filter((f) => f.ownerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_battleRulesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CharacterInventoriesTable,
      List<CharacterInventory>> _characterInventoriesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.characterInventories,
          aliasName: $_aliasNameGenerator(
              db.characters.id, db.characterInventories.characterId));

  $$CharacterInventoriesTableProcessedTableManager
      get characterInventoriesRefs {
    final manager = $$CharacterInventoriesTableTableManager(
            $_db, $_db.characterInventories)
        .filter((f) => f.characterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_characterInventoriesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CharacterEquipmentsTable,
      List<CharacterEquipment>> _characterEquipmentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.characterEquipments,
          aliasName: $_aliasNameGenerator(
              db.characters.id, db.characterEquipments.characterId));

  $$CharacterEquipmentsTableProcessedTableManager get characterEquipmentsRefs {
    final manager = $$CharacterEquipmentsTableTableManager(
            $_db, $_db.characterEquipments)
        .filter((f) => f.characterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_characterEquipmentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CharactersTableFilterComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxHp => $composableBuilder(
      column: $table.maxHp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxMp => $composableBuilder(
      column: $table.maxMp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get hp => $composableBuilder(
      column: $table.hp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mp => $composableBuilder(
      column: $table.mp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get attack => $composableBuilder(
      column: $table.attack, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get defense => $composableBuilder(
      column: $table.defense, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get magicPower => $composableBuilder(
      column: $table.magicPower, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get speed => $composableBuilder(
      column: $table.speed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get jobId => $composableBuilder(
      column: $table.jobId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get exp => $composableBuilder(
      column: $table.exp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get partyPosition => $composableBuilder(
      column: $table.partyPosition, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jobBonus => $composableBuilder(
      column: $table.jobBonus, builder: (column) => ColumnFilters(column));

  Expression<bool> statusParametersRefs(
      Expression<bool> Function($$StatusParametersTableFilterComposer f) f) {
    final $$StatusParametersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.statusParameters,
        getReferencedColumn: (t) => t.characterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StatusParametersTableFilterComposer(
              $db: $db,
              $table: $db.statusParameters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> battleRulesRefs(
      Expression<bool> Function($$BattleRulesTableFilterComposer f) f) {
    final $$BattleRulesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.battleRules,
        getReferencedColumn: (t) => t.ownerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BattleRulesTableFilterComposer(
              $db: $db,
              $table: $db.battleRules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> characterInventoriesRefs(
      Expression<bool> Function($$CharacterInventoriesTableFilterComposer f)
          f) {
    final $$CharacterInventoriesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.characterInventories,
        getReferencedColumn: (t) => t.characterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharacterInventoriesTableFilterComposer(
              $db: $db,
              $table: $db.characterInventories,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> characterEquipmentsRefs(
      Expression<bool> Function($$CharacterEquipmentsTableFilterComposer f) f) {
    final $$CharacterEquipmentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.characterEquipments,
        getReferencedColumn: (t) => t.characterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharacterEquipmentsTableFilterComposer(
              $db: $db,
              $table: $db.characterEquipments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CharactersTableOrderingComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxHp => $composableBuilder(
      column: $table.maxHp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxMp => $composableBuilder(
      column: $table.maxMp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get hp => $composableBuilder(
      column: $table.hp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mp => $composableBuilder(
      column: $table.mp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get attack => $composableBuilder(
      column: $table.attack, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get defense => $composableBuilder(
      column: $table.defense, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get magicPower => $composableBuilder(
      column: $table.magicPower, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get speed => $composableBuilder(
      column: $table.speed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get jobId => $composableBuilder(
      column: $table.jobId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get exp => $composableBuilder(
      column: $table.exp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get partyPosition => $composableBuilder(
      column: $table.partyPosition,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jobBonus => $composableBuilder(
      column: $table.jobBonus, builder: (column) => ColumnOrderings(column));
}

class $$CharactersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get maxHp =>
      $composableBuilder(column: $table.maxHp, builder: (column) => column);

  GeneratedColumn<int> get maxMp =>
      $composableBuilder(column: $table.maxMp, builder: (column) => column);

  GeneratedColumn<int> get hp =>
      $composableBuilder(column: $table.hp, builder: (column) => column);

  GeneratedColumn<int> get mp =>
      $composableBuilder(column: $table.mp, builder: (column) => column);

  GeneratedColumn<int> get attack =>
      $composableBuilder(column: $table.attack, builder: (column) => column);

  GeneratedColumn<int> get defense =>
      $composableBuilder(column: $table.defense, builder: (column) => column);

  GeneratedColumn<int> get magicPower => $composableBuilder(
      column: $table.magicPower, builder: (column) => column);

  GeneratedColumn<int> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<int> get jobId =>
      $composableBuilder(column: $table.jobId, builder: (column) => column);

  GeneratedColumn<int> get exp =>
      $composableBuilder(column: $table.exp, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get partyPosition => $composableBuilder(
      column: $table.partyPosition, builder: (column) => column);

  GeneratedColumn<String> get jobBonus =>
      $composableBuilder(column: $table.jobBonus, builder: (column) => column);

  Expression<T> statusParametersRefs<T extends Object>(
      Expression<T> Function($$StatusParametersTableAnnotationComposer a) f) {
    final $$StatusParametersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.statusParameters,
        getReferencedColumn: (t) => t.characterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StatusParametersTableAnnotationComposer(
              $db: $db,
              $table: $db.statusParameters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> battleRulesRefs<T extends Object>(
      Expression<T> Function($$BattleRulesTableAnnotationComposer a) f) {
    final $$BattleRulesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.battleRules,
        getReferencedColumn: (t) => t.ownerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$BattleRulesTableAnnotationComposer(
              $db: $db,
              $table: $db.battleRules,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> characterInventoriesRefs<T extends Object>(
      Expression<T> Function($$CharacterInventoriesTableAnnotationComposer a)
          f) {
    final $$CharacterInventoriesTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.characterInventories,
            getReferencedColumn: (t) => t.characterId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CharacterInventoriesTableAnnotationComposer(
                  $db: $db,
                  $table: $db.characterInventories,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> characterEquipmentsRefs<T extends Object>(
      Expression<T> Function($$CharacterEquipmentsTableAnnotationComposer a)
          f) {
    final $$CharacterEquipmentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.characterEquipments,
            getReferencedColumn: (t) => t.characterId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CharacterEquipmentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.characterEquipments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CharactersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CharactersTable,
    Character,
    $$CharactersTableFilterComposer,
    $$CharactersTableOrderingComposer,
    $$CharactersTableAnnotationComposer,
    $$CharactersTableCreateCompanionBuilder,
    $$CharactersTableUpdateCompanionBuilder,
    (Character, $$CharactersTableReferences),
    Character,
    PrefetchHooks Function(
        {bool statusParametersRefs,
        bool battleRulesRefs,
        bool characterInventoriesRefs,
        bool characterEquipmentsRefs})> {
  $$CharactersTableTableManager(_$AppDatabase db, $CharactersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharactersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharactersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharactersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> maxHp = const Value.absent(),
            Value<int> maxMp = const Value.absent(),
            Value<int> hp = const Value.absent(),
            Value<int> mp = const Value.absent(),
            Value<int> attack = const Value.absent(),
            Value<int> defense = const Value.absent(),
            Value<int> magicPower = const Value.absent(),
            Value<int> speed = const Value.absent(),
            Value<int?> jobId = const Value.absent(),
            Value<int> exp = const Value.absent(),
            Value<int> isActive = const Value.absent(),
            Value<int?> partyPosition = const Value.absent(),
            Value<String?> jobBonus = const Value.absent(),
          }) =>
              CharactersCompanion(
            id: id,
            name: name,
            level: level,
            maxHp: maxHp,
            maxMp: maxMp,
            hp: hp,
            mp: mp,
            attack: attack,
            defense: defense,
            magicPower: magicPower,
            speed: speed,
            jobId: jobId,
            exp: exp,
            isActive: isActive,
            partyPosition: partyPosition,
            jobBonus: jobBonus,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int level,
            required int maxHp,
            required int maxMp,
            required int hp,
            required int mp,
            required int attack,
            required int defense,
            required int magicPower,
            required int speed,
            Value<int?> jobId = const Value.absent(),
            Value<int> exp = const Value.absent(),
            Value<int> isActive = const Value.absent(),
            Value<int?> partyPosition = const Value.absent(),
            Value<String?> jobBonus = const Value.absent(),
          }) =>
              CharactersCompanion.insert(
            id: id,
            name: name,
            level: level,
            maxHp: maxHp,
            maxMp: maxMp,
            hp: hp,
            mp: mp,
            attack: attack,
            defense: defense,
            magicPower: magicPower,
            speed: speed,
            jobId: jobId,
            exp: exp,
            isActive: isActive,
            partyPosition: partyPosition,
            jobBonus: jobBonus,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CharactersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {statusParametersRefs = false,
              battleRulesRefs = false,
              characterInventoriesRefs = false,
              characterEquipmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (statusParametersRefs) db.statusParameters,
                if (battleRulesRefs) db.battleRules,
                if (characterInventoriesRefs) db.characterInventories,
                if (characterEquipmentsRefs) db.characterEquipments
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (statusParametersRefs)
                    await $_getPrefetchedData<Character, $CharactersTable,
                            StatusParameter>(
                        currentTable: table,
                        referencedTable: $$CharactersTableReferences
                            ._statusParametersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CharactersTableReferences(db, table, p0)
                                .statusParametersRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.characterId == item.id),
                        typedResults: items),
                  if (battleRulesRefs)
                    await $_getPrefetchedData<Character, $CharactersTable,
                            BattleRule>(
                        currentTable: table,
                        referencedTable: $$CharactersTableReferences
                            ._battleRulesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CharactersTableReferences(db, table, p0)
                                .battleRulesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.ownerId == item.id),
                        typedResults: items),
                  if (characterInventoriesRefs)
                    await $_getPrefetchedData<Character, $CharactersTable,
                            CharacterInventory>(
                        currentTable: table,
                        referencedTable: $$CharactersTableReferences
                            ._characterInventoriesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CharactersTableReferences(db, table, p0)
                                .characterInventoriesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.characterId == item.id),
                        typedResults: items),
                  if (characterEquipmentsRefs)
                    await $_getPrefetchedData<Character, $CharactersTable,
                            CharacterEquipment>(
                        currentTable: table,
                        referencedTable: $$CharactersTableReferences
                            ._characterEquipmentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CharactersTableReferences(db, table, p0)
                                .characterEquipmentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.characterId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CharactersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CharactersTable,
    Character,
    $$CharactersTableFilterComposer,
    $$CharactersTableOrderingComposer,
    $$CharactersTableAnnotationComposer,
    $$CharactersTableCreateCompanionBuilder,
    $$CharactersTableUpdateCompanionBuilder,
    (Character, $$CharactersTableReferences),
    Character,
    PrefetchHooks Function(
        {bool statusParametersRefs,
        bool battleRulesRefs,
        bool characterInventoriesRefs,
        bool characterEquipmentsRefs})>;
typedef $$StatusParametersTableCreateCompanionBuilder
    = StatusParametersCompanion Function({
  Value<int> id,
  required String name,
  required int characterId,
});
typedef $$StatusParametersTableUpdateCompanionBuilder
    = StatusParametersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> characterId,
});

final class $$StatusParametersTableReferences extends BaseReferences<
    _$AppDatabase, $StatusParametersTable, StatusParameter> {
  $$StatusParametersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias($_aliasNameGenerator(
          db.statusParameters.characterId, db.characters.id));

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<int>('character_id')!;

    final manager = $$CharactersTableTableManager($_db, $_db.characters)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StatusParametersTableFilterComposer
    extends Composer<_$AppDatabase, $StatusParametersTable> {
  $$StatusParametersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.characterId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableFilterComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StatusParametersTableOrderingComposer
    extends Composer<_$AppDatabase, $StatusParametersTable> {
  $$StatusParametersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.characterId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableOrderingComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StatusParametersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StatusParametersTable> {
  $$StatusParametersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.characterId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableAnnotationComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StatusParametersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StatusParametersTable,
    StatusParameter,
    $$StatusParametersTableFilterComposer,
    $$StatusParametersTableOrderingComposer,
    $$StatusParametersTableAnnotationComposer,
    $$StatusParametersTableCreateCompanionBuilder,
    $$StatusParametersTableUpdateCompanionBuilder,
    (StatusParameter, $$StatusParametersTableReferences),
    StatusParameter,
    PrefetchHooks Function({bool characterId})> {
  $$StatusParametersTableTableManager(
      _$AppDatabase db, $StatusParametersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StatusParametersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StatusParametersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StatusParametersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> characterId = const Value.absent(),
          }) =>
              StatusParametersCompanion(
            id: id,
            name: name,
            characterId: characterId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int characterId,
          }) =>
              StatusParametersCompanion.insert(
            id: id,
            name: name,
            characterId: characterId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$StatusParametersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (characterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.characterId,
                    referencedTable:
                        $$StatusParametersTableReferences._characterIdTable(db),
                    referencedColumn: $$StatusParametersTableReferences
                        ._characterIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$StatusParametersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StatusParametersTable,
    StatusParameter,
    $$StatusParametersTableFilterComposer,
    $$StatusParametersTableOrderingComposer,
    $$StatusParametersTableAnnotationComposer,
    $$StatusParametersTableCreateCompanionBuilder,
    $$StatusParametersTableUpdateCompanionBuilder,
    (StatusParameter, $$StatusParametersTableReferences),
    StatusParameter,
    PrefetchHooks Function({bool characterId})>;
typedef $$BattleRulesTableCreateCompanionBuilder = BattleRulesCompanion
    Function({
  Value<int> id,
  required int ownerId,
  required int priority,
  required String name,
  required String conditionUuid,
  required String actionUuid,
  Value<String?> targetUuid,
});
typedef $$BattleRulesTableUpdateCompanionBuilder = BattleRulesCompanion
    Function({
  Value<int> id,
  Value<int> ownerId,
  Value<int> priority,
  Value<String> name,
  Value<String> conditionUuid,
  Value<String> actionUuid,
  Value<String?> targetUuid,
});

final class $$BattleRulesTableReferences
    extends BaseReferences<_$AppDatabase, $BattleRulesTable, BattleRule> {
  $$BattleRulesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CharactersTable _ownerIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
          $_aliasNameGenerator(db.battleRules.ownerId, db.characters.id));

  $$CharactersTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<int>('owner_id')!;

    final manager = $$CharactersTableTableManager($_db, $_db.characters)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$BattleRulesTableFilterComposer
    extends Composer<_$AppDatabase, $BattleRulesTable> {
  $$BattleRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conditionUuid => $composableBuilder(
      column: $table.conditionUuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actionUuid => $composableBuilder(
      column: $table.actionUuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get targetUuid => $composableBuilder(
      column: $table.targetUuid, builder: (column) => ColumnFilters(column));

  $$CharactersTableFilterComposer get ownerId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableFilterComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BattleRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $BattleRulesTable> {
  $$BattleRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conditionUuid => $composableBuilder(
      column: $table.conditionUuid,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actionUuid => $composableBuilder(
      column: $table.actionUuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get targetUuid => $composableBuilder(
      column: $table.targetUuid, builder: (column) => ColumnOrderings(column));

  $$CharactersTableOrderingComposer get ownerId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableOrderingComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BattleRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BattleRulesTable> {
  $$BattleRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get conditionUuid => $composableBuilder(
      column: $table.conditionUuid, builder: (column) => column);

  GeneratedColumn<String> get actionUuid => $composableBuilder(
      column: $table.actionUuid, builder: (column) => column);

  GeneratedColumn<String> get targetUuid => $composableBuilder(
      column: $table.targetUuid, builder: (column) => column);

  $$CharactersTableAnnotationComposer get ownerId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableAnnotationComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$BattleRulesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BattleRulesTable,
    BattleRule,
    $$BattleRulesTableFilterComposer,
    $$BattleRulesTableOrderingComposer,
    $$BattleRulesTableAnnotationComposer,
    $$BattleRulesTableCreateCompanionBuilder,
    $$BattleRulesTableUpdateCompanionBuilder,
    (BattleRule, $$BattleRulesTableReferences),
    BattleRule,
    PrefetchHooks Function({bool ownerId})> {
  $$BattleRulesTableTableManager(_$AppDatabase db, $BattleRulesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BattleRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BattleRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BattleRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ownerId = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> conditionUuid = const Value.absent(),
            Value<String> actionUuid = const Value.absent(),
            Value<String?> targetUuid = const Value.absent(),
          }) =>
              BattleRulesCompanion(
            id: id,
            ownerId: ownerId,
            priority: priority,
            name: name,
            conditionUuid: conditionUuid,
            actionUuid: actionUuid,
            targetUuid: targetUuid,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ownerId,
            required int priority,
            required String name,
            required String conditionUuid,
            required String actionUuid,
            Value<String?> targetUuid = const Value.absent(),
          }) =>
              BattleRulesCompanion.insert(
            id: id,
            ownerId: ownerId,
            priority: priority,
            name: name,
            conditionUuid: conditionUuid,
            actionUuid: actionUuid,
            targetUuid: targetUuid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$BattleRulesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ownerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (ownerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ownerId,
                    referencedTable:
                        $$BattleRulesTableReferences._ownerIdTable(db),
                    referencedColumn:
                        $$BattleRulesTableReferences._ownerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$BattleRulesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BattleRulesTable,
    BattleRule,
    $$BattleRulesTableFilterComposer,
    $$BattleRulesTableOrderingComposer,
    $$BattleRulesTableAnnotationComposer,
    $$BattleRulesTableCreateCompanionBuilder,
    $$BattleRulesTableUpdateCompanionBuilder,
    (BattleRule, $$BattleRulesTableReferences),
    BattleRule,
    PrefetchHooks Function({bool ownerId})>;
typedef $$GameStatesTableCreateCompanionBuilder = GameStatesCompanion Function({
  Value<int> id,
  required int gold,
  required int maxReachedFloor,
  Value<int?> activeFloor,
  required int battleCountOnFloor,
  required int battlesToUnlockNextFloor,
  Value<String?> eventLog,
  Value<int> isPaused,
  Value<String?> seed,
});
typedef $$GameStatesTableUpdateCompanionBuilder = GameStatesCompanion Function({
  Value<int> id,
  Value<int> gold,
  Value<int> maxReachedFloor,
  Value<int?> activeFloor,
  Value<int> battleCountOnFloor,
  Value<int> battlesToUnlockNextFloor,
  Value<String?> eventLog,
  Value<int> isPaused,
  Value<String?> seed,
});

class $$GameStatesTableFilterComposer
    extends Composer<_$AppDatabase, $GameStatesTable> {
  $$GameStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get gold => $composableBuilder(
      column: $table.gold, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxReachedFloor => $composableBuilder(
      column: $table.maxReachedFloor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get activeFloor => $composableBuilder(
      column: $table.activeFloor, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get battleCountOnFloor => $composableBuilder(
      column: $table.battleCountOnFloor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get battlesToUnlockNextFloor => $composableBuilder(
      column: $table.battlesToUnlockNextFloor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventLog => $composableBuilder(
      column: $table.eventLog, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get isPaused => $composableBuilder(
      column: $table.isPaused, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get seed => $composableBuilder(
      column: $table.seed, builder: (column) => ColumnFilters(column));
}

class $$GameStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $GameStatesTable> {
  $$GameStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get gold => $composableBuilder(
      column: $table.gold, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxReachedFloor => $composableBuilder(
      column: $table.maxReachedFloor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get activeFloor => $composableBuilder(
      column: $table.activeFloor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get battleCountOnFloor => $composableBuilder(
      column: $table.battleCountOnFloor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get battlesToUnlockNextFloor => $composableBuilder(
      column: $table.battlesToUnlockNextFloor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventLog => $composableBuilder(
      column: $table.eventLog, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get isPaused => $composableBuilder(
      column: $table.isPaused, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get seed => $composableBuilder(
      column: $table.seed, builder: (column) => ColumnOrderings(column));
}

class $$GameStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameStatesTable> {
  $$GameStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get gold =>
      $composableBuilder(column: $table.gold, builder: (column) => column);

  GeneratedColumn<int> get maxReachedFloor => $composableBuilder(
      column: $table.maxReachedFloor, builder: (column) => column);

  GeneratedColumn<int> get activeFloor => $composableBuilder(
      column: $table.activeFloor, builder: (column) => column);

  GeneratedColumn<int> get battleCountOnFloor => $composableBuilder(
      column: $table.battleCountOnFloor, builder: (column) => column);

  GeneratedColumn<int> get battlesToUnlockNextFloor => $composableBuilder(
      column: $table.battlesToUnlockNextFloor, builder: (column) => column);

  GeneratedColumn<String> get eventLog =>
      $composableBuilder(column: $table.eventLog, builder: (column) => column);

  GeneratedColumn<int> get isPaused =>
      $composableBuilder(column: $table.isPaused, builder: (column) => column);

  GeneratedColumn<String> get seed =>
      $composableBuilder(column: $table.seed, builder: (column) => column);
}

class $$GameStatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GameStatesTable,
    GameState,
    $$GameStatesTableFilterComposer,
    $$GameStatesTableOrderingComposer,
    $$GameStatesTableAnnotationComposer,
    $$GameStatesTableCreateCompanionBuilder,
    $$GameStatesTableUpdateCompanionBuilder,
    (GameState, BaseReferences<_$AppDatabase, $GameStatesTable, GameState>),
    GameState,
    PrefetchHooks Function()> {
  $$GameStatesTableTableManager(_$AppDatabase db, $GameStatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameStatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> gold = const Value.absent(),
            Value<int> maxReachedFloor = const Value.absent(),
            Value<int?> activeFloor = const Value.absent(),
            Value<int> battleCountOnFloor = const Value.absent(),
            Value<int> battlesToUnlockNextFloor = const Value.absent(),
            Value<String?> eventLog = const Value.absent(),
            Value<int> isPaused = const Value.absent(),
            Value<String?> seed = const Value.absent(),
          }) =>
              GameStatesCompanion(
            id: id,
            gold: gold,
            maxReachedFloor: maxReachedFloor,
            activeFloor: activeFloor,
            battleCountOnFloor: battleCountOnFloor,
            battlesToUnlockNextFloor: battlesToUnlockNextFloor,
            eventLog: eventLog,
            isPaused: isPaused,
            seed: seed,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int gold,
            required int maxReachedFloor,
            Value<int?> activeFloor = const Value.absent(),
            required int battleCountOnFloor,
            required int battlesToUnlockNextFloor,
            Value<String?> eventLog = const Value.absent(),
            Value<int> isPaused = const Value.absent(),
            Value<String?> seed = const Value.absent(),
          }) =>
              GameStatesCompanion.insert(
            id: id,
            gold: gold,
            maxReachedFloor: maxReachedFloor,
            activeFloor: activeFloor,
            battleCountOnFloor: battleCountOnFloor,
            battlesToUnlockNextFloor: battlesToUnlockNextFloor,
            eventLog: eventLog,
            isPaused: isPaused,
            seed: seed,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GameStatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GameStatesTable,
    GameState,
    $$GameStatesTableFilterComposer,
    $$GameStatesTableOrderingComposer,
    $$GameStatesTableAnnotationComposer,
    $$GameStatesTableCreateCompanionBuilder,
    $$GameStatesTableUpdateCompanionBuilder,
    (GameState, BaseReferences<_$AppDatabase, $GameStatesTable, GameState>),
    GameState,
    PrefetchHooks Function()>;
typedef $$CharacterInventoriesTableCreateCompanionBuilder
    = CharacterInventoriesCompanion Function({
  Value<int> id,
  required int characterId,
  required String itemId,
});
typedef $$CharacterInventoriesTableUpdateCompanionBuilder
    = CharacterInventoriesCompanion Function({
  Value<int> id,
  Value<int> characterId,
  Value<String> itemId,
});

final class $$CharacterInventoriesTableReferences extends BaseReferences<
    _$AppDatabase, $CharacterInventoriesTable, CharacterInventory> {
  $$CharacterInventoriesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias($_aliasNameGenerator(
          db.characterInventories.characterId, db.characters.id));

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<int>('character_id')!;

    final manager = $$CharactersTableTableManager($_db, $_db.characters)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CharacterInventoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterInventoriesTable> {
  $$CharacterInventoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.characterId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableFilterComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CharacterInventoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterInventoriesTable> {
  $$CharacterInventoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.characterId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableOrderingComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CharacterInventoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterInventoriesTable> {
  $$CharacterInventoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.characterId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableAnnotationComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CharacterInventoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CharacterInventoriesTable,
    CharacterInventory,
    $$CharacterInventoriesTableFilterComposer,
    $$CharacterInventoriesTableOrderingComposer,
    $$CharacterInventoriesTableAnnotationComposer,
    $$CharacterInventoriesTableCreateCompanionBuilder,
    $$CharacterInventoriesTableUpdateCompanionBuilder,
    (CharacterInventory, $$CharacterInventoriesTableReferences),
    CharacterInventory,
    PrefetchHooks Function({bool characterId})> {
  $$CharacterInventoriesTableTableManager(
      _$AppDatabase db, $CharacterInventoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterInventoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharacterInventoriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharacterInventoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> characterId = const Value.absent(),
            Value<String> itemId = const Value.absent(),
          }) =>
              CharacterInventoriesCompanion(
            id: id,
            characterId: characterId,
            itemId: itemId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int characterId,
            required String itemId,
          }) =>
              CharacterInventoriesCompanion.insert(
            id: id,
            characterId: characterId,
            itemId: itemId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CharacterInventoriesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (characterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.characterId,
                    referencedTable: $$CharacterInventoriesTableReferences
                        ._characterIdTable(db),
                    referencedColumn: $$CharacterInventoriesTableReferences
                        ._characterIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CharacterInventoriesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CharacterInventoriesTable,
        CharacterInventory,
        $$CharacterInventoriesTableFilterComposer,
        $$CharacterInventoriesTableOrderingComposer,
        $$CharacterInventoriesTableAnnotationComposer,
        $$CharacterInventoriesTableCreateCompanionBuilder,
        $$CharacterInventoriesTableUpdateCompanionBuilder,
        (CharacterInventory, $$CharacterInventoriesTableReferences),
        CharacterInventory,
        PrefetchHooks Function({bool characterId})>;
typedef $$CharacterEquipmentsTableCreateCompanionBuilder
    = CharacterEquipmentsCompanion Function({
  Value<int> id,
  required int characterId,
  required String slot,
  required String itemId,
});
typedef $$CharacterEquipmentsTableUpdateCompanionBuilder
    = CharacterEquipmentsCompanion Function({
  Value<int> id,
  Value<int> characterId,
  Value<String> slot,
  Value<String> itemId,
});

final class $$CharacterEquipmentsTableReferences extends BaseReferences<
    _$AppDatabase, $CharacterEquipmentsTable, CharacterEquipment> {
  $$CharacterEquipmentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias($_aliasNameGenerator(
          db.characterEquipments.characterId, db.characters.id));

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<int>('character_id')!;

    final manager = $$CharactersTableTableManager($_db, $_db.characters)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CharacterEquipmentsTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterEquipmentsTable> {
  $$CharacterEquipmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get slot => $composableBuilder(
      column: $table.slot, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnFilters(column));

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.characterId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableFilterComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CharacterEquipmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterEquipmentsTable> {
  $$CharacterEquipmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get slot => $composableBuilder(
      column: $table.slot, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemId => $composableBuilder(
      column: $table.itemId, builder: (column) => ColumnOrderings(column));

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.characterId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableOrderingComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CharacterEquipmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterEquipmentsTable> {
  $$CharacterEquipmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.characterId,
        referencedTable: $db.characters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CharactersTableAnnotationComposer(
              $db: $db,
              $table: $db.characters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CharacterEquipmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CharacterEquipmentsTable,
    CharacterEquipment,
    $$CharacterEquipmentsTableFilterComposer,
    $$CharacterEquipmentsTableOrderingComposer,
    $$CharacterEquipmentsTableAnnotationComposer,
    $$CharacterEquipmentsTableCreateCompanionBuilder,
    $$CharacterEquipmentsTableUpdateCompanionBuilder,
    (CharacterEquipment, $$CharacterEquipmentsTableReferences),
    CharacterEquipment,
    PrefetchHooks Function({bool characterId})> {
  $$CharacterEquipmentsTableTableManager(
      _$AppDatabase db, $CharacterEquipmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterEquipmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharacterEquipmentsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharacterEquipmentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> characterId = const Value.absent(),
            Value<String> slot = const Value.absent(),
            Value<String> itemId = const Value.absent(),
          }) =>
              CharacterEquipmentsCompanion(
            id: id,
            characterId: characterId,
            slot: slot,
            itemId: itemId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int characterId,
            required String slot,
            required String itemId,
          }) =>
              CharacterEquipmentsCompanion.insert(
            id: id,
            characterId: characterId,
            slot: slot,
            itemId: itemId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CharacterEquipmentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (characterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.characterId,
                    referencedTable: $$CharacterEquipmentsTableReferences
                        ._characterIdTable(db),
                    referencedColumn: $$CharacterEquipmentsTableReferences
                        ._characterIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$CharacterEquipmentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CharacterEquipmentsTable,
    CharacterEquipment,
    $$CharacterEquipmentsTableFilterComposer,
    $$CharacterEquipmentsTableOrderingComposer,
    $$CharacterEquipmentsTableAnnotationComposer,
    $$CharacterEquipmentsTableCreateCompanionBuilder,
    $$CharacterEquipmentsTableUpdateCompanionBuilder,
    (CharacterEquipment, $$CharacterEquipmentsTableReferences),
    CharacterEquipment,
    PrefetchHooks Function({bool characterId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CharactersTableTableManager get characters =>
      $$CharactersTableTableManager(_db, _db.characters);
  $$StatusParametersTableTableManager get statusParameters =>
      $$StatusParametersTableTableManager(_db, _db.statusParameters);
  $$BattleRulesTableTableManager get battleRules =>
      $$BattleRulesTableTableManager(_db, _db.battleRules);
  $$GameStatesTableTableManager get gameStates =>
      $$GameStatesTableTableManager(_db, _db.gameStates);
  $$CharacterInventoriesTableTableManager get characterInventories =>
      $$CharacterInventoriesTableTableManager(_db, _db.characterInventories);
  $$CharacterEquipmentsTableTableManager get characterEquipments =>
      $$CharacterEquipmentsTableTableManager(_db, _db.characterEquipments);
}
