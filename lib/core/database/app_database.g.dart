// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AsistenciaTableTable extends AsistenciaTable
    with TableInfo<$AsistenciaTableTable, AsistenciaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AsistenciaTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaHoraMeta = const VerificationMeta(
    'fechaHora',
  );
  @override
  late final GeneratedColumn<DateTime> fechaHora = GeneratedColumn<DateTime>(
    'fecha_hora',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    check: () => CustomExpression<bool>("tipo IN ('entrada', 'salida')"),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metodoMeta = const VerificationMeta('metodo');
  @override
  late final GeneratedColumn<String> metodo = GeneratedColumn<String>(
    'metodo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _sincronizadoMeta = const VerificationMeta(
    'sincronizado',
  );
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
    'sincronizado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sincronizado" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    usuarioId,
    fechaHora,
    tipo,
    metodo,
    sincronizado,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'asistencia_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AsistenciaTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('fecha_hora')) {
      context.handle(
        _fechaHoraMeta,
        fechaHora.isAcceptableOrUnknown(data['fecha_hora']!, _fechaHoraMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaHoraMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('metodo')) {
      context.handle(
        _metodoMeta,
        metodo.isAcceptableOrUnknown(data['metodo']!, _metodoMeta),
      );
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
        _sincronizadoMeta,
        sincronizado.isAcceptableOrUnknown(
          data['sincronizado']!,
          _sincronizadoMeta,
        ),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AsistenciaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AsistenciaTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      fechaHora: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_hora'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      metodo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metodo'],
      )!,
      sincronizado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sincronizado'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $AsistenciaTableTable createAlias(String alias) {
    return $AsistenciaTableTable(attachedDatabase, alias);
  }
}

class AsistenciaTableData extends DataClass
    implements Insertable<AsistenciaTableData> {
  final int id;
  final String usuarioId;
  final DateTime fechaHora;
  final String tipo;
  final String metodo;
  final bool sincronizado;
  final DateTime creadoEn;
  const AsistenciaTableData({
    required this.id,
    required this.usuarioId,
    required this.fechaHora,
    required this.tipo,
    required this.metodo,
    required this.sincronizado,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['usuario_id'] = Variable<String>(usuarioId);
    map['fecha_hora'] = Variable<DateTime>(fechaHora);
    map['tipo'] = Variable<String>(tipo);
    map['metodo'] = Variable<String>(metodo);
    map['sincronizado'] = Variable<bool>(sincronizado);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  AsistenciaTableCompanion toCompanion(bool nullToAbsent) {
    return AsistenciaTableCompanion(
      id: Value(id),
      usuarioId: Value(usuarioId),
      fechaHora: Value(fechaHora),
      tipo: Value(tipo),
      metodo: Value(metodo),
      sincronizado: Value(sincronizado),
      creadoEn: Value(creadoEn),
    );
  }

  factory AsistenciaTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AsistenciaTableData(
      id: serializer.fromJson<int>(json['id']),
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      fechaHora: serializer.fromJson<DateTime>(json['fechaHora']),
      tipo: serializer.fromJson<String>(json['tipo']),
      metodo: serializer.fromJson<String>(json['metodo']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'usuarioId': serializer.toJson<String>(usuarioId),
      'fechaHora': serializer.toJson<DateTime>(fechaHora),
      'tipo': serializer.toJson<String>(tipo),
      'metodo': serializer.toJson<String>(metodo),
      'sincronizado': serializer.toJson<bool>(sincronizado),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  AsistenciaTableData copyWith({
    int? id,
    String? usuarioId,
    DateTime? fechaHora,
    String? tipo,
    String? metodo,
    bool? sincronizado,
    DateTime? creadoEn,
  }) => AsistenciaTableData(
    id: id ?? this.id,
    usuarioId: usuarioId ?? this.usuarioId,
    fechaHora: fechaHora ?? this.fechaHora,
    tipo: tipo ?? this.tipo,
    metodo: metodo ?? this.metodo,
    sincronizado: sincronizado ?? this.sincronizado,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  AsistenciaTableData copyWithCompanion(AsistenciaTableCompanion data) {
    return AsistenciaTableData(
      id: data.id.present ? data.id.value : this.id,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      fechaHora: data.fechaHora.present ? data.fechaHora.value : this.fechaHora,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      metodo: data.metodo.present ? data.metodo.value : this.metodo,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AsistenciaTableData(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('fechaHora: $fechaHora, ')
          ..write('tipo: $tipo, ')
          ..write('metodo: $metodo, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    usuarioId,
    fechaHora,
    tipo,
    metodo,
    sincronizado,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AsistenciaTableData &&
          other.id == this.id &&
          other.usuarioId == this.usuarioId &&
          other.fechaHora == this.fechaHora &&
          other.tipo == this.tipo &&
          other.metodo == this.metodo &&
          other.sincronizado == this.sincronizado &&
          other.creadoEn == this.creadoEn);
}

class AsistenciaTableCompanion extends UpdateCompanion<AsistenciaTableData> {
  final Value<int> id;
  final Value<String> usuarioId;
  final Value<DateTime> fechaHora;
  final Value<String> tipo;
  final Value<String> metodo;
  final Value<bool> sincronizado;
  final Value<DateTime> creadoEn;
  const AsistenciaTableCompanion({
    this.id = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.fechaHora = const Value.absent(),
    this.tipo = const Value.absent(),
    this.metodo = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  AsistenciaTableCompanion.insert({
    this.id = const Value.absent(),
    required String usuarioId,
    required DateTime fechaHora,
    required String tipo,
    this.metodo = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.creadoEn = const Value.absent(),
  }) : usuarioId = Value(usuarioId),
       fechaHora = Value(fechaHora),
       tipo = Value(tipo);
  static Insertable<AsistenciaTableData> custom({
    Expression<int>? id,
    Expression<String>? usuarioId,
    Expression<DateTime>? fechaHora,
    Expression<String>? tipo,
    Expression<String>? metodo,
    Expression<bool>? sincronizado,
    Expression<DateTime>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (fechaHora != null) 'fecha_hora': fechaHora,
      if (tipo != null) 'tipo': tipo,
      if (metodo != null) 'metodo': metodo,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  AsistenciaTableCompanion copyWith({
    Value<int>? id,
    Value<String>? usuarioId,
    Value<DateTime>? fechaHora,
    Value<String>? tipo,
    Value<String>? metodo,
    Value<bool>? sincronizado,
    Value<DateTime>? creadoEn,
  }) {
    return AsistenciaTableCompanion(
      id: id ?? this.id,
      usuarioId: usuarioId ?? this.usuarioId,
      fechaHora: fechaHora ?? this.fechaHora,
      tipo: tipo ?? this.tipo,
      metodo: metodo ?? this.metodo,
      sincronizado: sincronizado ?? this.sincronizado,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (fechaHora.present) {
      map['fecha_hora'] = Variable<DateTime>(fechaHora.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (metodo.present) {
      map['metodo'] = Variable<String>(metodo.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AsistenciaTableCompanion(')
          ..write('id: $id, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('fechaHora: $fechaHora, ')
          ..write('tipo: $tipo, ')
          ..write('metodo: $metodo, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTableTable extends NotificationsTable
    with TableInfo<$NotificationsTableTable, NotificationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mensajeMeta = const VerificationMeta(
    'mensaje',
  );
  @override
  late final GeneratedColumn<String> mensaje = GeneratedColumn<String>(
    'mensaje',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('info'),
  );
  static const VerificationMeta _leidaMeta = const VerificationMeta('leida');
  @override
  late final GeneratedColumn<bool> leida = GeneratedColumn<bool>(
    'leida',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("leida" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _origenMeta = const VerificationMeta('origen');
  @override
  late final GeneratedColumn<String> origen = GeneratedColumn<String>(
    'origen',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    titulo,
    mensaje,
    tipo,
    leida,
    origen,
    fecha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('mensaje')) {
      context.handle(
        _mensajeMeta,
        mensaje.isAcceptableOrUnknown(data['mensaje']!, _mensajeMeta),
      );
    } else if (isInserting) {
      context.missing(_mensajeMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    }
    if (data.containsKey('leida')) {
      context.handle(
        _leidaMeta,
        leida.isAcceptableOrUnknown(data['leida']!, _leidaMeta),
      );
    }
    if (data.containsKey('origen')) {
      context.handle(
        _origenMeta,
        origen.isAcceptableOrUnknown(data['origen']!, _origenMeta),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  NotificationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      mensaje: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mensaje'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      leida: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}leida'],
      )!,
      origen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origen'],
      ),
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $NotificationsTableTable createAlias(String alias) {
    return $NotificationsTableTable(attachedDatabase, alias);
  }
}

class NotificationsTableData extends DataClass
    implements Insertable<NotificationsTableData> {
  final String id;
  final String titulo;
  final String mensaje;
  final String tipo;
  final bool leida;
  final String? origen;
  final DateTime fecha;
  const NotificationsTableData({
    required this.id,
    required this.titulo,
    required this.mensaje,
    required this.tipo,
    required this.leida,
    this.origen,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['titulo'] = Variable<String>(titulo);
    map['mensaje'] = Variable<String>(mensaje);
    map['tipo'] = Variable<String>(tipo);
    map['leida'] = Variable<bool>(leida);
    if (!nullToAbsent || origen != null) {
      map['origen'] = Variable<String>(origen);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  NotificationsTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationsTableCompanion(
      id: Value(id),
      titulo: Value(titulo),
      mensaje: Value(mensaje),
      tipo: Value(tipo),
      leida: Value(leida),
      origen: origen == null && nullToAbsent
          ? const Value.absent()
          : Value(origen),
      fecha: Value(fecha),
    );
  }

  factory NotificationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationsTableData(
      id: serializer.fromJson<String>(json['id']),
      titulo: serializer.fromJson<String>(json['titulo']),
      mensaje: serializer.fromJson<String>(json['mensaje']),
      tipo: serializer.fromJson<String>(json['tipo']),
      leida: serializer.fromJson<bool>(json['leida']),
      origen: serializer.fromJson<String?>(json['origen']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'titulo': serializer.toJson<String>(titulo),
      'mensaje': serializer.toJson<String>(mensaje),
      'tipo': serializer.toJson<String>(tipo),
      'leida': serializer.toJson<bool>(leida),
      'origen': serializer.toJson<String?>(origen),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  NotificationsTableData copyWith({
    String? id,
    String? titulo,
    String? mensaje,
    String? tipo,
    bool? leida,
    Value<String?> origen = const Value.absent(),
    DateTime? fecha,
  }) => NotificationsTableData(
    id: id ?? this.id,
    titulo: titulo ?? this.titulo,
    mensaje: mensaje ?? this.mensaje,
    tipo: tipo ?? this.tipo,
    leida: leida ?? this.leida,
    origen: origen.present ? origen.value : this.origen,
    fecha: fecha ?? this.fecha,
  );
  NotificationsTableData copyWithCompanion(NotificationsTableCompanion data) {
    return NotificationsTableData(
      id: data.id.present ? data.id.value : this.id,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      mensaje: data.mensaje.present ? data.mensaje.value : this.mensaje,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      leida: data.leida.present ? data.leida.value : this.leida,
      origen: data.origen.present ? data.origen.value : this.origen,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsTableData(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('mensaje: $mensaje, ')
          ..write('tipo: $tipo, ')
          ..write('leida: $leida, ')
          ..write('origen: $origen, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, titulo, mensaje, tipo, leida, origen, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationsTableData &&
          other.id == this.id &&
          other.titulo == this.titulo &&
          other.mensaje == this.mensaje &&
          other.tipo == this.tipo &&
          other.leida == this.leida &&
          other.origen == this.origen &&
          other.fecha == this.fecha);
}

class NotificationsTableCompanion
    extends UpdateCompanion<NotificationsTableData> {
  final Value<String> id;
  final Value<String> titulo;
  final Value<String> mensaje;
  final Value<String> tipo;
  final Value<bool> leida;
  final Value<String?> origen;
  final Value<DateTime> fecha;
  final Value<int> rowid;
  const NotificationsTableCompanion({
    this.id = const Value.absent(),
    this.titulo = const Value.absent(),
    this.mensaje = const Value.absent(),
    this.tipo = const Value.absent(),
    this.leida = const Value.absent(),
    this.origen = const Value.absent(),
    this.fecha = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsTableCompanion.insert({
    required String id,
    required String titulo,
    required String mensaje,
    this.tipo = const Value.absent(),
    this.leida = const Value.absent(),
    this.origen = const Value.absent(),
    this.fecha = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       titulo = Value(titulo),
       mensaje = Value(mensaje);
  static Insertable<NotificationsTableData> custom({
    Expression<String>? id,
    Expression<String>? titulo,
    Expression<String>? mensaje,
    Expression<String>? tipo,
    Expression<bool>? leida,
    Expression<String>? origen,
    Expression<DateTime>? fecha,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titulo != null) 'titulo': titulo,
      if (mensaje != null) 'mensaje': mensaje,
      if (tipo != null) 'tipo': tipo,
      if (leida != null) 'leida': leida,
      if (origen != null) 'origen': origen,
      if (fecha != null) 'fecha': fecha,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? titulo,
    Value<String>? mensaje,
    Value<String>? tipo,
    Value<bool>? leida,
    Value<String?>? origen,
    Value<DateTime>? fecha,
    Value<int>? rowid,
  }) {
    return NotificationsTableCompanion(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      mensaje: mensaje ?? this.mensaje,
      tipo: tipo ?? this.tipo,
      leida: leida ?? this.leida,
      origen: origen ?? this.origen,
      fecha: fecha ?? this.fecha,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (mensaje.present) {
      map['mensaje'] = Variable<String>(mensaje.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (leida.present) {
      map['leida'] = Variable<bool>(leida.value);
    }
    if (origen.present) {
      map['origen'] = Variable<String>(origen.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsTableCompanion(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('mensaje: $mensaje, ')
          ..write('tipo: $tipo, ')
          ..write('leida: $leida, ')
          ..write('origen: $origen, ')
          ..write('fecha: $fecha, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _entidadMeta = const VerificationMeta(
    'entidad',
  );
  @override
  late final GeneratedColumn<String> entidad = GeneratedColumn<String>(
    'entidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entidadIdMeta = const VerificationMeta(
    'entidadId',
  );
  @override
  late final GeneratedColumn<String> entidadId = GeneratedColumn<String>(
    'entidad_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accionMeta = const VerificationMeta('accion');
  @override
  late final GeneratedColumn<String> accion = GeneratedColumn<String>(
    'accion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String>
  payload =
      GeneratedColumn<String>(
        'payload',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Map<String, dynamic>?>(
        $SyncQueueTableTable.$converterpayloadn,
      );
  static const VerificationMeta _procesadoMeta = const VerificationMeta(
    'procesado',
  );
  @override
  late final GeneratedColumn<bool> procesado = GeneratedColumn<bool>(
    'procesado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("procesado" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entidad,
    entidadId,
    accion,
    payload,
    procesado,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entidad')) {
      context.handle(
        _entidadMeta,
        entidad.isAcceptableOrUnknown(data['entidad']!, _entidadMeta),
      );
    } else if (isInserting) {
      context.missing(_entidadMeta);
    }
    if (data.containsKey('entidad_id')) {
      context.handle(
        _entidadIdMeta,
        entidadId.isAcceptableOrUnknown(data['entidad_id']!, _entidadIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entidadIdMeta);
    }
    if (data.containsKey('accion')) {
      context.handle(
        _accionMeta,
        accion.isAcceptableOrUnknown(data['accion']!, _accionMeta),
      );
    } else if (isInserting) {
      context.missing(_accionMeta);
    }
    if (data.containsKey('procesado')) {
      context.handle(
        _procesadoMeta,
        procesado.isAcceptableOrUnknown(data['procesado']!, _procesadoMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entidad'],
      )!,
      entidadId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entidad_id'],
      )!,
      accion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accion'],
      )!,
      payload: $SyncQueueTableTable.$converterpayloadn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}payload'],
        ),
      ),
      procesado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}procesado'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Map<String, dynamic>, String> $converterpayload =
      const SyncPayloadTypeConverter();
  static TypeConverter<Map<String, dynamic>?, String?> $converterpayloadn =
      NullAwareTypeConverter.wrap($converterpayload);
}

class SyncQueueTableData extends DataClass
    implements Insertable<SyncQueueTableData> {
  final int id;
  final String entidad;
  final String entidadId;
  final String accion;
  final Map<String, dynamic>? payload;
  final bool procesado;
  final DateTime createdAt;
  const SyncQueueTableData({
    required this.id,
    required this.entidad,
    required this.entidadId,
    required this.accion,
    this.payload,
    required this.procesado,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entidad'] = Variable<String>(entidad);
    map['entidad_id'] = Variable<String>(entidadId);
    map['accion'] = Variable<String>(accion);
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(
        $SyncQueueTableTable.$converterpayloadn.toSql(payload),
      );
    }
    map['procesado'] = Variable<bool>(procesado);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      id: Value(id),
      entidad: Value(entidad),
      entidadId: Value(entidadId),
      accion: Value(accion),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      procesado: Value(procesado),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueTableData(
      id: serializer.fromJson<int>(json['id']),
      entidad: serializer.fromJson<String>(json['entidad']),
      entidadId: serializer.fromJson<String>(json['entidadId']),
      accion: serializer.fromJson<String>(json['accion']),
      payload: serializer.fromJson<Map<String, dynamic>?>(json['payload']),
      procesado: serializer.fromJson<bool>(json['procesado']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entidad': serializer.toJson<String>(entidad),
      'entidadId': serializer.toJson<String>(entidadId),
      'accion': serializer.toJson<String>(accion),
      'payload': serializer.toJson<Map<String, dynamic>?>(payload),
      'procesado': serializer.toJson<bool>(procesado),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueTableData copyWith({
    int? id,
    String? entidad,
    String? entidadId,
    String? accion,
    Value<Map<String, dynamic>?> payload = const Value.absent(),
    bool? procesado,
    DateTime? createdAt,
  }) => SyncQueueTableData(
    id: id ?? this.id,
    entidad: entidad ?? this.entidad,
    entidadId: entidadId ?? this.entidadId,
    accion: accion ?? this.accion,
    payload: payload.present ? payload.value : this.payload,
    procesado: procesado ?? this.procesado,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncQueueTableData copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      entidad: data.entidad.present ? data.entidad.value : this.entidad,
      entidadId: data.entidadId.present ? data.entidadId.value : this.entidadId,
      accion: data.accion.present ? data.accion.value : this.accion,
      payload: data.payload.present ? data.payload.value : this.payload,
      procesado: data.procesado.present ? data.procesado.value : this.procesado,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableData(')
          ..write('id: $id, ')
          ..write('entidad: $entidad, ')
          ..write('entidadId: $entidadId, ')
          ..write('accion: $accion, ')
          ..write('payload: $payload, ')
          ..write('procesado: $procesado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entidad,
    entidadId,
    accion,
    payload,
    procesado,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueTableData &&
          other.id == this.id &&
          other.entidad == this.entidad &&
          other.entidadId == this.entidadId &&
          other.accion == this.accion &&
          other.payload == this.payload &&
          other.procesado == this.procesado &&
          other.createdAt == this.createdAt);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueTableData> {
  final Value<int> id;
  final Value<String> entidad;
  final Value<String> entidadId;
  final Value<String> accion;
  final Value<Map<String, dynamic>?> payload;
  final Value<bool> procesado;
  final Value<DateTime> createdAt;
  const SyncQueueTableCompanion({
    this.id = const Value.absent(),
    this.entidad = const Value.absent(),
    this.entidadId = const Value.absent(),
    this.accion = const Value.absent(),
    this.payload = const Value.absent(),
    this.procesado = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    this.id = const Value.absent(),
    required String entidad,
    required String entidadId,
    required String accion,
    this.payload = const Value.absent(),
    this.procesado = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : entidad = Value(entidad),
       entidadId = Value(entidadId),
       accion = Value(accion);
  static Insertable<SyncQueueTableData> custom({
    Expression<int>? id,
    Expression<String>? entidad,
    Expression<String>? entidadId,
    Expression<String>? accion,
    Expression<String>? payload,
    Expression<bool>? procesado,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entidad != null) 'entidad': entidad,
      if (entidadId != null) 'entidad_id': entidadId,
      if (accion != null) 'accion': accion,
      if (payload != null) 'payload': payload,
      if (procesado != null) 'procesado': procesado,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SyncQueueTableCompanion copyWith({
    Value<int>? id,
    Value<String>? entidad,
    Value<String>? entidadId,
    Value<String>? accion,
    Value<Map<String, dynamic>?>? payload,
    Value<bool>? procesado,
    Value<DateTime>? createdAt,
  }) {
    return SyncQueueTableCompanion(
      id: id ?? this.id,
      entidad: entidad ?? this.entidad,
      entidadId: entidadId ?? this.entidadId,
      accion: accion ?? this.accion,
      payload: payload ?? this.payload,
      procesado: procesado ?? this.procesado,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entidad.present) {
      map['entidad'] = Variable<String>(entidad.value);
    }
    if (entidadId.present) {
      map['entidad_id'] = Variable<String>(entidadId.value);
    }
    if (accion.present) {
      map['accion'] = Variable<String>(accion.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(
        $SyncQueueTableTable.$converterpayloadn.toSql(payload.value),
      );
    }
    if (procesado.present) {
      map['procesado'] = Variable<bool>(procesado.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('entidad: $entidad, ')
          ..write('entidadId: $entidadId, ')
          ..write('accion: $accion, ')
          ..write('payload: $payload, ')
          ..write('procesado: $procesado, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $TareasTableTable extends TareasTable
    with TableInfo<$TareasTableTable, TareasTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TareasTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reporteIdMeta = const VerificationMeta(
    'reporteId',
  );
  @override
  late final GeneratedColumn<String> reporteId = GeneratedColumn<String>(
    'reporte_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _creadoPorMeta = const VerificationMeta(
    'creadoPor',
  );
  @override
  late final GeneratedColumn<String> creadoPor = GeneratedColumn<String>(
    'creado_por',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _asignadoAMeta = const VerificationMeta(
    'asignadoA',
  );
  @override
  late final GeneratedColumn<String> asignadoA = GeneratedColumn<String>(
    'asignado_a',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    groupId,
    reporteId,
    titulo,
    descripcion,
    creadoPor,
    asignadoA,
    estado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tareas_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TareasTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    if (data.containsKey('reporte_id')) {
      context.handle(
        _reporteIdMeta,
        reporteId.isAcceptableOrUnknown(data['reporte_id']!, _reporteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reporteIdMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('creado_por')) {
      context.handle(
        _creadoPorMeta,
        creadoPor.isAcceptableOrUnknown(data['creado_por']!, _creadoPorMeta),
      );
    }
    if (data.containsKey('asignado_a')) {
      context.handle(
        _asignadoAMeta,
        asignadoA.isAcceptableOrUnknown(data['asignado_a']!, _asignadoAMeta),
      );
    } else if (isInserting) {
      context.missing(_asignadoAMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TareasTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TareasTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      ),
      reporteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reporte_id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      creadoPor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creado_por'],
      ),
      asignadoA: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asignado_a'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
    );
  }

  @override
  $TareasTableTable createAlias(String alias) {
    return $TareasTableTable(attachedDatabase, alias);
  }
}

class TareasTableData extends DataClass implements Insertable<TareasTableData> {
  final String id;
  final String? remoteId;
  final String? groupId;
  final String reporteId;
  final String titulo;
  final String descripcion;
  final String? creadoPor;
  final String asignadoA;
  final String estado;
  const TareasTableData({
    required this.id,
    this.remoteId,
    this.groupId,
    required this.reporteId,
    required this.titulo,
    required this.descripcion,
    this.creadoPor,
    required this.asignadoA,
    required this.estado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    map['reporte_id'] = Variable<String>(reporteId);
    map['titulo'] = Variable<String>(titulo);
    map['descripcion'] = Variable<String>(descripcion);
    if (!nullToAbsent || creadoPor != null) {
      map['creado_por'] = Variable<String>(creadoPor);
    }
    map['asignado_a'] = Variable<String>(asignadoA);
    map['estado'] = Variable<String>(estado);
    return map;
  }

  TareasTableCompanion toCompanion(bool nullToAbsent) {
    return TareasTableCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      reporteId: Value(reporteId),
      titulo: Value(titulo),
      descripcion: Value(descripcion),
      creadoPor: creadoPor == null && nullToAbsent
          ? const Value.absent()
          : Value(creadoPor),
      asignadoA: Value(asignadoA),
      estado: Value(estado),
    );
  }

  factory TareasTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TareasTableData(
      id: serializer.fromJson<String>(json['id']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      groupId: serializer.fromJson<String?>(json['groupId']),
      reporteId: serializer.fromJson<String>(json['reporteId']),
      titulo: serializer.fromJson<String>(json['titulo']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      creadoPor: serializer.fromJson<String?>(json['creadoPor']),
      asignadoA: serializer.fromJson<String>(json['asignadoA']),
      estado: serializer.fromJson<String>(json['estado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'remoteId': serializer.toJson<String?>(remoteId),
      'groupId': serializer.toJson<String?>(groupId),
      'reporteId': serializer.toJson<String>(reporteId),
      'titulo': serializer.toJson<String>(titulo),
      'descripcion': serializer.toJson<String>(descripcion),
      'creadoPor': serializer.toJson<String?>(creadoPor),
      'asignadoA': serializer.toJson<String>(asignadoA),
      'estado': serializer.toJson<String>(estado),
    };
  }

  TareasTableData copyWith({
    String? id,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> groupId = const Value.absent(),
    String? reporteId,
    String? titulo,
    String? descripcion,
    Value<String?> creadoPor = const Value.absent(),
    String? asignadoA,
    String? estado,
  }) => TareasTableData(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    groupId: groupId.present ? groupId.value : this.groupId,
    reporteId: reporteId ?? this.reporteId,
    titulo: titulo ?? this.titulo,
    descripcion: descripcion ?? this.descripcion,
    creadoPor: creadoPor.present ? creadoPor.value : this.creadoPor,
    asignadoA: asignadoA ?? this.asignadoA,
    estado: estado ?? this.estado,
  );
  TareasTableData copyWithCompanion(TareasTableCompanion data) {
    return TareasTableData(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      reporteId: data.reporteId.present ? data.reporteId.value : this.reporteId,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      creadoPor: data.creadoPor.present ? data.creadoPor.value : this.creadoPor,
      asignadoA: data.asignadoA.present ? data.asignadoA.value : this.asignadoA,
      estado: data.estado.present ? data.estado.value : this.estado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TareasTableData(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('groupId: $groupId, ')
          ..write('reporteId: $reporteId, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('creadoPor: $creadoPor, ')
          ..write('asignadoA: $asignadoA, ')
          ..write('estado: $estado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    groupId,
    reporteId,
    titulo,
    descripcion,
    creadoPor,
    asignadoA,
    estado,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TareasTableData &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.groupId == this.groupId &&
          other.reporteId == this.reporteId &&
          other.titulo == this.titulo &&
          other.descripcion == this.descripcion &&
          other.creadoPor == this.creadoPor &&
          other.asignadoA == this.asignadoA &&
          other.estado == this.estado);
}

class TareasTableCompanion extends UpdateCompanion<TareasTableData> {
  final Value<String> id;
  final Value<String?> remoteId;
  final Value<String?> groupId;
  final Value<String> reporteId;
  final Value<String> titulo;
  final Value<String> descripcion;
  final Value<String?> creadoPor;
  final Value<String> asignadoA;
  final Value<String> estado;
  final Value<int> rowid;
  const TareasTableCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.reporteId = const Value.absent(),
    this.titulo = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.creadoPor = const Value.absent(),
    this.asignadoA = const Value.absent(),
    this.estado = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TareasTableCompanion.insert({
    required String id,
    this.remoteId = const Value.absent(),
    this.groupId = const Value.absent(),
    required String reporteId,
    required String titulo,
    this.descripcion = const Value.absent(),
    this.creadoPor = const Value.absent(),
    required String asignadoA,
    required String estado,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reporteId = Value(reporteId),
       titulo = Value(titulo),
       asignadoA = Value(asignadoA),
       estado = Value(estado);
  static Insertable<TareasTableData> custom({
    Expression<String>? id,
    Expression<String>? remoteId,
    Expression<String>? groupId,
    Expression<String>? reporteId,
    Expression<String>? titulo,
    Expression<String>? descripcion,
    Expression<String>? creadoPor,
    Expression<String>? asignadoA,
    Expression<String>? estado,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (groupId != null) 'group_id': groupId,
      if (reporteId != null) 'reporte_id': reporteId,
      if (titulo != null) 'titulo': titulo,
      if (descripcion != null) 'descripcion': descripcion,
      if (creadoPor != null) 'creado_por': creadoPor,
      if (asignadoA != null) 'asignado_a': asignadoA,
      if (estado != null) 'estado': estado,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TareasTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? remoteId,
    Value<String?>? groupId,
    Value<String>? reporteId,
    Value<String>? titulo,
    Value<String>? descripcion,
    Value<String?>? creadoPor,
    Value<String>? asignadoA,
    Value<String>? estado,
    Value<int>? rowid,
  }) {
    return TareasTableCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      groupId: groupId ?? this.groupId,
      reporteId: reporteId ?? this.reporteId,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      creadoPor: creadoPor ?? this.creadoPor,
      asignadoA: asignadoA ?? this.asignadoA,
      estado: estado ?? this.estado,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (reporteId.present) {
      map['reporte_id'] = Variable<String>(reporteId.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (creadoPor.present) {
      map['creado_por'] = Variable<String>(creadoPor.value);
    }
    if (asignadoA.present) {
      map['asignado_a'] = Variable<String>(asignadoA.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TareasTableCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('groupId: $groupId, ')
          ..write('reporteId: $reporteId, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('creadoPor: $creadoPor, ')
          ..write('asignadoA: $asignadoA, ')
          ..write('estado: $estado, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TareaComentariosTableTable extends TareaComentariosTable
    with TableInfo<$TareaComentariosTableTable, TareaComentariosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TareaComentariosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tareaIdMeta = const VerificationMeta(
    'tareaId',
  );
  @override
  late final GeneratedColumn<String> tareaId = GeneratedColumn<String>(
    'tarea_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _autorIdMeta = const VerificationMeta(
    'autorId',
  );
  @override
  late final GeneratedColumn<String> autorId = GeneratedColumn<String>(
    'autor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mensajeMeta = const VerificationMeta(
    'mensaje',
  );
  @override
  late final GeneratedColumn<String> mensaje = GeneratedColumn<String>(
    'mensaje',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tareaId,
    autorId,
    mensaje,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarea_comentarios_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TareaComentariosTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tarea_id')) {
      context.handle(
        _tareaIdMeta,
        tareaId.isAcceptableOrUnknown(data['tarea_id']!, _tareaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tareaIdMeta);
    }
    if (data.containsKey('autor_id')) {
      context.handle(
        _autorIdMeta,
        autorId.isAcceptableOrUnknown(data['autor_id']!, _autorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_autorIdMeta);
    }
    if (data.containsKey('mensaje')) {
      context.handle(
        _mensajeMeta,
        mensaje.isAcceptableOrUnknown(data['mensaje']!, _mensajeMeta),
      );
    } else if (isInserting) {
      context.missing(_mensajeMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TareaComentariosTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TareaComentariosTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tareaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tarea_id'],
      )!,
      autorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}autor_id'],
      )!,
      mensaje: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mensaje'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $TareaComentariosTableTable createAlias(String alias) {
    return $TareaComentariosTableTable(attachedDatabase, alias);
  }
}

class TareaComentariosTableData extends DataClass
    implements Insertable<TareaComentariosTableData> {
  final String id;
  final String tareaId;
  final String autorId;
  final String mensaje;
  final DateTime creadoEn;
  const TareaComentariosTableData({
    required this.id,
    required this.tareaId,
    required this.autorId,
    required this.mensaje,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tarea_id'] = Variable<String>(tareaId);
    map['autor_id'] = Variable<String>(autorId);
    map['mensaje'] = Variable<String>(mensaje);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  TareaComentariosTableCompanion toCompanion(bool nullToAbsent) {
    return TareaComentariosTableCompanion(
      id: Value(id),
      tareaId: Value(tareaId),
      autorId: Value(autorId),
      mensaje: Value(mensaje),
      creadoEn: Value(creadoEn),
    );
  }

  factory TareaComentariosTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TareaComentariosTableData(
      id: serializer.fromJson<String>(json['id']),
      tareaId: serializer.fromJson<String>(json['tareaId']),
      autorId: serializer.fromJson<String>(json['autorId']),
      mensaje: serializer.fromJson<String>(json['mensaje']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tareaId': serializer.toJson<String>(tareaId),
      'autorId': serializer.toJson<String>(autorId),
      'mensaje': serializer.toJson<String>(mensaje),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  TareaComentariosTableData copyWith({
    String? id,
    String? tareaId,
    String? autorId,
    String? mensaje,
    DateTime? creadoEn,
  }) => TareaComentariosTableData(
    id: id ?? this.id,
    tareaId: tareaId ?? this.tareaId,
    autorId: autorId ?? this.autorId,
    mensaje: mensaje ?? this.mensaje,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  TareaComentariosTableData copyWithCompanion(
    TareaComentariosTableCompanion data,
  ) {
    return TareaComentariosTableData(
      id: data.id.present ? data.id.value : this.id,
      tareaId: data.tareaId.present ? data.tareaId.value : this.tareaId,
      autorId: data.autorId.present ? data.autorId.value : this.autorId,
      mensaje: data.mensaje.present ? data.mensaje.value : this.mensaje,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TareaComentariosTableData(')
          ..write('id: $id, ')
          ..write('tareaId: $tareaId, ')
          ..write('autorId: $autorId, ')
          ..write('mensaje: $mensaje, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tareaId, autorId, mensaje, creadoEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TareaComentariosTableData &&
          other.id == this.id &&
          other.tareaId == this.tareaId &&
          other.autorId == this.autorId &&
          other.mensaje == this.mensaje &&
          other.creadoEn == this.creadoEn);
}

class TareaComentariosTableCompanion
    extends UpdateCompanion<TareaComentariosTableData> {
  final Value<String> id;
  final Value<String> tareaId;
  final Value<String> autorId;
  final Value<String> mensaje;
  final Value<DateTime> creadoEn;
  final Value<int> rowid;
  const TareaComentariosTableCompanion({
    this.id = const Value.absent(),
    this.tareaId = const Value.absent(),
    this.autorId = const Value.absent(),
    this.mensaje = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TareaComentariosTableCompanion.insert({
    required String id,
    required String tareaId,
    required String autorId,
    required String mensaje,
    required DateTime creadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tareaId = Value(tareaId),
       autorId = Value(autorId),
       mensaje = Value(mensaje),
       creadoEn = Value(creadoEn);
  static Insertable<TareaComentariosTableData> custom({
    Expression<String>? id,
    Expression<String>? tareaId,
    Expression<String>? autorId,
    Expression<String>? mensaje,
    Expression<DateTime>? creadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tareaId != null) 'tarea_id': tareaId,
      if (autorId != null) 'autor_id': autorId,
      if (mensaje != null) 'mensaje': mensaje,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TareaComentariosTableCompanion copyWith({
    Value<String>? id,
    Value<String>? tareaId,
    Value<String>? autorId,
    Value<String>? mensaje,
    Value<DateTime>? creadoEn,
    Value<int>? rowid,
  }) {
    return TareaComentariosTableCompanion(
      id: id ?? this.id,
      tareaId: tareaId ?? this.tareaId,
      autorId: autorId ?? this.autorId,
      mensaje: mensaje ?? this.mensaje,
      creadoEn: creadoEn ?? this.creadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tareaId.present) {
      map['tarea_id'] = Variable<String>(tareaId.value);
    }
    if (autorId.present) {
      map['autor_id'] = Variable<String>(autorId.value);
    }
    if (mensaje.present) {
      map['mensaje'] = Variable<String>(mensaje.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TareaComentariosTableCompanion(')
          ..write('id: $id, ')
          ..write('tareaId: $tareaId, ')
          ..write('autorId: $autorId, ')
          ..write('mensaje: $mensaje, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TareaAdjuntosTableTable extends TareaAdjuntosTable
    with TableInfo<$TareaAdjuntosTableTable, TareaAdjuntosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TareaAdjuntosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tareaIdMeta = const VerificationMeta(
    'tareaId',
  );
  @override
  late final GeneratedColumn<String> tareaId = GeneratedColumn<String>(
    'tarea_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteUrlMeta = const VerificationMeta(
    'remoteUrl',
  );
  @override
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
    'remote_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tareaId,
    tipo,
    nombre,
    localPath,
    mimeType,
    remoteUrl,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarea_adjuntos_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TareaAdjuntosTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tarea_id')) {
      context.handle(
        _tareaIdMeta,
        tareaId.isAcceptableOrUnknown(data['tarea_id']!, _tareaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tareaIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('remote_url')) {
      context.handle(
        _remoteUrlMeta,
        remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TareaAdjuntosTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TareaAdjuntosTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tareaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tarea_id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      remoteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_url'],
      ),
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $TareaAdjuntosTableTable createAlias(String alias) {
    return $TareaAdjuntosTableTable(attachedDatabase, alias);
  }
}

class TareaAdjuntosTableData extends DataClass
    implements Insertable<TareaAdjuntosTableData> {
  final String id;
  final String tareaId;

  /// 'foto' o 'documento'
  final String tipo;
  final String nombre;
  final String localPath;
  final String? mimeType;
  final String? remoteUrl;
  final DateTime creadoEn;
  const TareaAdjuntosTableData({
    required this.id,
    required this.tareaId,
    required this.tipo,
    required this.nombre,
    required this.localPath,
    this.mimeType,
    this.remoteUrl,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tarea_id'] = Variable<String>(tareaId);
    map['tipo'] = Variable<String>(tipo);
    map['nombre'] = Variable<String>(nombre);
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || remoteUrl != null) {
      map['remote_url'] = Variable<String>(remoteUrl);
    }
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  TareaAdjuntosTableCompanion toCompanion(bool nullToAbsent) {
    return TareaAdjuntosTableCompanion(
      id: Value(id),
      tareaId: Value(tareaId),
      tipo: Value(tipo),
      nombre: Value(nombre),
      localPath: Value(localPath),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      remoteUrl: remoteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteUrl),
      creadoEn: Value(creadoEn),
    );
  }

  factory TareaAdjuntosTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TareaAdjuntosTableData(
      id: serializer.fromJson<String>(json['id']),
      tareaId: serializer.fromJson<String>(json['tareaId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      nombre: serializer.fromJson<String>(json['nombre']),
      localPath: serializer.fromJson<String>(json['localPath']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      remoteUrl: serializer.fromJson<String?>(json['remoteUrl']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tareaId': serializer.toJson<String>(tareaId),
      'tipo': serializer.toJson<String>(tipo),
      'nombre': serializer.toJson<String>(nombre),
      'localPath': serializer.toJson<String>(localPath),
      'mimeType': serializer.toJson<String?>(mimeType),
      'remoteUrl': serializer.toJson<String?>(remoteUrl),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  TareaAdjuntosTableData copyWith({
    String? id,
    String? tareaId,
    String? tipo,
    String? nombre,
    String? localPath,
    Value<String?> mimeType = const Value.absent(),
    Value<String?> remoteUrl = const Value.absent(),
    DateTime? creadoEn,
  }) => TareaAdjuntosTableData(
    id: id ?? this.id,
    tareaId: tareaId ?? this.tareaId,
    tipo: tipo ?? this.tipo,
    nombre: nombre ?? this.nombre,
    localPath: localPath ?? this.localPath,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    remoteUrl: remoteUrl.present ? remoteUrl.value : this.remoteUrl,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  TareaAdjuntosTableData copyWithCompanion(TareaAdjuntosTableCompanion data) {
    return TareaAdjuntosTableData(
      id: data.id.present ? data.id.value : this.id,
      tareaId: data.tareaId.present ? data.tareaId.value : this.tareaId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TareaAdjuntosTableData(')
          ..write('id: $id, ')
          ..write('tareaId: $tareaId, ')
          ..write('tipo: $tipo, ')
          ..write('nombre: $nombre, ')
          ..write('localPath: $localPath, ')
          ..write('mimeType: $mimeType, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tareaId,
    tipo,
    nombre,
    localPath,
    mimeType,
    remoteUrl,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TareaAdjuntosTableData &&
          other.id == this.id &&
          other.tareaId == this.tareaId &&
          other.tipo == this.tipo &&
          other.nombre == this.nombre &&
          other.localPath == this.localPath &&
          other.mimeType == this.mimeType &&
          other.remoteUrl == this.remoteUrl &&
          other.creadoEn == this.creadoEn);
}

class TareaAdjuntosTableCompanion
    extends UpdateCompanion<TareaAdjuntosTableData> {
  final Value<String> id;
  final Value<String> tareaId;
  final Value<String> tipo;
  final Value<String> nombre;
  final Value<String> localPath;
  final Value<String?> mimeType;
  final Value<String?> remoteUrl;
  final Value<DateTime> creadoEn;
  final Value<int> rowid;
  const TareaAdjuntosTableCompanion({
    this.id = const Value.absent(),
    this.tareaId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.localPath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TareaAdjuntosTableCompanion.insert({
    required String id,
    required String tareaId,
    required String tipo,
    required String nombre,
    required String localPath,
    this.mimeType = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    required DateTime creadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tareaId = Value(tareaId),
       tipo = Value(tipo),
       nombre = Value(nombre),
       localPath = Value(localPath),
       creadoEn = Value(creadoEn);
  static Insertable<TareaAdjuntosTableData> custom({
    Expression<String>? id,
    Expression<String>? tareaId,
    Expression<String>? tipo,
    Expression<String>? nombre,
    Expression<String>? localPath,
    Expression<String>? mimeType,
    Expression<String>? remoteUrl,
    Expression<DateTime>? creadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tareaId != null) 'tarea_id': tareaId,
      if (tipo != null) 'tipo': tipo,
      if (nombre != null) 'nombre': nombre,
      if (localPath != null) 'local_path': localPath,
      if (mimeType != null) 'mime_type': mimeType,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TareaAdjuntosTableCompanion copyWith({
    Value<String>? id,
    Value<String>? tareaId,
    Value<String>? tipo,
    Value<String>? nombre,
    Value<String>? localPath,
    Value<String?>? mimeType,
    Value<String?>? remoteUrl,
    Value<DateTime>? creadoEn,
    Value<int>? rowid,
  }) {
    return TareaAdjuntosTableCompanion(
      id: id ?? this.id,
      tareaId: tareaId ?? this.tareaId,
      tipo: tipo ?? this.tipo,
      nombre: nombre ?? this.nombre,
      localPath: localPath ?? this.localPath,
      mimeType: mimeType ?? this.mimeType,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      creadoEn: creadoEn ?? this.creadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tareaId.present) {
      map['tarea_id'] = Variable<String>(tareaId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TareaAdjuntosTableCompanion(')
          ..write('id: $id, ')
          ..write('tareaId: $tareaId, ')
          ..write('tipo: $tipo, ')
          ..write('nombre: $nombre, ')
          ..write('localPath: $localPath, ')
          ..write('mimeType: $mimeType, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReportesTableTable extends ReportesTable
    with TableInfo<$ReportesTableTable, ReportesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaMeta = const VerificationMeta(
    'categoria',
  );
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
    'categoria',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<String> activo = GeneratedColumn<String>(
    'activo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ubicacionMeta = const VerificationMeta(
    'ubicacion',
  );
  @override
  late final GeneratedColumn<String> ubicacion = GeneratedColumn<String>(
    'ubicacion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creadoPorMeta = const VerificationMeta(
    'creadoPor',
  );
  @override
  late final GeneratedColumn<String> creadoPor = GeneratedColumn<String>(
    'creado_por',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _glpiTicketIdMeta = const VerificationMeta(
    'glpiTicketId',
  );
  @override
  late final GeneratedColumn<String> glpiTicketId = GeneratedColumn<String>(
    'glpi_ticket_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    titulo,
    descripcion,
    categoria,
    area,
    activo,
    ubicacion,
    creadoPor,
    creadoEn,
    estado,
    glpiTicketId,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reportes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReportesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(
        _categoriaMeta,
        categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta),
      );
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    } else if (isInserting) {
      context.missing(_areaMeta);
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('ubicacion')) {
      context.handle(
        _ubicacionMeta,
        ubicacion.isAcceptableOrUnknown(data['ubicacion']!, _ubicacionMeta),
      );
    }
    if (data.containsKey('creado_por')) {
      context.handle(
        _creadoPorMeta,
        creadoPor.isAcceptableOrUnknown(data['creado_por']!, _creadoPorMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoPorMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('glpi_ticket_id')) {
      context.handle(
        _glpiTicketIdMeta,
        glpiTicketId.isAcceptableOrUnknown(
          data['glpi_ticket_id']!,
          _glpiTicketIdMeta,
        ),
      );
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReportesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReportesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      categoria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categoria'],
      )!,
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activo'],
      ),
      ubicacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ubicacion'],
      ),
      creadoPor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creado_por'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      glpiTicketId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}glpi_ticket_id'],
      ),
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      ),
    );
  }

  @override
  $ReportesTableTable createAlias(String alias) {
    return $ReportesTableTable(attachedDatabase, alias);
  }
}

class ReportesTableData extends DataClass
    implements Insertable<ReportesTableData> {
  final String id;
  final String titulo;
  final String descripcion;
  final String categoria;
  final String area;
  final String? activo;
  final String? ubicacion;
  final String creadoPor;
  final DateTime creadoEn;
  final String estado;
  final String? glpiTicketId;
  final String? metadata;
  const ReportesTableData({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.categoria,
    required this.area,
    this.activo,
    this.ubicacion,
    required this.creadoPor,
    required this.creadoEn,
    required this.estado,
    this.glpiTicketId,
    this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['titulo'] = Variable<String>(titulo);
    map['descripcion'] = Variable<String>(descripcion);
    map['categoria'] = Variable<String>(categoria);
    map['area'] = Variable<String>(area);
    if (!nullToAbsent || activo != null) {
      map['activo'] = Variable<String>(activo);
    }
    if (!nullToAbsent || ubicacion != null) {
      map['ubicacion'] = Variable<String>(ubicacion);
    }
    map['creado_por'] = Variable<String>(creadoPor);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    map['estado'] = Variable<String>(estado);
    if (!nullToAbsent || glpiTicketId != null) {
      map['glpi_ticket_id'] = Variable<String>(glpiTicketId);
    }
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  ReportesTableCompanion toCompanion(bool nullToAbsent) {
    return ReportesTableCompanion(
      id: Value(id),
      titulo: Value(titulo),
      descripcion: Value(descripcion),
      categoria: Value(categoria),
      area: Value(area),
      activo: activo == null && nullToAbsent
          ? const Value.absent()
          : Value(activo),
      ubicacion: ubicacion == null && nullToAbsent
          ? const Value.absent()
          : Value(ubicacion),
      creadoPor: Value(creadoPor),
      creadoEn: Value(creadoEn),
      estado: Value(estado),
      glpiTicketId: glpiTicketId == null && nullToAbsent
          ? const Value.absent()
          : Value(glpiTicketId),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
    );
  }

  factory ReportesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReportesTableData(
      id: serializer.fromJson<String>(json['id']),
      titulo: serializer.fromJson<String>(json['titulo']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      categoria: serializer.fromJson<String>(json['categoria']),
      area: serializer.fromJson<String>(json['area']),
      activo: serializer.fromJson<String?>(json['activo']),
      ubicacion: serializer.fromJson<String?>(json['ubicacion']),
      creadoPor: serializer.fromJson<String>(json['creadoPor']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
      estado: serializer.fromJson<String>(json['estado']),
      glpiTicketId: serializer.fromJson<String?>(json['glpiTicketId']),
      metadata: serializer.fromJson<String?>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'titulo': serializer.toJson<String>(titulo),
      'descripcion': serializer.toJson<String>(descripcion),
      'categoria': serializer.toJson<String>(categoria),
      'area': serializer.toJson<String>(area),
      'activo': serializer.toJson<String?>(activo),
      'ubicacion': serializer.toJson<String?>(ubicacion),
      'creadoPor': serializer.toJson<String>(creadoPor),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
      'estado': serializer.toJson<String>(estado),
      'glpiTicketId': serializer.toJson<String?>(glpiTicketId),
      'metadata': serializer.toJson<String?>(metadata),
    };
  }

  ReportesTableData copyWith({
    String? id,
    String? titulo,
    String? descripcion,
    String? categoria,
    String? area,
    Value<String?> activo = const Value.absent(),
    Value<String?> ubicacion = const Value.absent(),
    String? creadoPor,
    DateTime? creadoEn,
    String? estado,
    Value<String?> glpiTicketId = const Value.absent(),
    Value<String?> metadata = const Value.absent(),
  }) => ReportesTableData(
    id: id ?? this.id,
    titulo: titulo ?? this.titulo,
    descripcion: descripcion ?? this.descripcion,
    categoria: categoria ?? this.categoria,
    area: area ?? this.area,
    activo: activo.present ? activo.value : this.activo,
    ubicacion: ubicacion.present ? ubicacion.value : this.ubicacion,
    creadoPor: creadoPor ?? this.creadoPor,
    creadoEn: creadoEn ?? this.creadoEn,
    estado: estado ?? this.estado,
    glpiTicketId: glpiTicketId.present ? glpiTicketId.value : this.glpiTicketId,
    metadata: metadata.present ? metadata.value : this.metadata,
  );
  ReportesTableData copyWithCompanion(ReportesTableCompanion data) {
    return ReportesTableData(
      id: data.id.present ? data.id.value : this.id,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      area: data.area.present ? data.area.value : this.area,
      activo: data.activo.present ? data.activo.value : this.activo,
      ubicacion: data.ubicacion.present ? data.ubicacion.value : this.ubicacion,
      creadoPor: data.creadoPor.present ? data.creadoPor.value : this.creadoPor,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      estado: data.estado.present ? data.estado.value : this.estado,
      glpiTicketId: data.glpiTicketId.present
          ? data.glpiTicketId.value
          : this.glpiTicketId,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReportesTableData(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('categoria: $categoria, ')
          ..write('area: $area, ')
          ..write('activo: $activo, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('creadoPor: $creadoPor, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('estado: $estado, ')
          ..write('glpiTicketId: $glpiTicketId, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    titulo,
    descripcion,
    categoria,
    area,
    activo,
    ubicacion,
    creadoPor,
    creadoEn,
    estado,
    glpiTicketId,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReportesTableData &&
          other.id == this.id &&
          other.titulo == this.titulo &&
          other.descripcion == this.descripcion &&
          other.categoria == this.categoria &&
          other.area == this.area &&
          other.activo == this.activo &&
          other.ubicacion == this.ubicacion &&
          other.creadoPor == this.creadoPor &&
          other.creadoEn == this.creadoEn &&
          other.estado == this.estado &&
          other.glpiTicketId == this.glpiTicketId &&
          other.metadata == this.metadata);
}

class ReportesTableCompanion extends UpdateCompanion<ReportesTableData> {
  final Value<String> id;
  final Value<String> titulo;
  final Value<String> descripcion;
  final Value<String> categoria;
  final Value<String> area;
  final Value<String?> activo;
  final Value<String?> ubicacion;
  final Value<String> creadoPor;
  final Value<DateTime> creadoEn;
  final Value<String> estado;
  final Value<String?> glpiTicketId;
  final Value<String?> metadata;
  final Value<int> rowid;
  const ReportesTableCompanion({
    this.id = const Value.absent(),
    this.titulo = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.categoria = const Value.absent(),
    this.area = const Value.absent(),
    this.activo = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.creadoPor = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.estado = const Value.absent(),
    this.glpiTicketId = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReportesTableCompanion.insert({
    required String id,
    required String titulo,
    required String descripcion,
    required String categoria,
    required String area,
    this.activo = const Value.absent(),
    this.ubicacion = const Value.absent(),
    required String creadoPor,
    required DateTime creadoEn,
    required String estado,
    this.glpiTicketId = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       titulo = Value(titulo),
       descripcion = Value(descripcion),
       categoria = Value(categoria),
       area = Value(area),
       creadoPor = Value(creadoPor),
       creadoEn = Value(creadoEn),
       estado = Value(estado);
  static Insertable<ReportesTableData> custom({
    Expression<String>? id,
    Expression<String>? titulo,
    Expression<String>? descripcion,
    Expression<String>? categoria,
    Expression<String>? area,
    Expression<String>? activo,
    Expression<String>? ubicacion,
    Expression<String>? creadoPor,
    Expression<DateTime>? creadoEn,
    Expression<String>? estado,
    Expression<String>? glpiTicketId,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titulo != null) 'titulo': titulo,
      if (descripcion != null) 'descripcion': descripcion,
      if (categoria != null) 'categoria': categoria,
      if (area != null) 'area': area,
      if (activo != null) 'activo': activo,
      if (ubicacion != null) 'ubicacion': ubicacion,
      if (creadoPor != null) 'creado_por': creadoPor,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (estado != null) 'estado': estado,
      if (glpiTicketId != null) 'glpi_ticket_id': glpiTicketId,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReportesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? titulo,
    Value<String>? descripcion,
    Value<String>? categoria,
    Value<String>? area,
    Value<String?>? activo,
    Value<String?>? ubicacion,
    Value<String>? creadoPor,
    Value<DateTime>? creadoEn,
    Value<String>? estado,
    Value<String?>? glpiTicketId,
    Value<String?>? metadata,
    Value<int>? rowid,
  }) {
    return ReportesTableCompanion(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      categoria: categoria ?? this.categoria,
      area: area ?? this.area,
      activo: activo ?? this.activo,
      ubicacion: ubicacion ?? this.ubicacion,
      creadoPor: creadoPor ?? this.creadoPor,
      creadoEn: creadoEn ?? this.creadoEn,
      estado: estado ?? this.estado,
      glpiTicketId: glpiTicketId ?? this.glpiTicketId,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (activo.present) {
      map['activo'] = Variable<String>(activo.value);
    }
    if (ubicacion.present) {
      map['ubicacion'] = Variable<String>(ubicacion.value);
    }
    if (creadoPor.present) {
      map['creado_por'] = Variable<String>(creadoPor.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (glpiTicketId.present) {
      map['glpi_ticket_id'] = Variable<String>(glpiTicketId.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportesTableCompanion(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('categoria: $categoria, ')
          ..write('area: $area, ')
          ..write('activo: $activo, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('creadoPor: $creadoPor, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('estado: $estado, ')
          ..write('glpiTicketId: $glpiTicketId, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReporteComentariosTableTable extends ReporteComentariosTable
    with TableInfo<$ReporteComentariosTableTable, ReporteComentariosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReporteComentariosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reporteIdMeta = const VerificationMeta(
    'reporteId',
  );
  @override
  late final GeneratedColumn<String> reporteId = GeneratedColumn<String>(
    'reporte_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _autorIdMeta = const VerificationMeta(
    'autorId',
  );
  @override
  late final GeneratedColumn<String> autorId = GeneratedColumn<String>(
    'autor_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mensajeMeta = const VerificationMeta(
    'mensaje',
  );
  @override
  late final GeneratedColumn<String> mensaje = GeneratedColumn<String>(
    'mensaje',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reporteId,
    autorId,
    mensaje,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reporte_comentarios_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReporteComentariosTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('reporte_id')) {
      context.handle(
        _reporteIdMeta,
        reporteId.isAcceptableOrUnknown(data['reporte_id']!, _reporteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reporteIdMeta);
    }
    if (data.containsKey('autor_id')) {
      context.handle(
        _autorIdMeta,
        autorId.isAcceptableOrUnknown(data['autor_id']!, _autorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_autorIdMeta);
    }
    if (data.containsKey('mensaje')) {
      context.handle(
        _mensajeMeta,
        mensaje.isAcceptableOrUnknown(data['mensaje']!, _mensajeMeta),
      );
    } else if (isInserting) {
      context.missing(_mensajeMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReporteComentariosTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReporteComentariosTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reporteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reporte_id'],
      )!,
      autorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}autor_id'],
      )!,
      mensaje: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mensaje'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $ReporteComentariosTableTable createAlias(String alias) {
    return $ReporteComentariosTableTable(attachedDatabase, alias);
  }
}

class ReporteComentariosTableData extends DataClass
    implements Insertable<ReporteComentariosTableData> {
  final String id;
  final String reporteId;
  final String autorId;
  final String mensaje;
  final DateTime creadoEn;
  const ReporteComentariosTableData({
    required this.id,
    required this.reporteId,
    required this.autorId,
    required this.mensaje,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['reporte_id'] = Variable<String>(reporteId);
    map['autor_id'] = Variable<String>(autorId);
    map['mensaje'] = Variable<String>(mensaje);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  ReporteComentariosTableCompanion toCompanion(bool nullToAbsent) {
    return ReporteComentariosTableCompanion(
      id: Value(id),
      reporteId: Value(reporteId),
      autorId: Value(autorId),
      mensaje: Value(mensaje),
      creadoEn: Value(creadoEn),
    );
  }

  factory ReporteComentariosTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReporteComentariosTableData(
      id: serializer.fromJson<String>(json['id']),
      reporteId: serializer.fromJson<String>(json['reporteId']),
      autorId: serializer.fromJson<String>(json['autorId']),
      mensaje: serializer.fromJson<String>(json['mensaje']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reporteId': serializer.toJson<String>(reporteId),
      'autorId': serializer.toJson<String>(autorId),
      'mensaje': serializer.toJson<String>(mensaje),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  ReporteComentariosTableData copyWith({
    String? id,
    String? reporteId,
    String? autorId,
    String? mensaje,
    DateTime? creadoEn,
  }) => ReporteComentariosTableData(
    id: id ?? this.id,
    reporteId: reporteId ?? this.reporteId,
    autorId: autorId ?? this.autorId,
    mensaje: mensaje ?? this.mensaje,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  ReporteComentariosTableData copyWithCompanion(
    ReporteComentariosTableCompanion data,
  ) {
    return ReporteComentariosTableData(
      id: data.id.present ? data.id.value : this.id,
      reporteId: data.reporteId.present ? data.reporteId.value : this.reporteId,
      autorId: data.autorId.present ? data.autorId.value : this.autorId,
      mensaje: data.mensaje.present ? data.mensaje.value : this.mensaje,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReporteComentariosTableData(')
          ..write('id: $id, ')
          ..write('reporteId: $reporteId, ')
          ..write('autorId: $autorId, ')
          ..write('mensaje: $mensaje, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reporteId, autorId, mensaje, creadoEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReporteComentariosTableData &&
          other.id == this.id &&
          other.reporteId == this.reporteId &&
          other.autorId == this.autorId &&
          other.mensaje == this.mensaje &&
          other.creadoEn == this.creadoEn);
}

class ReporteComentariosTableCompanion
    extends UpdateCompanion<ReporteComentariosTableData> {
  final Value<String> id;
  final Value<String> reporteId;
  final Value<String> autorId;
  final Value<String> mensaje;
  final Value<DateTime> creadoEn;
  final Value<int> rowid;
  const ReporteComentariosTableCompanion({
    this.id = const Value.absent(),
    this.reporteId = const Value.absent(),
    this.autorId = const Value.absent(),
    this.mensaje = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReporteComentariosTableCompanion.insert({
    required String id,
    required String reporteId,
    required String autorId,
    required String mensaje,
    required DateTime creadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reporteId = Value(reporteId),
       autorId = Value(autorId),
       mensaje = Value(mensaje),
       creadoEn = Value(creadoEn);
  static Insertable<ReporteComentariosTableData> custom({
    Expression<String>? id,
    Expression<String>? reporteId,
    Expression<String>? autorId,
    Expression<String>? mensaje,
    Expression<DateTime>? creadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reporteId != null) 'reporte_id': reporteId,
      if (autorId != null) 'autor_id': autorId,
      if (mensaje != null) 'mensaje': mensaje,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReporteComentariosTableCompanion copyWith({
    Value<String>? id,
    Value<String>? reporteId,
    Value<String>? autorId,
    Value<String>? mensaje,
    Value<DateTime>? creadoEn,
    Value<int>? rowid,
  }) {
    return ReporteComentariosTableCompanion(
      id: id ?? this.id,
      reporteId: reporteId ?? this.reporteId,
      autorId: autorId ?? this.autorId,
      mensaje: mensaje ?? this.mensaje,
      creadoEn: creadoEn ?? this.creadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reporteId.present) {
      map['reporte_id'] = Variable<String>(reporteId.value);
    }
    if (autorId.present) {
      map['autor_id'] = Variable<String>(autorId.value);
    }
    if (mensaje.present) {
      map['mensaje'] = Variable<String>(mensaje.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReporteComentariosTableCompanion(')
          ..write('id: $id, ')
          ..write('reporteId: $reporteId, ')
          ..write('autorId: $autorId, ')
          ..write('mensaje: $mensaje, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReporteEvidenciasTableTable extends ReporteEvidenciasTable
    with TableInfo<$ReporteEvidenciasTableTable, ReporteEvidenciasTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReporteEvidenciasTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reporteIdMeta = const VerificationMeta(
    'reporteId',
  );
  @override
  late final GeneratedColumn<String> reporteId = GeneratedColumn<String>(
    'reporte_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remoteUrlMeta = const VerificationMeta(
    'remoteUrl',
  );
  @override
  late final GeneratedColumn<String> remoteUrl = GeneratedColumn<String>(
    'remote_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reporteId,
    tipo,
    nombre,
    localPath,
    remoteUrl,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reporte_evidencias_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReporteEvidenciasTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('reporte_id')) {
      context.handle(
        _reporteIdMeta,
        reporteId.isAcceptableOrUnknown(data['reporte_id']!, _reporteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reporteIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('remote_url')) {
      context.handle(
        _remoteUrlMeta,
        remoteUrl.isAcceptableOrUnknown(data['remote_url']!, _remoteUrlMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReporteEvidenciasTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReporteEvidenciasTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reporteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reporte_id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      remoteUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_url'],
      ),
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $ReporteEvidenciasTableTable createAlias(String alias) {
    return $ReporteEvidenciasTableTable(attachedDatabase, alias);
  }
}

class ReporteEvidenciasTableData extends DataClass
    implements Insertable<ReporteEvidenciasTableData> {
  final String id;
  final String reporteId;
  final String tipo;
  final String nombre;
  final String localPath;
  final String? remoteUrl;
  final DateTime creadoEn;
  const ReporteEvidenciasTableData({
    required this.id,
    required this.reporteId,
    required this.tipo,
    required this.nombre,
    required this.localPath,
    this.remoteUrl,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['reporte_id'] = Variable<String>(reporteId);
    map['tipo'] = Variable<String>(tipo);
    map['nombre'] = Variable<String>(nombre);
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || remoteUrl != null) {
      map['remote_url'] = Variable<String>(remoteUrl);
    }
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  ReporteEvidenciasTableCompanion toCompanion(bool nullToAbsent) {
    return ReporteEvidenciasTableCompanion(
      id: Value(id),
      reporteId: Value(reporteId),
      tipo: Value(tipo),
      nombre: Value(nombre),
      localPath: Value(localPath),
      remoteUrl: remoteUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteUrl),
      creadoEn: Value(creadoEn),
    );
  }

  factory ReporteEvidenciasTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReporteEvidenciasTableData(
      id: serializer.fromJson<String>(json['id']),
      reporteId: serializer.fromJson<String>(json['reporteId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      nombre: serializer.fromJson<String>(json['nombre']),
      localPath: serializer.fromJson<String>(json['localPath']),
      remoteUrl: serializer.fromJson<String?>(json['remoteUrl']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reporteId': serializer.toJson<String>(reporteId),
      'tipo': serializer.toJson<String>(tipo),
      'nombre': serializer.toJson<String>(nombre),
      'localPath': serializer.toJson<String>(localPath),
      'remoteUrl': serializer.toJson<String?>(remoteUrl),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  ReporteEvidenciasTableData copyWith({
    String? id,
    String? reporteId,
    String? tipo,
    String? nombre,
    String? localPath,
    Value<String?> remoteUrl = const Value.absent(),
    DateTime? creadoEn,
  }) => ReporteEvidenciasTableData(
    id: id ?? this.id,
    reporteId: reporteId ?? this.reporteId,
    tipo: tipo ?? this.tipo,
    nombre: nombre ?? this.nombre,
    localPath: localPath ?? this.localPath,
    remoteUrl: remoteUrl.present ? remoteUrl.value : this.remoteUrl,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  ReporteEvidenciasTableData copyWithCompanion(
    ReporteEvidenciasTableCompanion data,
  ) {
    return ReporteEvidenciasTableData(
      id: data.id.present ? data.id.value : this.id,
      reporteId: data.reporteId.present ? data.reporteId.value : this.reporteId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      remoteUrl: data.remoteUrl.present ? data.remoteUrl.value : this.remoteUrl,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReporteEvidenciasTableData(')
          ..write('id: $id, ')
          ..write('reporteId: $reporteId, ')
          ..write('tipo: $tipo, ')
          ..write('nombre: $nombre, ')
          ..write('localPath: $localPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, reporteId, tipo, nombre, localPath, remoteUrl, creadoEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReporteEvidenciasTableData &&
          other.id == this.id &&
          other.reporteId == this.reporteId &&
          other.tipo == this.tipo &&
          other.nombre == this.nombre &&
          other.localPath == this.localPath &&
          other.remoteUrl == this.remoteUrl &&
          other.creadoEn == this.creadoEn);
}

class ReporteEvidenciasTableCompanion
    extends UpdateCompanion<ReporteEvidenciasTableData> {
  final Value<String> id;
  final Value<String> reporteId;
  final Value<String> tipo;
  final Value<String> nombre;
  final Value<String> localPath;
  final Value<String?> remoteUrl;
  final Value<DateTime> creadoEn;
  final Value<int> rowid;
  const ReporteEvidenciasTableCompanion({
    this.id = const Value.absent(),
    this.reporteId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.nombre = const Value.absent(),
    this.localPath = const Value.absent(),
    this.remoteUrl = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReporteEvidenciasTableCompanion.insert({
    required String id,
    required String reporteId,
    required String tipo,
    required String nombre,
    required String localPath,
    this.remoteUrl = const Value.absent(),
    required DateTime creadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reporteId = Value(reporteId),
       tipo = Value(tipo),
       nombre = Value(nombre),
       localPath = Value(localPath),
       creadoEn = Value(creadoEn);
  static Insertable<ReporteEvidenciasTableData> custom({
    Expression<String>? id,
    Expression<String>? reporteId,
    Expression<String>? tipo,
    Expression<String>? nombre,
    Expression<String>? localPath,
    Expression<String>? remoteUrl,
    Expression<DateTime>? creadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reporteId != null) 'reporte_id': reporteId,
      if (tipo != null) 'tipo': tipo,
      if (nombre != null) 'nombre': nombre,
      if (localPath != null) 'local_path': localPath,
      if (remoteUrl != null) 'remote_url': remoteUrl,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReporteEvidenciasTableCompanion copyWith({
    Value<String>? id,
    Value<String>? reporteId,
    Value<String>? tipo,
    Value<String>? nombre,
    Value<String>? localPath,
    Value<String?>? remoteUrl,
    Value<DateTime>? creadoEn,
    Value<int>? rowid,
  }) {
    return ReporteEvidenciasTableCompanion(
      id: id ?? this.id,
      reporteId: reporteId ?? this.reporteId,
      tipo: tipo ?? this.tipo,
      nombre: nombre ?? this.nombre,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      creadoEn: creadoEn ?? this.creadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reporteId.present) {
      map['reporte_id'] = Variable<String>(reporteId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (remoteUrl.present) {
      map['remote_url'] = Variable<String>(remoteUrl.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReporteEvidenciasTableCompanion(')
          ..write('id: $id, ')
          ..write('reporteId: $reporteId, ')
          ..write('tipo: $tipo, ')
          ..write('nombre: $nombre, ')
          ..write('localPath: $localPath, ')
          ..write('remoteUrl: $remoteUrl, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReporteParticipantesTableTable extends ReporteParticipantesTable
    with
        TableInfo<
          $ReporteParticipantesTableTable,
          ReporteParticipantesTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReporteParticipantesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _reporteIdMeta = const VerificationMeta(
    'reporteId',
  );
  @override
  late final GeneratedColumn<String> reporteId = GeneratedColumn<String>(
    'reporte_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
    'rol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [reporteId, userId, rol];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reporte_participantes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReporteParticipantesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('reporte_id')) {
      context.handle(
        _reporteIdMeta,
        reporteId.isAcceptableOrUnknown(data['reporte_id']!, _reporteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reporteIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('rol')) {
      context.handle(
        _rolMeta,
        rol.isAcceptableOrUnknown(data['rol']!, _rolMeta),
      );
    } else if (isInserting) {
      context.missing(_rolMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {reporteId, userId};
  @override
  ReporteParticipantesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReporteParticipantesTableData(
      reporteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reporte_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      rol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rol'],
      )!,
    );
  }

  @override
  $ReporteParticipantesTableTable createAlias(String alias) {
    return $ReporteParticipantesTableTable(attachedDatabase, alias);
  }
}

class ReporteParticipantesTableData extends DataClass
    implements Insertable<ReporteParticipantesTableData> {
  final String reporteId;
  final String userId;
  final String rol;
  const ReporteParticipantesTableData({
    required this.reporteId,
    required this.userId,
    required this.rol,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['reporte_id'] = Variable<String>(reporteId);
    map['user_id'] = Variable<String>(userId);
    map['rol'] = Variable<String>(rol);
    return map;
  }

  ReporteParticipantesTableCompanion toCompanion(bool nullToAbsent) {
    return ReporteParticipantesTableCompanion(
      reporteId: Value(reporteId),
      userId: Value(userId),
      rol: Value(rol),
    );
  }

  factory ReporteParticipantesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReporteParticipantesTableData(
      reporteId: serializer.fromJson<String>(json['reporteId']),
      userId: serializer.fromJson<String>(json['userId']),
      rol: serializer.fromJson<String>(json['rol']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'reporteId': serializer.toJson<String>(reporteId),
      'userId': serializer.toJson<String>(userId),
      'rol': serializer.toJson<String>(rol),
    };
  }

  ReporteParticipantesTableData copyWith({
    String? reporteId,
    String? userId,
    String? rol,
  }) => ReporteParticipantesTableData(
    reporteId: reporteId ?? this.reporteId,
    userId: userId ?? this.userId,
    rol: rol ?? this.rol,
  );
  ReporteParticipantesTableData copyWithCompanion(
    ReporteParticipantesTableCompanion data,
  ) {
    return ReporteParticipantesTableData(
      reporteId: data.reporteId.present ? data.reporteId.value : this.reporteId,
      userId: data.userId.present ? data.userId.value : this.userId,
      rol: data.rol.present ? data.rol.value : this.rol,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReporteParticipantesTableData(')
          ..write('reporteId: $reporteId, ')
          ..write('userId: $userId, ')
          ..write('rol: $rol')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(reporteId, userId, rol);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReporteParticipantesTableData &&
          other.reporteId == this.reporteId &&
          other.userId == this.userId &&
          other.rol == this.rol);
}

class ReporteParticipantesTableCompanion
    extends UpdateCompanion<ReporteParticipantesTableData> {
  final Value<String> reporteId;
  final Value<String> userId;
  final Value<String> rol;
  final Value<int> rowid;
  const ReporteParticipantesTableCompanion({
    this.reporteId = const Value.absent(),
    this.userId = const Value.absent(),
    this.rol = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReporteParticipantesTableCompanion.insert({
    required String reporteId,
    required String userId,
    required String rol,
    this.rowid = const Value.absent(),
  }) : reporteId = Value(reporteId),
       userId = Value(userId),
       rol = Value(rol);
  static Insertable<ReporteParticipantesTableData> custom({
    Expression<String>? reporteId,
    Expression<String>? userId,
    Expression<String>? rol,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (reporteId != null) 'reporte_id': reporteId,
      if (userId != null) 'user_id': userId,
      if (rol != null) 'rol': rol,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReporteParticipantesTableCompanion copyWith({
    Value<String>? reporteId,
    Value<String>? userId,
    Value<String>? rol,
    Value<int>? rowid,
  }) {
    return ReporteParticipantesTableCompanion(
      reporteId: reporteId ?? this.reporteId,
      userId: userId ?? this.userId,
      rol: rol ?? this.rol,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (reporteId.present) {
      map['reporte_id'] = Variable<String>(reporteId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReporteParticipantesTableCompanion(')
          ..write('reporteId: $reporteId, ')
          ..write('userId: $userId, ')
          ..write('rol: $rol, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AsistenciaTableTable asistenciaTable = $AsistenciaTableTable(
    this,
  );
  late final $NotificationsTableTable notificationsTable =
      $NotificationsTableTable(this);
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  late final $TareasTableTable tareasTable = $TareasTableTable(this);
  late final $TareaComentariosTableTable tareaComentariosTable =
      $TareaComentariosTableTable(this);
  late final $TareaAdjuntosTableTable tareaAdjuntosTable =
      $TareaAdjuntosTableTable(this);
  late final $ReportesTableTable reportesTable = $ReportesTableTable(this);
  late final $ReporteComentariosTableTable reporteComentariosTable =
      $ReporteComentariosTableTable(this);
  late final $ReporteEvidenciasTableTable reporteEvidenciasTable =
      $ReporteEvidenciasTableTable(this);
  late final $ReporteParticipantesTableTable reporteParticipantesTable =
      $ReporteParticipantesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    asistenciaTable,
    notificationsTable,
    syncQueueTable,
    tareasTable,
    tareaComentariosTable,
    tareaAdjuntosTable,
    reportesTable,
    reporteComentariosTable,
    reporteEvidenciasTable,
    reporteParticipantesTable,
  ];
}

typedef $$AsistenciaTableTableCreateCompanionBuilder =
    AsistenciaTableCompanion Function({
      Value<int> id,
      required String usuarioId,
      required DateTime fechaHora,
      required String tipo,
      Value<String> metodo,
      Value<bool> sincronizado,
      Value<DateTime> creadoEn,
    });
typedef $$AsistenciaTableTableUpdateCompanionBuilder =
    AsistenciaTableCompanion Function({
      Value<int> id,
      Value<String> usuarioId,
      Value<DateTime> fechaHora,
      Value<String> tipo,
      Value<String> metodo,
      Value<bool> sincronizado,
      Value<DateTime> creadoEn,
    });

class $$AsistenciaTableTableFilterComposer
    extends Composer<_$AppDatabase, $AsistenciaTableTable> {
  $$AsistenciaTableTableFilterComposer({
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

  ColumnFilters<String> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaHora => $composableBuilder(
    column: $table.fechaHora,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metodo => $composableBuilder(
    column: $table.metodo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AsistenciaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AsistenciaTableTable> {
  $$AsistenciaTableTableOrderingComposer({
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

  ColumnOrderings<String> get usuarioId => $composableBuilder(
    column: $table.usuarioId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaHora => $composableBuilder(
    column: $table.fechaHora,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodo => $composableBuilder(
    column: $table.metodo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AsistenciaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AsistenciaTableTable> {
  $$AsistenciaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get usuarioId =>
      $composableBuilder(column: $table.usuarioId, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaHora =>
      $composableBuilder(column: $table.fechaHora, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get metodo =>
      $composableBuilder(column: $table.metodo, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);
}

class $$AsistenciaTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AsistenciaTableTable,
          AsistenciaTableData,
          $$AsistenciaTableTableFilterComposer,
          $$AsistenciaTableTableOrderingComposer,
          $$AsistenciaTableTableAnnotationComposer,
          $$AsistenciaTableTableCreateCompanionBuilder,
          $$AsistenciaTableTableUpdateCompanionBuilder,
          (
            AsistenciaTableData,
            BaseReferences<
              _$AppDatabase,
              $AsistenciaTableTable,
              AsistenciaTableData
            >,
          ),
          AsistenciaTableData,
          PrefetchHooks Function()
        > {
  $$AsistenciaTableTableTableManager(
    _$AppDatabase db,
    $AsistenciaTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AsistenciaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AsistenciaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AsistenciaTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> usuarioId = const Value.absent(),
                Value<DateTime> fechaHora = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String> metodo = const Value.absent(),
                Value<bool> sincronizado = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
              }) => AsistenciaTableCompanion(
                id: id,
                usuarioId: usuarioId,
                fechaHora: fechaHora,
                tipo: tipo,
                metodo: metodo,
                sincronizado: sincronizado,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String usuarioId,
                required DateTime fechaHora,
                required String tipo,
                Value<String> metodo = const Value.absent(),
                Value<bool> sincronizado = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
              }) => AsistenciaTableCompanion.insert(
                id: id,
                usuarioId: usuarioId,
                fechaHora: fechaHora,
                tipo: tipo,
                metodo: metodo,
                sincronizado: sincronizado,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AsistenciaTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AsistenciaTableTable,
      AsistenciaTableData,
      $$AsistenciaTableTableFilterComposer,
      $$AsistenciaTableTableOrderingComposer,
      $$AsistenciaTableTableAnnotationComposer,
      $$AsistenciaTableTableCreateCompanionBuilder,
      $$AsistenciaTableTableUpdateCompanionBuilder,
      (
        AsistenciaTableData,
        BaseReferences<
          _$AppDatabase,
          $AsistenciaTableTable,
          AsistenciaTableData
        >,
      ),
      AsistenciaTableData,
      PrefetchHooks Function()
    >;
typedef $$NotificationsTableTableCreateCompanionBuilder =
    NotificationsTableCompanion Function({
      required String id,
      required String titulo,
      required String mensaje,
      Value<String> tipo,
      Value<bool> leida,
      Value<String?> origen,
      Value<DateTime> fecha,
      Value<int> rowid,
    });
typedef $$NotificationsTableTableUpdateCompanionBuilder =
    NotificationsTableCompanion Function({
      Value<String> id,
      Value<String> titulo,
      Value<String> mensaje,
      Value<String> tipo,
      Value<bool> leida,
      Value<String?> origen,
      Value<DateTime> fecha,
      Value<int> rowid,
    });

class $$NotificationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTableTable> {
  $$NotificationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mensaje => $composableBuilder(
    column: $table.mensaje,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get leida => $composableBuilder(
    column: $table.leida,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origen => $composableBuilder(
    column: $table.origen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTableTable> {
  $$NotificationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mensaje => $composableBuilder(
    column: $table.mensaje,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get leida => $composableBuilder(
    column: $table.leida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origen => $composableBuilder(
    column: $table.origen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTableTable> {
  $$NotificationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get mensaje =>
      $composableBuilder(column: $table.mensaje, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<bool> get leida =>
      $composableBuilder(column: $table.leida, builder: (column) => column);

  GeneratedColumn<String> get origen =>
      $composableBuilder(column: $table.origen, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);
}

class $$NotificationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTableTable,
          NotificationsTableData,
          $$NotificationsTableTableFilterComposer,
          $$NotificationsTableTableOrderingComposer,
          $$NotificationsTableTableAnnotationComposer,
          $$NotificationsTableTableCreateCompanionBuilder,
          $$NotificationsTableTableUpdateCompanionBuilder,
          (
            NotificationsTableData,
            BaseReferences<
              _$AppDatabase,
              $NotificationsTableTable,
              NotificationsTableData
            >,
          ),
          NotificationsTableData,
          PrefetchHooks Function()
        > {
  $$NotificationsTableTableTableManager(
    _$AppDatabase db,
    $NotificationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String> mensaje = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<bool> leida = const Value.absent(),
                Value<String?> origen = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationsTableCompanion(
                id: id,
                titulo: titulo,
                mensaje: mensaje,
                tipo: tipo,
                leida: leida,
                origen: origen,
                fecha: fecha,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String titulo,
                required String mensaje,
                Value<String> tipo = const Value.absent(),
                Value<bool> leida = const Value.absent(),
                Value<String?> origen = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationsTableCompanion.insert(
                id: id,
                titulo: titulo,
                mensaje: mensaje,
                tipo: tipo,
                leida: leida,
                origen: origen,
                fecha: fecha,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTableTable,
      NotificationsTableData,
      $$NotificationsTableTableFilterComposer,
      $$NotificationsTableTableOrderingComposer,
      $$NotificationsTableTableAnnotationComposer,
      $$NotificationsTableTableCreateCompanionBuilder,
      $$NotificationsTableTableUpdateCompanionBuilder,
      (
        NotificationsTableData,
        BaseReferences<
          _$AppDatabase,
          $NotificationsTableTable,
          NotificationsTableData
        >,
      ),
      NotificationsTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableTableCreateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<int> id,
      required String entidad,
      required String entidadId,
      required String accion,
      Value<Map<String, dynamic>?> payload,
      Value<bool> procesado,
      Value<DateTime> createdAt,
    });
typedef $$SyncQueueTableTableUpdateCompanionBuilder =
    SyncQueueTableCompanion Function({
      Value<int> id,
      Value<String> entidad,
      Value<String> entidadId,
      Value<String> accion,
      Value<Map<String, dynamic>?> payload,
      Value<bool> procesado,
      Value<DateTime> createdAt,
    });

class $$SyncQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableFilterComposer({
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

  ColumnFilters<String> get entidad => $composableBuilder(
    column: $table.entidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entidadId => $composableBuilder(
    column: $table.entidadId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accion => $composableBuilder(
    column: $table.accion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    Map<String, dynamic>?,
    Map<String, dynamic>,
    String
  >
  get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get procesado => $composableBuilder(
    column: $table.procesado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableOrderingComposer({
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

  ColumnOrderings<String> get entidad => $composableBuilder(
    column: $table.entidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entidadId => $composableBuilder(
    column: $table.entidadId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accion => $composableBuilder(
    column: $table.accion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get procesado => $composableBuilder(
    column: $table.procesado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entidad =>
      $composableBuilder(column: $table.entidad, builder: (column) => column);

  GeneratedColumn<String> get entidadId =>
      $composableBuilder(column: $table.entidadId, builder: (column) => column);

  GeneratedColumn<String> get accion =>
      $composableBuilder(column: $table.accion, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, dynamic>?, String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<bool> get procesado =>
      $composableBuilder(column: $table.procesado, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTableTable,
          SyncQueueTableData,
          $$SyncQueueTableTableFilterComposer,
          $$SyncQueueTableTableOrderingComposer,
          $$SyncQueueTableTableAnnotationComposer,
          $$SyncQueueTableTableCreateCompanionBuilder,
          $$SyncQueueTableTableUpdateCompanionBuilder,
          (
            SyncQueueTableData,
            BaseReferences<
              _$AppDatabase,
              $SyncQueueTableTable,
              SyncQueueTableData
            >,
          ),
          SyncQueueTableData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableTableManager(
    _$AppDatabase db,
    $SyncQueueTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entidad = const Value.absent(),
                Value<String> entidadId = const Value.absent(),
                Value<String> accion = const Value.absent(),
                Value<Map<String, dynamic>?> payload = const Value.absent(),
                Value<bool> procesado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncQueueTableCompanion(
                id: id,
                entidad: entidad,
                entidadId: entidadId,
                accion: accion,
                payload: payload,
                procesado: procesado,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entidad,
                required String entidadId,
                required String accion,
                Value<Map<String, dynamic>?> payload = const Value.absent(),
                Value<bool> procesado = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncQueueTableCompanion.insert(
                id: id,
                entidad: entidad,
                entidadId: entidadId,
                accion: accion,
                payload: payload,
                procesado: procesado,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTableTable,
      SyncQueueTableData,
      $$SyncQueueTableTableFilterComposer,
      $$SyncQueueTableTableOrderingComposer,
      $$SyncQueueTableTableAnnotationComposer,
      $$SyncQueueTableTableCreateCompanionBuilder,
      $$SyncQueueTableTableUpdateCompanionBuilder,
      (
        SyncQueueTableData,
        BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>,
      ),
      SyncQueueTableData,
      PrefetchHooks Function()
    >;
typedef $$TareasTableTableCreateCompanionBuilder =
    TareasTableCompanion Function({
      required String id,
      Value<String?> remoteId,
      Value<String?> groupId,
      required String reporteId,
      required String titulo,
      Value<String> descripcion,
      Value<String?> creadoPor,
      required String asignadoA,
      required String estado,
      Value<int> rowid,
    });
typedef $$TareasTableTableUpdateCompanionBuilder =
    TareasTableCompanion Function({
      Value<String> id,
      Value<String?> remoteId,
      Value<String?> groupId,
      Value<String> reporteId,
      Value<String> titulo,
      Value<String> descripcion,
      Value<String?> creadoPor,
      Value<String> asignadoA,
      Value<String> estado,
      Value<int> rowid,
    });

class $$TareasTableTableFilterComposer
    extends Composer<_$AppDatabase, $TareasTableTable> {
  $$TareasTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reporteId => $composableBuilder(
    column: $table.reporteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creadoPor => $composableBuilder(
    column: $table.creadoPor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get asignadoA => $composableBuilder(
    column: $table.asignadoA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TareasTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TareasTableTable> {
  $$TareasTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reporteId => $composableBuilder(
    column: $table.reporteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creadoPor => $composableBuilder(
    column: $table.creadoPor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get asignadoA => $composableBuilder(
    column: $table.asignadoA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TareasTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TareasTableTable> {
  $$TareasTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get reporteId =>
      $composableBuilder(column: $table.reporteId, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creadoPor =>
      $composableBuilder(column: $table.creadoPor, builder: (column) => column);

  GeneratedColumn<String> get asignadoA =>
      $composableBuilder(column: $table.asignadoA, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);
}

class $$TareasTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TareasTableTable,
          TareasTableData,
          $$TareasTableTableFilterComposer,
          $$TareasTableTableOrderingComposer,
          $$TareasTableTableAnnotationComposer,
          $$TareasTableTableCreateCompanionBuilder,
          $$TareasTableTableUpdateCompanionBuilder,
          (
            TareasTableData,
            BaseReferences<_$AppDatabase, $TareasTableTable, TareasTableData>,
          ),
          TareasTableData,
          PrefetchHooks Function()
        > {
  $$TareasTableTableTableManager(_$AppDatabase db, $TareasTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TareasTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TareasTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TareasTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> groupId = const Value.absent(),
                Value<String> reporteId = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<String?> creadoPor = const Value.absent(),
                Value<String> asignadoA = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TareasTableCompanion(
                id: id,
                remoteId: remoteId,
                groupId: groupId,
                reporteId: reporteId,
                titulo: titulo,
                descripcion: descripcion,
                creadoPor: creadoPor,
                asignadoA: asignadoA,
                estado: estado,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> remoteId = const Value.absent(),
                Value<String?> groupId = const Value.absent(),
                required String reporteId,
                required String titulo,
                Value<String> descripcion = const Value.absent(),
                Value<String?> creadoPor = const Value.absent(),
                required String asignadoA,
                required String estado,
                Value<int> rowid = const Value.absent(),
              }) => TareasTableCompanion.insert(
                id: id,
                remoteId: remoteId,
                groupId: groupId,
                reporteId: reporteId,
                titulo: titulo,
                descripcion: descripcion,
                creadoPor: creadoPor,
                asignadoA: asignadoA,
                estado: estado,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TareasTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TareasTableTable,
      TareasTableData,
      $$TareasTableTableFilterComposer,
      $$TareasTableTableOrderingComposer,
      $$TareasTableTableAnnotationComposer,
      $$TareasTableTableCreateCompanionBuilder,
      $$TareasTableTableUpdateCompanionBuilder,
      (
        TareasTableData,
        BaseReferences<_$AppDatabase, $TareasTableTable, TareasTableData>,
      ),
      TareasTableData,
      PrefetchHooks Function()
    >;
typedef $$TareaComentariosTableTableCreateCompanionBuilder =
    TareaComentariosTableCompanion Function({
      required String id,
      required String tareaId,
      required String autorId,
      required String mensaje,
      required DateTime creadoEn,
      Value<int> rowid,
    });
typedef $$TareaComentariosTableTableUpdateCompanionBuilder =
    TareaComentariosTableCompanion Function({
      Value<String> id,
      Value<String> tareaId,
      Value<String> autorId,
      Value<String> mensaje,
      Value<DateTime> creadoEn,
      Value<int> rowid,
    });

class $$TareaComentariosTableTableFilterComposer
    extends Composer<_$AppDatabase, $TareaComentariosTableTable> {
  $$TareaComentariosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tareaId => $composableBuilder(
    column: $table.tareaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get autorId => $composableBuilder(
    column: $table.autorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mensaje => $composableBuilder(
    column: $table.mensaje,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TareaComentariosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TareaComentariosTableTable> {
  $$TareaComentariosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tareaId => $composableBuilder(
    column: $table.tareaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get autorId => $composableBuilder(
    column: $table.autorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mensaje => $composableBuilder(
    column: $table.mensaje,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TareaComentariosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TareaComentariosTableTable> {
  $$TareaComentariosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tareaId =>
      $composableBuilder(column: $table.tareaId, builder: (column) => column);

  GeneratedColumn<String> get autorId =>
      $composableBuilder(column: $table.autorId, builder: (column) => column);

  GeneratedColumn<String> get mensaje =>
      $composableBuilder(column: $table.mensaje, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);
}

class $$TareaComentariosTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TareaComentariosTableTable,
          TareaComentariosTableData,
          $$TareaComentariosTableTableFilterComposer,
          $$TareaComentariosTableTableOrderingComposer,
          $$TareaComentariosTableTableAnnotationComposer,
          $$TareaComentariosTableTableCreateCompanionBuilder,
          $$TareaComentariosTableTableUpdateCompanionBuilder,
          (
            TareaComentariosTableData,
            BaseReferences<
              _$AppDatabase,
              $TareaComentariosTableTable,
              TareaComentariosTableData
            >,
          ),
          TareaComentariosTableData,
          PrefetchHooks Function()
        > {
  $$TareaComentariosTableTableTableManager(
    _$AppDatabase db,
    $TareaComentariosTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TareaComentariosTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TareaComentariosTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TareaComentariosTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tareaId = const Value.absent(),
                Value<String> autorId = const Value.absent(),
                Value<String> mensaje = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TareaComentariosTableCompanion(
                id: id,
                tareaId: tareaId,
                autorId: autorId,
                mensaje: mensaje,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tareaId,
                required String autorId,
                required String mensaje,
                required DateTime creadoEn,
                Value<int> rowid = const Value.absent(),
              }) => TareaComentariosTableCompanion.insert(
                id: id,
                tareaId: tareaId,
                autorId: autorId,
                mensaje: mensaje,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TareaComentariosTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TareaComentariosTableTable,
      TareaComentariosTableData,
      $$TareaComentariosTableTableFilterComposer,
      $$TareaComentariosTableTableOrderingComposer,
      $$TareaComentariosTableTableAnnotationComposer,
      $$TareaComentariosTableTableCreateCompanionBuilder,
      $$TareaComentariosTableTableUpdateCompanionBuilder,
      (
        TareaComentariosTableData,
        BaseReferences<
          _$AppDatabase,
          $TareaComentariosTableTable,
          TareaComentariosTableData
        >,
      ),
      TareaComentariosTableData,
      PrefetchHooks Function()
    >;
typedef $$TareaAdjuntosTableTableCreateCompanionBuilder =
    TareaAdjuntosTableCompanion Function({
      required String id,
      required String tareaId,
      required String tipo,
      required String nombre,
      required String localPath,
      Value<String?> mimeType,
      Value<String?> remoteUrl,
      required DateTime creadoEn,
      Value<int> rowid,
    });
typedef $$TareaAdjuntosTableTableUpdateCompanionBuilder =
    TareaAdjuntosTableCompanion Function({
      Value<String> id,
      Value<String> tareaId,
      Value<String> tipo,
      Value<String> nombre,
      Value<String> localPath,
      Value<String?> mimeType,
      Value<String?> remoteUrl,
      Value<DateTime> creadoEn,
      Value<int> rowid,
    });

class $$TareaAdjuntosTableTableFilterComposer
    extends Composer<_$AppDatabase, $TareaAdjuntosTableTable> {
  $$TareaAdjuntosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tareaId => $composableBuilder(
    column: $table.tareaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TareaAdjuntosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TareaAdjuntosTableTable> {
  $$TareaAdjuntosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tareaId => $composableBuilder(
    column: $table.tareaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TareaAdjuntosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TareaAdjuntosTableTable> {
  $$TareaAdjuntosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tareaId =>
      $composableBuilder(column: $table.tareaId, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);
}

class $$TareaAdjuntosTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TareaAdjuntosTableTable,
          TareaAdjuntosTableData,
          $$TareaAdjuntosTableTableFilterComposer,
          $$TareaAdjuntosTableTableOrderingComposer,
          $$TareaAdjuntosTableTableAnnotationComposer,
          $$TareaAdjuntosTableTableCreateCompanionBuilder,
          $$TareaAdjuntosTableTableUpdateCompanionBuilder,
          (
            TareaAdjuntosTableData,
            BaseReferences<
              _$AppDatabase,
              $TareaAdjuntosTableTable,
              TareaAdjuntosTableData
            >,
          ),
          TareaAdjuntosTableData,
          PrefetchHooks Function()
        > {
  $$TareaAdjuntosTableTableTableManager(
    _$AppDatabase db,
    $TareaAdjuntosTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TareaAdjuntosTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TareaAdjuntosTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TareaAdjuntosTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tareaId = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<String?> remoteUrl = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TareaAdjuntosTableCompanion(
                id: id,
                tareaId: tareaId,
                tipo: tipo,
                nombre: nombre,
                localPath: localPath,
                mimeType: mimeType,
                remoteUrl: remoteUrl,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tareaId,
                required String tipo,
                required String nombre,
                required String localPath,
                Value<String?> mimeType = const Value.absent(),
                Value<String?> remoteUrl = const Value.absent(),
                required DateTime creadoEn,
                Value<int> rowid = const Value.absent(),
              }) => TareaAdjuntosTableCompanion.insert(
                id: id,
                tareaId: tareaId,
                tipo: tipo,
                nombre: nombre,
                localPath: localPath,
                mimeType: mimeType,
                remoteUrl: remoteUrl,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TareaAdjuntosTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TareaAdjuntosTableTable,
      TareaAdjuntosTableData,
      $$TareaAdjuntosTableTableFilterComposer,
      $$TareaAdjuntosTableTableOrderingComposer,
      $$TareaAdjuntosTableTableAnnotationComposer,
      $$TareaAdjuntosTableTableCreateCompanionBuilder,
      $$TareaAdjuntosTableTableUpdateCompanionBuilder,
      (
        TareaAdjuntosTableData,
        BaseReferences<
          _$AppDatabase,
          $TareaAdjuntosTableTable,
          TareaAdjuntosTableData
        >,
      ),
      TareaAdjuntosTableData,
      PrefetchHooks Function()
    >;
typedef $$ReportesTableTableCreateCompanionBuilder =
    ReportesTableCompanion Function({
      required String id,
      required String titulo,
      required String descripcion,
      required String categoria,
      required String area,
      Value<String?> activo,
      Value<String?> ubicacion,
      required String creadoPor,
      required DateTime creadoEn,
      required String estado,
      Value<String?> glpiTicketId,
      Value<String?> metadata,
      Value<int> rowid,
    });
typedef $$ReportesTableTableUpdateCompanionBuilder =
    ReportesTableCompanion Function({
      Value<String> id,
      Value<String> titulo,
      Value<String> descripcion,
      Value<String> categoria,
      Value<String> area,
      Value<String?> activo,
      Value<String?> ubicacion,
      Value<String> creadoPor,
      Value<DateTime> creadoEn,
      Value<String> estado,
      Value<String?> glpiTicketId,
      Value<String?> metadata,
      Value<int> rowid,
    });

class $$ReportesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReportesTableTable> {
  $$ReportesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ubicacion => $composableBuilder(
    column: $table.ubicacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creadoPor => $composableBuilder(
    column: $table.creadoPor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get glpiTicketId => $composableBuilder(
    column: $table.glpiTicketId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReportesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportesTableTable> {
  $$ReportesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ubicacion => $composableBuilder(
    column: $table.ubicacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creadoPor => $composableBuilder(
    column: $table.creadoPor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get glpiTicketId => $composableBuilder(
    column: $table.glpiTicketId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReportesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportesTableTable> {
  $$ReportesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<String> get ubicacion =>
      $composableBuilder(column: $table.ubicacion, builder: (column) => column);

  GeneratedColumn<String> get creadoPor =>
      $composableBuilder(column: $table.creadoPor, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get glpiTicketId => $composableBuilder(
    column: $table.glpiTicketId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);
}

class $$ReportesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReportesTableTable,
          ReportesTableData,
          $$ReportesTableTableFilterComposer,
          $$ReportesTableTableOrderingComposer,
          $$ReportesTableTableAnnotationComposer,
          $$ReportesTableTableCreateCompanionBuilder,
          $$ReportesTableTableUpdateCompanionBuilder,
          (
            ReportesTableData,
            BaseReferences<
              _$AppDatabase,
              $ReportesTableTable,
              ReportesTableData
            >,
          ),
          ReportesTableData,
          PrefetchHooks Function()
        > {
  $$ReportesTableTableTableManager(_$AppDatabase db, $ReportesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<String> categoria = const Value.absent(),
                Value<String> area = const Value.absent(),
                Value<String?> activo = const Value.absent(),
                Value<String?> ubicacion = const Value.absent(),
                Value<String> creadoPor = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<String?> glpiTicketId = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReportesTableCompanion(
                id: id,
                titulo: titulo,
                descripcion: descripcion,
                categoria: categoria,
                area: area,
                activo: activo,
                ubicacion: ubicacion,
                creadoPor: creadoPor,
                creadoEn: creadoEn,
                estado: estado,
                glpiTicketId: glpiTicketId,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String titulo,
                required String descripcion,
                required String categoria,
                required String area,
                Value<String?> activo = const Value.absent(),
                Value<String?> ubicacion = const Value.absent(),
                required String creadoPor,
                required DateTime creadoEn,
                required String estado,
                Value<String?> glpiTicketId = const Value.absent(),
                Value<String?> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReportesTableCompanion.insert(
                id: id,
                titulo: titulo,
                descripcion: descripcion,
                categoria: categoria,
                area: area,
                activo: activo,
                ubicacion: ubicacion,
                creadoPor: creadoPor,
                creadoEn: creadoEn,
                estado: estado,
                glpiTicketId: glpiTicketId,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReportesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReportesTableTable,
      ReportesTableData,
      $$ReportesTableTableFilterComposer,
      $$ReportesTableTableOrderingComposer,
      $$ReportesTableTableAnnotationComposer,
      $$ReportesTableTableCreateCompanionBuilder,
      $$ReportesTableTableUpdateCompanionBuilder,
      (
        ReportesTableData,
        BaseReferences<_$AppDatabase, $ReportesTableTable, ReportesTableData>,
      ),
      ReportesTableData,
      PrefetchHooks Function()
    >;
typedef $$ReporteComentariosTableTableCreateCompanionBuilder =
    ReporteComentariosTableCompanion Function({
      required String id,
      required String reporteId,
      required String autorId,
      required String mensaje,
      required DateTime creadoEn,
      Value<int> rowid,
    });
typedef $$ReporteComentariosTableTableUpdateCompanionBuilder =
    ReporteComentariosTableCompanion Function({
      Value<String> id,
      Value<String> reporteId,
      Value<String> autorId,
      Value<String> mensaje,
      Value<DateTime> creadoEn,
      Value<int> rowid,
    });

class $$ReporteComentariosTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReporteComentariosTableTable> {
  $$ReporteComentariosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reporteId => $composableBuilder(
    column: $table.reporteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get autorId => $composableBuilder(
    column: $table.autorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mensaje => $composableBuilder(
    column: $table.mensaje,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReporteComentariosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReporteComentariosTableTable> {
  $$ReporteComentariosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reporteId => $composableBuilder(
    column: $table.reporteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get autorId => $composableBuilder(
    column: $table.autorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mensaje => $composableBuilder(
    column: $table.mensaje,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReporteComentariosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReporteComentariosTableTable> {
  $$ReporteComentariosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reporteId =>
      $composableBuilder(column: $table.reporteId, builder: (column) => column);

  GeneratedColumn<String> get autorId =>
      $composableBuilder(column: $table.autorId, builder: (column) => column);

  GeneratedColumn<String> get mensaje =>
      $composableBuilder(column: $table.mensaje, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);
}

class $$ReporteComentariosTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReporteComentariosTableTable,
          ReporteComentariosTableData,
          $$ReporteComentariosTableTableFilterComposer,
          $$ReporteComentariosTableTableOrderingComposer,
          $$ReporteComentariosTableTableAnnotationComposer,
          $$ReporteComentariosTableTableCreateCompanionBuilder,
          $$ReporteComentariosTableTableUpdateCompanionBuilder,
          (
            ReporteComentariosTableData,
            BaseReferences<
              _$AppDatabase,
              $ReporteComentariosTableTable,
              ReporteComentariosTableData
            >,
          ),
          ReporteComentariosTableData,
          PrefetchHooks Function()
        > {
  $$ReporteComentariosTableTableTableManager(
    _$AppDatabase db,
    $ReporteComentariosTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReporteComentariosTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ReporteComentariosTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReporteComentariosTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> reporteId = const Value.absent(),
                Value<String> autorId = const Value.absent(),
                Value<String> mensaje = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReporteComentariosTableCompanion(
                id: id,
                reporteId: reporteId,
                autorId: autorId,
                mensaje: mensaje,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String reporteId,
                required String autorId,
                required String mensaje,
                required DateTime creadoEn,
                Value<int> rowid = const Value.absent(),
              }) => ReporteComentariosTableCompanion.insert(
                id: id,
                reporteId: reporteId,
                autorId: autorId,
                mensaje: mensaje,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReporteComentariosTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReporteComentariosTableTable,
      ReporteComentariosTableData,
      $$ReporteComentariosTableTableFilterComposer,
      $$ReporteComentariosTableTableOrderingComposer,
      $$ReporteComentariosTableTableAnnotationComposer,
      $$ReporteComentariosTableTableCreateCompanionBuilder,
      $$ReporteComentariosTableTableUpdateCompanionBuilder,
      (
        ReporteComentariosTableData,
        BaseReferences<
          _$AppDatabase,
          $ReporteComentariosTableTable,
          ReporteComentariosTableData
        >,
      ),
      ReporteComentariosTableData,
      PrefetchHooks Function()
    >;
typedef $$ReporteEvidenciasTableTableCreateCompanionBuilder =
    ReporteEvidenciasTableCompanion Function({
      required String id,
      required String reporteId,
      required String tipo,
      required String nombre,
      required String localPath,
      Value<String?> remoteUrl,
      required DateTime creadoEn,
      Value<int> rowid,
    });
typedef $$ReporteEvidenciasTableTableUpdateCompanionBuilder =
    ReporteEvidenciasTableCompanion Function({
      Value<String> id,
      Value<String> reporteId,
      Value<String> tipo,
      Value<String> nombre,
      Value<String> localPath,
      Value<String?> remoteUrl,
      Value<DateTime> creadoEn,
      Value<int> rowid,
    });

class $$ReporteEvidenciasTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReporteEvidenciasTableTable> {
  $$ReporteEvidenciasTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reporteId => $composableBuilder(
    column: $table.reporteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReporteEvidenciasTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReporteEvidenciasTableTable> {
  $$ReporteEvidenciasTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reporteId => $composableBuilder(
    column: $table.reporteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteUrl => $composableBuilder(
    column: $table.remoteUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReporteEvidenciasTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReporteEvidenciasTableTable> {
  $$ReporteEvidenciasTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reporteId =>
      $composableBuilder(column: $table.reporteId, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get remoteUrl =>
      $composableBuilder(column: $table.remoteUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);
}

class $$ReporteEvidenciasTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReporteEvidenciasTableTable,
          ReporteEvidenciasTableData,
          $$ReporteEvidenciasTableTableFilterComposer,
          $$ReporteEvidenciasTableTableOrderingComposer,
          $$ReporteEvidenciasTableTableAnnotationComposer,
          $$ReporteEvidenciasTableTableCreateCompanionBuilder,
          $$ReporteEvidenciasTableTableUpdateCompanionBuilder,
          (
            ReporteEvidenciasTableData,
            BaseReferences<
              _$AppDatabase,
              $ReporteEvidenciasTableTable,
              ReporteEvidenciasTableData
            >,
          ),
          ReporteEvidenciasTableData,
          PrefetchHooks Function()
        > {
  $$ReporteEvidenciasTableTableTableManager(
    _$AppDatabase db,
    $ReporteEvidenciasTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReporteEvidenciasTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ReporteEvidenciasTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReporteEvidenciasTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> reporteId = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String?> remoteUrl = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReporteEvidenciasTableCompanion(
                id: id,
                reporteId: reporteId,
                tipo: tipo,
                nombre: nombre,
                localPath: localPath,
                remoteUrl: remoteUrl,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String reporteId,
                required String tipo,
                required String nombre,
                required String localPath,
                Value<String?> remoteUrl = const Value.absent(),
                required DateTime creadoEn,
                Value<int> rowid = const Value.absent(),
              }) => ReporteEvidenciasTableCompanion.insert(
                id: id,
                reporteId: reporteId,
                tipo: tipo,
                nombre: nombre,
                localPath: localPath,
                remoteUrl: remoteUrl,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReporteEvidenciasTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReporteEvidenciasTableTable,
      ReporteEvidenciasTableData,
      $$ReporteEvidenciasTableTableFilterComposer,
      $$ReporteEvidenciasTableTableOrderingComposer,
      $$ReporteEvidenciasTableTableAnnotationComposer,
      $$ReporteEvidenciasTableTableCreateCompanionBuilder,
      $$ReporteEvidenciasTableTableUpdateCompanionBuilder,
      (
        ReporteEvidenciasTableData,
        BaseReferences<
          _$AppDatabase,
          $ReporteEvidenciasTableTable,
          ReporteEvidenciasTableData
        >,
      ),
      ReporteEvidenciasTableData,
      PrefetchHooks Function()
    >;
typedef $$ReporteParticipantesTableTableCreateCompanionBuilder =
    ReporteParticipantesTableCompanion Function({
      required String reporteId,
      required String userId,
      required String rol,
      Value<int> rowid,
    });
typedef $$ReporteParticipantesTableTableUpdateCompanionBuilder =
    ReporteParticipantesTableCompanion Function({
      Value<String> reporteId,
      Value<String> userId,
      Value<String> rol,
      Value<int> rowid,
    });

class $$ReporteParticipantesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReporteParticipantesTableTable> {
  $$ReporteParticipantesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get reporteId => $composableBuilder(
    column: $table.reporteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReporteParticipantesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReporteParticipantesTableTable> {
  $$ReporteParticipantesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get reporteId => $composableBuilder(
    column: $table.reporteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReporteParticipantesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReporteParticipantesTableTable> {
  $$ReporteParticipantesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get reporteId =>
      $composableBuilder(column: $table.reporteId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);
}

class $$ReporteParticipantesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReporteParticipantesTableTable,
          ReporteParticipantesTableData,
          $$ReporteParticipantesTableTableFilterComposer,
          $$ReporteParticipantesTableTableOrderingComposer,
          $$ReporteParticipantesTableTableAnnotationComposer,
          $$ReporteParticipantesTableTableCreateCompanionBuilder,
          $$ReporteParticipantesTableTableUpdateCompanionBuilder,
          (
            ReporteParticipantesTableData,
            BaseReferences<
              _$AppDatabase,
              $ReporteParticipantesTableTable,
              ReporteParticipantesTableData
            >,
          ),
          ReporteParticipantesTableData,
          PrefetchHooks Function()
        > {
  $$ReporteParticipantesTableTableTableManager(
    _$AppDatabase db,
    $ReporteParticipantesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReporteParticipantesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ReporteParticipantesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReporteParticipantesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> reporteId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> rol = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReporteParticipantesTableCompanion(
                reporteId: reporteId,
                userId: userId,
                rol: rol,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String reporteId,
                required String userId,
                required String rol,
                Value<int> rowid = const Value.absent(),
              }) => ReporteParticipantesTableCompanion.insert(
                reporteId: reporteId,
                userId: userId,
                rol: rol,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReporteParticipantesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReporteParticipantesTableTable,
      ReporteParticipantesTableData,
      $$ReporteParticipantesTableTableFilterComposer,
      $$ReporteParticipantesTableTableOrderingComposer,
      $$ReporteParticipantesTableTableAnnotationComposer,
      $$ReporteParticipantesTableTableCreateCompanionBuilder,
      $$ReporteParticipantesTableTableUpdateCompanionBuilder,
      (
        ReporteParticipantesTableData,
        BaseReferences<
          _$AppDatabase,
          $ReporteParticipantesTableTable,
          ReporteParticipantesTableData
        >,
      ),
      ReporteParticipantesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AsistenciaTableTableTableManager get asistenciaTable =>
      $$AsistenciaTableTableTableManager(_db, _db.asistenciaTable);
  $$NotificationsTableTableTableManager get notificationsTable =>
      $$NotificationsTableTableTableManager(_db, _db.notificationsTable);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
  $$TareasTableTableTableManager get tareasTable =>
      $$TareasTableTableTableManager(_db, _db.tareasTable);
  $$TareaComentariosTableTableTableManager get tareaComentariosTable =>
      $$TareaComentariosTableTableTableManager(_db, _db.tareaComentariosTable);
  $$TareaAdjuntosTableTableTableManager get tareaAdjuntosTable =>
      $$TareaAdjuntosTableTableTableManager(_db, _db.tareaAdjuntosTable);
  $$ReportesTableTableTableManager get reportesTable =>
      $$ReportesTableTableTableManager(_db, _db.reportesTable);
  $$ReporteComentariosTableTableTableManager get reporteComentariosTable =>
      $$ReporteComentariosTableTableTableManager(
        _db,
        _db.reporteComentariosTable,
      );
  $$ReporteEvidenciasTableTableTableManager get reporteEvidenciasTable =>
      $$ReporteEvidenciasTableTableTableManager(
        _db,
        _db.reporteEvidenciasTable,
      );
  $$ReporteParticipantesTableTableTableManager get reporteParticipantesTable =>
      $$ReporteParticipantesTableTableTableManager(
        _db,
        _db.reporteParticipantesTable,
      );
}
