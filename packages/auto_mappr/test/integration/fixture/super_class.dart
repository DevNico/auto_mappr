import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:equatable/equatable.dart';

part 'super_class.g.dart';

@AutoMappr([
  MapType<FlattenedClass, SubClass>(),
  MapType<SubClass, FlattenedClass>(),
])
class Mappr extends $Mappr {}

class SuperClass {
  final int first;

  SuperClass({
    required this.first,
  });
}

class SubClass extends SuperClass with EquatableMixin {
  final int second;

  @override
  List<Object?> get props => [first, second];

  SubClass({
    required this.second,
    required super.first,
  });
}

class FlattenedClass with EquatableMixin {
  final int first;
  final int second;

  @override
  List<Object?> get props => [first, second];

  FlattenedClass({
    required this.first,
    required this.second,
  });
}