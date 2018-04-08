const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase)
const ref = admin.database().ref()



exports.createUserAccount = functions.auth.user().onCreate(event =>{
  // data coming from the function comes in event.data

  const user = event.data

  const uid = user.uid
  const email = user.email
  const displayName = user.displayName || ""

  // Creates new user in Database
  const newUserRef = ref.child(`/users/${uid}`)
  return newUserRef.set({
    email: email,
    displayName: displayName,
    
    // password: password
  })
})
