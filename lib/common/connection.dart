const apiUrl = String.fromEnvironment(
  'api-url',
  // defaultValue: 'http://10.0.2.2:8080',
  defaultValue: 'http://192.168.0.102:8080/v1',
);

const audioUrl = String.fromEnvironment(
  'audio-url',
  defaultValue: 'http://azan-dev/askimam/audio',
);
