version=0.0.2
flutter build web --dart-define=api-url=https://api.askimam.azan.kz/v1 --dart-define=audio-url=https://azan.kz/askimam/audio
docker build -f nginx/Dockerfile -t $AskimamRegistry/askimam:$version .
docker push $AskimamRegistry/askimam:$version
