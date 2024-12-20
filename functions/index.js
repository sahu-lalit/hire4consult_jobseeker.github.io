/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNotificationOnJobViewed = functions.firestore
    .document("applications/{1:934014512463:web:5845a54e65f9b3721f693a}")
    .onUpdate(async (change, context) => {
      const newValue = change.after.data();
      const previousValue = change.before.data();

      // Check if 'opened' field changed from false to true
      if (!previousValue.opened && newValue.opened) {
        const userId = newValue.userDetails.userId;

        // Fetch the user's FCM token
        const userDoc = await admin.firestore()
            .collection("users").doc(userId).get();
        const fcmToken = userDoc.data().fcmToken;

        if (fcmToken) {
          const payload = {
            notification: {
              title: "Job Application Viewed",
              body: "An employer has viewed your job application!",
            },
          };
          await admin.messaging().sendToDevice(fcmToken, payload);
        }
      }
    });

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
