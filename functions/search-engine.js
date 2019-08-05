const functions = require('firebase-functions');
const algoliasearch = require('algoliasearch');

const ALGOLIA_ID = functions.config().algolia.app_id;
const ALGOLIA_ADMIN_KEY = functions.config().algolia.api_key;

const ALGOLIA_INDEX_NAME = 'messages';
const client = algoliasearch(ALGOLIA_ID, ALGOLIA_ADMIN_KEY);
const index = client.initIndex(ALGOLIA_INDEX_NAME);

exports.indexMessage = function (objectID, topicId, topicName, text) {
    const message = {
        objectID,
        topicId,
        topicName,
        text
    }

    return index.saveObject(message);
}

exports.deleteMessage = function (objectID) {
    return index.deleteObject(objectID);
}