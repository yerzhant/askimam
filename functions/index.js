// firebase functions:shell
// firebase deploy

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp({
    credential: admin.credential.applicationDefault(),
    storageBucket: 'azan-kz-ask-imam.appspot.com'
});
const searchEngine = require('./search-engine');

exports.messageCreated = functions.region('europe-west1').firestore
    .document('messages/{id}')
    .onCreate(async (snap, context) => {
        const message = snap.data();

        try {
            const topicSnap = await admin.firestore().doc(`/topics/${message.topicId}`).get();

            const topic = topicSnap.data();

            if ('isPublic' in topic && topic.isPublic) {
                const id = context.params.id;
                searchEngine.indexMessage(id, message.topicId, topic.name, message.text);
            }

            const isNewQuestion = topic.imamUid === null;

            const title = (isNewQuestion ? 'Новый вопрос: ' : '') + topic.name;

            let token = null;
            if (!isNewQuestion) {
                token = message.sender === 'q' ? topic.imamFcmToken : topic.fcmToken;
            }

            sendNotification(title, message.text, token);

            return null;
        } catch (e) {
            return console.error('Error getting Firestore data: ' + e);
        }
    });

function sendNotification(title, body, token) {
    const message = {
        // data: {
        //     click_action: 'FLUTTER_NOTIFICATION_CLICK'
        // },
        notification: {
            title,
            body
        },
        android: {
            // priority: 'high',
            notification: {
                sound: 'default',
                click_action: 'FLUTTER_NOTIFICATION_CLICK'
            }
        }
    };

    if (token === null) {
        message.topic = 'imams';
    } else {
        message.token = token;
    }

    admin.messaging().send(message)
        .catch(e => console.error('Error on sending notification: ' + e));
}

exports.messageDeleted = functions.region('europe-west1').firestore
    .document('messages/{id}')
    .onDelete(async (snap, context) => {
        const message = snap.data();

        try {
            if ('audioUrl' in message) {
                const bucket = admin.storage().bucket();
                await bucket.file(`audio/${context.params.id}`).delete();
            }

            // const topicSnap = await admin.firestore().doc(`/topics/${message.topicId}`).get();
            // const topic = topicSnap.data();
            // if ('isPublic' in topic && topic.isPublic) {
            const id = context.params.id;
            searchEngine.deleteMessage(id);
            // }

            return null;
        } catch (e) {
            return console.error('Error getting Firestore data: ' + e);
        }
    });

exports.topicUpdated = functions.region('europe-west1').firestore
    .document('topics/{id}')
    .onUpdate((changeSnap, context) => {
        const before = changeSnap.before.data();
        const after = changeSnap.after.data();
        if (after.imamUid === null || before.imamUid === after.imamUid) return null;

        admin.firestore().collection('users').doc(after.imamUid).update({
            answered: admin.firestore.FieldValue.increment(1)
        });
        return null;
    });

// exports.reindexMessages = functions.region('europe-west1').firestore
//     .document('')
//     .onCreate(async () => {
//         const topics = await admin.firestore()
//             .collection('topics')
//             .where('isPublic', '==', true)
//             .get();

// /*      This is for faster upload in case current solution will be slow.  
//         const records = [];
//         index
//             .saveObjects(records)
//             .then(() => {
//               console.log('Contacts imported into Algolia');
//             })
//             .catch(error => {
//               console.error('Error when importing contact into Algolia', error);
//               process.exit(1);
//             });*/

//         topics.forEach(async snap => {
//             const topic = snap.data();

//             const messages = await admin.firestore()
//                 .collection('messages')
//                 .where('topicId', '==', snap.id)
//                 .get();

//             messages.forEach(msgSnap => {
//                 const message = msgSnap.data();
//                 searchEngine.indexMessage(msgSnap.id, message.topicId, topic.name, message.text);
//             });
//         });

//         return null;
//     });

// exports.getImamsAnswers = functions.region('europe-west1').firestore
//     .document('')
//     .onCreate(async (snap) => {
//         const topics = await admin.firestore()
//             .collection('topics')
//             .where('imamUid', '==', snap.data().imamUid)
//             .get();

//         console.log(topics.size);

//         return null;
//     });

// exports.updateMsg = functions.region('europe-west1').firestore
//     .document('')
//     .onCreate(async (snap) => {
//         const topics = await admin.firestore()
//             .collection('messages')
//             .doc('-Lkj8p3RtoRj6gNDXfhl')
//             .set({
//                 text:
// `السلام عليكم!

// إعراب القرآن يقول:

// (وَيُسْقَوْنَ فِيهَا كَأْسًا كَانَ مِزَاجُهَا زَنجَبِيلًا)
// الإنسان (17)

// «وَيُسْقَوْنَ» حرف عطف ومضارع مبني للمجهول والواو نائب فاعل و«فِيها» متعلقان بالفعل و«كَأْساً» مفعول به ثان والجملة معطوفة على ما قبلها و«كانَ مِزاجُها زَنْجَبِيلًا» كان واسمها وخبرها والجملة صفة كأسا.

// لماذا الكلمة "كأسا" مفعول به ثان؟ أين مفعول به أول؟`
//             }, {
//                 merge: true
//             });

//         return null;
//     });