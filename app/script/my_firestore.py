import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

data = {'test': 500}

cred = credentials.Certificate("./serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db = firestore.client()
db.collection(u'fans').document(u'stock').set(data, merge=True)

print('DONE.')