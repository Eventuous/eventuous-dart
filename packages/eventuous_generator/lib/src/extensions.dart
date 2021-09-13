import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:eventuous/eventuous.dart';
import 'package:eventuous_annotation/eventuous_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'templates/aggregate_event_template.dart';
import 'templates/aggregate_state_template.dart';
import 'templates/aggregate_value_template.dart';

extension ConstantReaderX on ConstantReader {
  String toTypeName(String defaultName) {
    return isNull ? defaultName : typeValue.toTypeName();
  }
}

extension DartTypeX on DartType {
  String toTypeName() {
    return alias?.element.name ?? getDisplayString(withNullability: false);
  }
}

extension ClassElementX on ClassElement {
  AggregateValueTemplate? toAggregateValueTemplate(
      Eventuous eventuous, String aggregate) {
    final annotations = _withAnnotation<AggregateValueType>(
      aggregate,
    );
    if (annotations.isNotEmpty) {
      return AggregateValueTemplate.from(eventuous, this, annotations.first);
    }
  }

  AggregateStateTemplate? toAggregateStateTemplate(
      Eventuous eventuous, String aggregate) {
    final annotations = _withAnnotation<AggregateStateType>(
      aggregate,
    );
    if (annotations.isNotEmpty) {
      return AggregateStateTemplate.from(eventuous, this, annotations.first);
    }
  }

  AggregateEventTemplate? toAggregateEventTemplate(
      Eventuous eventuous, String aggregate) {
    final annotations = _withAnnotation<AggregateEventType>(
      aggregate,
    );
    if (annotations.isNotEmpty) {
      return AggregateEventTemplate.from(eventuous, this, annotations.first);
    }
  }

  Iterable<ElementAnnotation> _withAnnotation<T extends Object>(
      String aggregate) {
    final type = '${typeOf<T>()}';
    return metadata
        .where((annotation) => annotation.computeConstantValue() != null)
        .where((annotation) =>
            annotation.computeConstantValue()!.type?.toTypeName() == type)
        .where(
      (annotation) {
        final value = annotation
            .computeConstantValue()
            ?.getField('aggregate')
            ?.toTypeValue();
        return value != null && value.toTypeName() == aggregate;
      },
    );
  }
}

extension ListElementAnnotationX on List<ElementAnnotation> {
  bool usesJsonSerializable() => any(
      (e) => e.computeConstantValue()?.type.toString() == 'JsonSerializable');
}

extension LibraryElementX on LibraryElement {
  Iterable<ClassElement> whereAggregateValueClasses(String aggregate) {
    final list = units.expand((cu) => cu.classes);
    return list.where(
      (element) => _hasAnnotation<AggregateValueType>(
        element,
        aggregate,
      ),
    );
  }

  Iterable<ClassElement> whereAggregateEventClasses(String aggregate) {
    final list = units.expand((cu) => cu.classes);
    return list.where(
      (element) => _hasAnnotation<AggregateEventType>(
        element,
        aggregate,
      ),
    );
  }

  Iterable<ClassElement> whereAggregateStateClasses(String aggregate) {
    return units.expand((cu) => cu.classes).where(
          (element) => _hasAnnotation<AggregateStateType>(
            element,
            aggregate,
          ),
        );
  }

  Iterable<ClassElement> whereAggregateCommandClasses(String aggregate) {
    return units.expand((cu) => cu.classes).where(
          (element) => _hasAnnotation<AggregateCommandType>(
            element,
            aggregate,
          ),
        );
  }

  bool _hasAnnotation<T extends Object>(
      ClassElement element, String aggregate) {
    final type = '${typeOf<T>()}';
    return element.metadata
        .map((metadata) => metadata.computeConstantValue())
        .where((annotation) => annotation != null)
        .where((annotation) => annotation!.type?.toTypeName() == type)
        .any(
      (annotation) {
        final value = annotation?.getField('aggregate')?.toTypeValue();
        return value != null && value.toTypeName() == aggregate;
      },
    );
  }
}
