# Automated checks

Flutter CI runs on every push and pull request and can be started manually from Actions. Its stable check name is **Flutter checks**. It installs Flutter stable from the official Flutter repository, resolves dependencies using the committed lockfile, runs `flutter analyze` and the test suite with coverage, then compiles a release web build.

Run locally before pushing:

```sh
flutter pub get --enforce-lockfile
flutter analyze
flutter test --coverage
flutter build web --release
```

`test/auth_controller_test.dart` checks startup without a session, successful and failed login, and logout. It uses an in-memory repository so it needs neither the backend nor platform secure storage. `test/widget_test.dart` checks enabled, disabled and loading button behavior, including prevention of duplicate submissions. It replaces the unrelated generated counter test.

Add tests for every feature or fix. This initial baseline does not claim full screen navigation, real-device, offline-sync or end-to-end backend coverage. A web build is a compilation check; other platform builds need separate jobs as those targets are prepared.

Push a feature branch and open a pull request. Merge only after **Flutter checks** passes. Main branch protection must require a pull request and this check to enforce that rule. Do not add deployment secrets to these tests.
