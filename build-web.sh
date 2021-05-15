version=1.3.0

flutter test || exit
flutter build web --dart-define=api-url=https://api.askimam.azan.kz/v1 --dart-define=audio-url=https://azan.kz/askimam/audio
docker build -f nginx/Dockerfile -t $AskimamRegistry/askimam:$version .
docker push $AskimamRegistry/askimam:$version

# flutter build web --dart-define=api-url=http://api.askimam.azan-dev/v1 --dart-define=audio-url=http://azan-dev/askimam/audio
# docker build -f nginx/Dockerfile -t $AskimamRegistry/askimam:$version-dev .
# docker push $AskimamRegistry/askimam:$version-dev
