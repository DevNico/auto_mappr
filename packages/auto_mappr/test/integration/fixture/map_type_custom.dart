import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

import 'map_type_custom.auto_mappr.dart';

@AutoMappr(
  [
    MapType<StringValueDto, StringValue>(),
    MapType<IntValueDto, IntValue>(),
    MapType<WrapperDto, Wrapper>.custom(mapWrapper),
    MapType<WrapperWrapperDto, WrapperWrapper>(),
  ],
)
class Mappr extends $Mappr {
  const Mappr();
}

Wrapper mapWrapper(WrapperDto dto) {
  const mappr = Mappr();

  if (dto.stringValue != null) {
    return StringWrapper(mappr.convert(dto.stringValue));
  }

  if (dto.intValue != null) {
    return IntWrapper(mappr.convert(dto.intValue));
  }

  throw Exception('Invalid wrapper dto');
}

class WrapperWrapperDto {
  final List<WrapperDto> wrappers;

  const WrapperWrapperDto(this.wrappers);
}

class WrapperWrapper {
  final List<Wrapper> wrappers;

  const WrapperWrapper(this.wrappers);
}

class WrapperDto {
  final StringValueDto? stringValue;
  final IntValueDto? intValue;

  const WrapperDto({required this.stringValue, required this.intValue});
}

sealed class Wrapper {}

class StringWrapper extends Equatable implements Wrapper {
  final StringValue value;

  @override
  List<Object?> get props => [value];

  const StringWrapper(this.value);
}

class IntWrapper extends Equatable implements Wrapper {
  final IntValue value;

  @override
  List<Object?> get props => [value];

  const IntWrapper(this.value);
}

abstract class Value<T> extends Equatable {
  final T value;

  @override
  List<Object?> get props => [value];

  const Value(this.value);
}

class StringValueDto extends Value<String> {
  const StringValueDto(super.value);
}

class StringValue extends Value<String> {
  const StringValue(super.value);
}

class IntValueDto extends Value<int> {
  const IntValueDto(super.value);
}

class IntValue extends Value<int> {
  const IntValue(super.value);
}
