import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('MVP', () {
    final exerciseFooFinder = find.byValueKey('exercise 1');
    final exercisesTabFinder = find.byValueKey('exercises tab');
    final workoutTabFinder = find.byValueKey('workout tab');
    final exerciseListFinder = find.byValueKey('exercise list');
    final addExerciseButtonFinder = find.byValueKey('add new exercise button');
    final exerciseNameFinder = find.byValueKey('exercise name');
    final exerciseSubmitFinder = find.byValueKey('submit new exercise');
    final workoutGeneratorButtonFinder = find.byValueKey('generate workout button');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Add new exercise to database', () async {
      // avoid false positives by ensuring the database is empty first
      try {
        await driver.getText(exerciseListFinder);
        fail('list entry found when none should exist');
      } catch(e) {
        expect(e, new TypeMatcher<DriverError>());
      }

      await driver.tap(exercisesTabFinder);
      await driver.tap(addExerciseButtonFinder);
      await driver.tap(exerciseNameFinder);
      await driver.enterText('foo');
      await driver.tap(exerciseSubmitFinder);

      expect(await driver.getText(exerciseFooFinder), 'foo');

      await driver.tap(workoutTabFinder);
      await driver.tap(workoutGeneratorButtonFinder);

      // TODO: develop more accurate tests for workout list
      expect(await driver.getText(exerciseFooFinder), 'foo');
    });
  });
}
