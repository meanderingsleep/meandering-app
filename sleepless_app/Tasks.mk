.PHONY: sleepless_app/install sleepless_app/check

sleepless_app/install:
	cd sleepless_app; flutter pub get

sleepless_app/check:
	cd sleepless_app; dart format lib --line-length 100 --set-exit-if-changed
#	cd sleepless_app; flutter test
	cd sleepless_app; dart run cyclic_dependency_checks .
