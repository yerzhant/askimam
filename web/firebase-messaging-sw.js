importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: 'AIzaSyC4mhP3ox81dtyY_BFM0NtrVbZgt3rlync',
  appId: '1:674391970261:web:4bd8aa4ddc974eeab36d5c',
  messagingSenderId: '674391970261',
  projectId: 'azan-kz-ask-imam',
  authDomain: 'azan-kz-ask-imam.firebaseapp.com',
  databaseURL: 'https://azan-kz-ask-imam.firebaseio.com',
  storageBucket: 'azan-kz-ask-imam.appspot.com',
});

const messaging = firebase.messaging();
