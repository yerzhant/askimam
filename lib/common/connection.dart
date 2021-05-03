const apiUrl = String.fromEnvironment(
  'api-url',
  // defaultValue: 'http://10.0.2.2:8080',
  defaultValue: 'http://192.168.0.102:8080',
);

const audioUrl = '$apiUrl/askimam/audio';
