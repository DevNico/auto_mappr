import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:auto_mappr_annotation/src/converter_function.dart';

/// Configured mapping from [SOURCE] to [TARGET].
sealed class MapType<SOURCE, TARGET> {
  /// Constructs mapping between [SOURCE] and [TARGET] types.
  const factory MapType({
    List<Field> fields,
    List<TypeConverter<Object?, Object?>> converters,
    Object? whenSourceIsNull,
    String constructor,
    bool ignoreFieldNull,
    bool reverse,
  }) = SimpleMapType<SOURCE, TARGET>;

  /// Constructs mapping between [SOURCE] and [TARGET] types with custom mappr function.
  const factory MapType.custom(
    ConverterFunction<SOURCE, TARGET> converter,
  ) = CustomMapType<SOURCE, TARGET>;
}

/// Configured mapping from [SOURCE] to [TARGET].
final class SimpleMapType<SOURCE, TARGET> implements MapType<SOURCE, TARGET> {
  /// Configuration for [TARGET]'s fields.
  final List<Field> fields;

  /// List of type converters.
  final List<TypeConverter<Object?, Object?>> converters;

  /// Provides default value if SOURCE is null.
  ///
  /// Additionally if mapping an enum "unknown" values in SOURCE will be mapped
  /// to this value.
  ///
  /// Accepts `Target Function()` function or `const Target` value.
  // ignore: no-object-declaration, is correct
  final Object? whenSourceIsNull;

  /// Selects named (factory) constructor by name.
  ///
  /// If no constructor with this name is found,
  /// it will fallback to the most fitted constructor.
  ///
  /// To select the default constructor use the `null` value.
  final String? constructor;

  /// Ignores if [SOURCE]'s field is nullable and [TARGET]'s field non-nullable.
  final bool? ignoreFieldNull;

  /// Includes reverse mapping.
  ///
  /// Warning: reverse warning might be suitable only for specific objects.
  /// Reverse mapping might not work properly when additional configuration
  /// such as [whenSourceIsNull] or [constructor] is used.
  final bool reverse;

  /// Constructs mapping between [SOURCE] and [TARGET] types.
  const SimpleMapType({
    this.fields = const [],
    this.converters = const [],
    this.whenSourceIsNull,
    this.constructor,
    this.ignoreFieldNull,
    this.reverse = false,
  });
}


/// Configured mapping from [SOURCE] to [TARGET] with custom function.
final class CustomMapType<SOURCE, TARGET> implements MapType<SOURCE, TARGET> {
  /// Converter function to map from [SOURCE] to [TARGET].
  final ConverterFunction<SOURCE, TARGET> converter;

  /// Constructs mapping between [SOURCE] and [TARGET] types.
  const CustomMapType(this.converter);
}
