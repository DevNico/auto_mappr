import 'package:auto_mapper_example/nullable.dart';

void main() {
  final dto = UserDto(id: 1, name: null);

  ExampleMapper mapper = ExampleMapper();

  final user = mapper.convert<UserDto, User>(dto);

  print(user.name?.name ?? 'NULL');
  print(user.tag.name);
}
