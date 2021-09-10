import 'package:json_patch/json_patch.dart';
import 'package:collection/collection.dart';
import 'package:eventuous/eventuous.dart';

import 'json_object.dart';
import 'models/conflict_model.dart';

class JsonUtils {
  static dynamic toJson<TValue extends JsonObject>(
    TValue value, {
    List<String> retain = const [],
    List<String> remove = const [],
  }) {
    assert(
      !(retain.isNotEmpty == true && remove.isNotEmpty == true),
      'Only use retain or remove',
    );
    final json = value.toJson();
    if (retain.isNotEmpty == true) {
      json.removeWhere(
        (key, _) => !retain.contains(key),
      );
    } else if (remove.isNotEmpty == true) {
      json.removeWhere(
        (key, _) => remove.contains(key),
      );
    }
    return json;
  }

  /// Calculate key-stable patches enforcing
  /// a 'append-only' rule for keys and
  /// replace-only for arrays (remove are
  /// only allowed for arrays).
  ///
  /// This is important to allow for partial
  /// updates to an existing object that is
  /// semantically consistent with the HTTP
  /// PATCH method by only including keys
  /// in [expectedVersion] should be updated, keeping
  /// the rest unchanged.
  ///
  static JsonMapList diff(JsonObject o1, JsonObject o2) {
    final current = o1.toJson();
    final next = o2.toJson();
    final patches = JsonPatch.diff(current, next)
      ..removeWhere(
        (diff) {
          var isRemove = diff['op'] == 'remove';
          if (isRemove) {
            final elements = (diff['path'] as String).split('/');
            if (elements.length > 1) {
              // Get path to list by removing index
              final path = elements.take(elements.length - 1).join('/');
              if (current is Map && path.isNotEmpty) {
                final value = current.elementAt(path);
                isRemove = value is! List;
              }
            }
          }
          return isRemove;
        },
      );
    return patches;
  }

  static ConflictModel? check(JsonMapList mine, JsonMapList yours) {
    // 1. Get local (mine) and remote (yours) patches
    final yourPaths = yours.map((op) => op['path']);
    final concurrent = mine.where((op) => yourPaths.contains(op['path']));

    // 2. Check if any of mine and yours patches collide
    final eq = const MapEquality().equals;
    final conflicts = concurrent.where(
      (op1) => yours
          .where((op2) => op2['path'] == op1['path'] && !eq(op1, op2))
          .isNotEmpty,
    );

    return conflicts.isNotEmpty
        ? ConflictModel(
            type: ConflictType.merge,
            mine: mine,
            yours: yours,
            paths: conflicts.map((op) => op['path'] as String).toList(),
          )
        : null;
  }

  /// Patch [oldJson] with [newJson].
  ///
  /// This operation is semantically consistent with the HTTP
  /// PATCH method by only applying keys in [newJson], keeping
  /// the remaining keys in [oldJson] unchanged.
  static JsonMap patch(
    JsonObject oldJson,
    JsonObject newJson, {
    bool strict = false,
  }) {
    final patches = diff(oldJson, newJson);
    return apply(oldJson, patches, strict: strict);
  }

  static JsonMap apply(
    JsonObject oldJson,
    JsonMapList patches, {
    bool strict = false,
  }) {
    return JsonPatch.apply(oldJson, patches, strict: strict);
  }
}
