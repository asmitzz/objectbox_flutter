// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_sync_flutter_libs/objectbox_sync_flutter_libs.dart';

import 'src/entity_model/weather_entity_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 5737906417185710015),
      name: 'WeatherEntityModel',
      lastPropertyId: const IdUid(7, 3332305379825851370),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8561358884637087049),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1753803943260072230),
            name: 'temp',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5273268916759173615),
            name: 'feelsLike',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6098948393006414093),
            name: 'low',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2115468157038676374),
            name: 'high',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2015623018292280665),
            name: 'description',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 3332305379825851370),
            name: 'cityName',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 5737906417185710015),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    WeatherEntityModel: EntityDefinition<WeatherEntityModel>(
        model: _entities[0],
        toOneRelations: (WeatherEntityModel object) => [],
        toManyRelations: (WeatherEntityModel object) => {},
        getId: (WeatherEntityModel object) => object.id,
        setId: (WeatherEntityModel object, int id) {
          object.id = id;
        },
        objectToFB: (WeatherEntityModel object, fb.Builder fbb) {
          final descriptionOffset = fbb.writeString(object.description);
          final cityNameOffset = fbb.writeString(object.cityName);
          fbb.startTable(8);
          fbb.addInt64(0, object.id);
          fbb.addFloat64(1, object.temp);
          fbb.addFloat64(2, object.feelsLike);
          fbb.addFloat64(3, object.low);
          fbb.addFloat64(4, object.high);
          fbb.addOffset(5, descriptionOffset);
          fbb.addOffset(6, cityNameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = WeatherEntityModel(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              feelsLike:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 8, 0),
              low:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 10, 0),
              high:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 12, 0),
              description:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 14, ''),
              cityName:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 16, ''),
              temp:
                  const fb.Float64Reader().vTableGet(buffer, rootOffset, 6, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [WeatherEntityModel] entity fields to define ObjectBox queries.
class WeatherEntityModel_ {
  /// see [WeatherEntityModel.id]
  static final id =
      QueryIntegerProperty<WeatherEntityModel>(_entities[0].properties[0]);

  /// see [WeatherEntityModel.temp]
  static final temp =
      QueryDoubleProperty<WeatherEntityModel>(_entities[0].properties[1]);

  /// see [WeatherEntityModel.feelsLike]
  static final feelsLike =
      QueryDoubleProperty<WeatherEntityModel>(_entities[0].properties[2]);

  /// see [WeatherEntityModel.low]
  static final low =
      QueryDoubleProperty<WeatherEntityModel>(_entities[0].properties[3]);

  /// see [WeatherEntityModel.high]
  static final high =
      QueryDoubleProperty<WeatherEntityModel>(_entities[0].properties[4]);

  /// see [WeatherEntityModel.description]
  static final description =
      QueryStringProperty<WeatherEntityModel>(_entities[0].properties[5]);

  /// see [WeatherEntityModel.cityName]
  static final cityName =
      QueryStringProperty<WeatherEntityModel>(_entities[0].properties[6]);
}
