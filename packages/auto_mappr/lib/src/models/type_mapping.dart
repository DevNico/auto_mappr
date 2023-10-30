import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:auto_mappr/src/builder/methods/method_builder_base.dart';
import 'package:auto_mappr/src/extensions/executable_element_extension.dart';
import 'package:auto_mappr/src/helpers/emitter_helper.dart';
import 'package:auto_mappr/src/models/auto_mappr_config.dart';
import 'package:auto_mappr/src/models/field_mapping.dart';
import 'package:auto_mappr/src/models/type_converter.dart';
import 'package:code_builder/code_builder.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class TypeMapping extends Equatable {
  final InterfaceType source;
  final InterfaceType target;
  final List<FieldMapping> fieldMappings;
  final List<TypeConverter> typeConverters;
  final Expression? whenSourceIsNullExpression;
  final String? constructor;
  final bool? ignoreFieldNull;
  final ExecutableElement? converter;

  bool get isEnumMapping => source.element is EnumElement || target.element is EnumElement;

  @override
  List<Object?> get props {
    return [
      source,
      target,
      fieldMappings,
      typeConverters,
      whenSourceIsNullExpression,
      constructor,
      ignoreFieldNull,
    ];
  }

  const TypeMapping({
    required this.source,
    required this.target,
    required this.ignoreFieldNull,
    this.fieldMappings = const [],
    this.typeConverters = const [],
    this.whenSourceIsNullExpression,
    this.constructor,
    this.converter,
  });

  String mappingMethodName({required AutoMapprConfig config}) {
    final converter = this.converter;
    if(converter != null) {
      return EmitterHelper.current
          .referEmitted(converter.referCallString, converter.library.identifier);
    }

    return MethodBuilderBase.constructConvertMethodName(
        source: source,
        target: target,
        config: config,
      );
  }

  String nullableMappingMethodName({required AutoMapprConfig config}) =>
      MethodBuilderBase.constructNullableConvertMethodName(
        source: source,
        target: target,
        config: config,
      );

  bool hasWhenNullDefault() {
    return whenSourceIsNullExpression != null;
  }

  bool hasFieldMapping(String field) => fieldMappings.any((x) => x.field == field);

  FieldMapping? getFieldMapping(String field) => fieldMappings.firstWhereOrNull((x) => x.field == field);

  FieldMapping? tryGetFieldMapping(String field) => fieldMappings.firstWhereOrNull((x) => x.field == field);

  bool fieldShouldBeIgnored(String field) => hasFieldMapping(field) && (getFieldMapping(field)?.ignore ?? false);

  @override
  String toString() {
    // Without import aliases, used to display errors to user.
    final sourceAsString = source.getDisplayString(withNullability: true);
    final targetAsString = target.getDisplayString(withNullability: true);

    // ignore: avoid-non-ascii-symbols, it is ok
    return '$sourceAsString → $targetAsString';
  }
}
