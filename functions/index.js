/* eslint-disable max-len */
const {onDocumentUpdated} = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");

admin.initializeApp();

module.exports.newMemberInGroup = onDocumentUpdated("groups/{groupId}", async (event) => {
  const groupId = event.params.groupId;
  const oldValue = event.data.before.data();
  const newValue = event.data.after.data();

  const oldMembers = oldValue.members || [];
  const newMembers = newValue.members || [];

  // Check if a new member was added
  if (oldMembers.length >= newMembers.length) {
    console.log("No new members added.");
    return;
  }

  // Identify the new member(s)
  const newMember = [...newMembers].reverse().find((member) => !oldMembers.includes(member));
  if (!newMember) {
    console.log("No specific new member identified.");
    return;
  }

  console.log(`New member detected: ${newMember.userId}`);

  // Query Firestore to get the new member's details
  let newMemberName;
  try {
    const userDoc = await admin.firestore().collection("users").doc(newMember.userId).get();
    if (!userDoc.exists) {
      console.log(`User with ID ${newMember.userId} not found in Firestore.`);
      return;
    }
    newMemberName = userDoc.data().name || "Unknown User";
    console.log(`New member's name: ${newMemberName}`);
  } catch (error) {
    console.error(`Error fetching user with ID ${newMember.userId}:`, error);
    return;
  }

  // Notification content
  const notificationPayload = {
    notification: {
      title: "Welcome a new guest!",
      body: `${newMemberName} has joined the group!`,
    },
  };

  const notificationPromises = oldMembers.map((member) => {
    const topic = `user_${member.userId}`;
    console.log(`Sending notification to topic: ${topic}`);
    return admin.messaging().send({topic: topic, notification: notificationPayload.notification});
  });

  try {
    await Promise.all(notificationPromises);
    console.log(`Notifications sent to group ${groupId} members except ${newMember}.`);
  } catch (error) {
    console.error("Error sending notifications:", error);
  }
});
