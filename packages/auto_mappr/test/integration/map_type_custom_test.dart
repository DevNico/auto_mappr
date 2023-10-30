import 'package:test/test.dart';

import 'fixture/map_type_custom.dart' as fixture;

void main() {
  late final fixture.Mappr mappr;

  setUpAll(() {
    mappr = const fixture.Mappr();
  });

  test('convert using custom function', () {
    const dto = fixture.WrapperDto(
      stringValue: fixture.StringValueDto('Test'),
      intValue: null,
    );
    final converted = mappr.convert<fixture.WrapperDto, fixture.Wrapper>(dto);

    expect(
      converted,
      equals(
        const fixture.StringWrapper(
          fixture.StringValue('Test'),
        ),
      ),
    );
  });

  test('convert list of map types with custom function', () {
    const dto = fixture.WrapperWrapperDto([
      fixture.WrapperDto(
        stringValue: fixture.StringValueDto('Test'),
        intValue: null,
      ),
    ]);
    final converted =
        mappr.convert<fixture.WrapperWrapperDto, fixture.WrapperWrapper>(dto);

    expect(
      converted.wrappers,
      orderedEquals([
        const fixture.StringWrapper(
          fixture.StringValue('Test'),
        ),
      ]),
    );
  });
}
