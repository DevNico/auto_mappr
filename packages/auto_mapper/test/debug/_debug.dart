import 'package:auto_mapper_annotation/auto_mapper.dart';

class User {
  final int id;
  final String name;
  final String? tag;

  int age = 0;

  User({
    required this.id,
    required this.name,
    required this.tag,
  });
}

class UserDto {
  final int id;
  final String name;
  final int age;

  UserDto({
    required this.id,
    required this.name,
    required this.age,
  });
}

@AutoMapper(mappers: [
  AutoMap<UserDto, User>(mappings: [
    MapMember(member: 'name', custom: ExampleMapper.mapUserDtoName),
  ]),
  AutoMap<User, UserDto>(),
  // AutoMap<UserDto, User>(),
  // AutoMap<UserDto, User>(),
  // AutoMap<NameDto, User>(),
])
abstract class ExampleMapper {
  static String mapUserDtoName(UserDto? dto) => dto!.name.toUpperCase();
}
