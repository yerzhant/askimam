importScripts("https://www.gstatic.com/firebasejs/8.5.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.5.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: "AIzaSyC4mhP3ox81dtyY_BFM0NtrVbZgt3rlync",
    authDomain: "azan-kz-ask-imam.firebaseapp.com",
    databaseURL: "https://azan-kz-ask-imam.firebaseio.com",
    projectId: "azan-kz-ask-imam",
    storageBucket: "azan-kz-ask-imam.appspot.com",
    messagingSenderId: "674391970261",
    appId: "1:674391970261:web:4bd8aa4ddc974eeab36d5c"
});

const messaging = firebase.messaging();
