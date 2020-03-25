


build:
	rm -rf /home/henry/bin/flutter/.pub-cache
	rm -rf /home/henry/.pub-cache
	flutter clean
	flutter pub get
	flutter build
	flutter run

