const serverUrl = String.fromEnvironment(
  'server-url',
  // defaultValue: 'http://10.0.2.2:8080',
  defaultValue: 'http://192.168.0.102:8080',
);
const apiUrl = '$serverUrl/v1';

const audioUrl = '$serverUrl/askimam/audio';
