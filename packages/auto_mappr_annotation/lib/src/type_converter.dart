import 'package:auto_mappr_annotation/src/converter_function.dart';

/// Configured type converter from [SOURCE] to [TARGET].
final class TypeConverter<SOURCE, TARGET> {
  /// A function that does type converter.
  final ConverterFunction<SOURCE, TARGET> converter;

  /// Constructs type converter between [SOURCE] and [TARGET].
  const TypeConverter(this.converter);
}
