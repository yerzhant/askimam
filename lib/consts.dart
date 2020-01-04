const policyUrl =
    'https://azan.kz/maqalat/read/politika-konfidentsialnosti-prilozheniya-vopros-imamu-na-azankz-10978';

// const _isRelease = bool.fromEnvironment('dart.vm.product');
const _isRelease = true;
// const _isRelease = false;

const usersCollection = _isRelease ? 'users' : 'testUsers';
const topicsCollection = _isRelease ? 'topics' : 'testTopics';
const messagesCollection = _isRelease ? 'messages' : 'testMessages';
const imamsTopic = _isRelease ? 'imams' : 'testImams';
const audioFolder = _isRelease ? 'audio' : 'test-audio';
const messagesIndex = 'messages';
const topicsChunkSize = 20;
