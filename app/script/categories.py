import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import importlib
data = importlib.import_module('data')


products = data.getProducts()
types_id = data.getTypesID()
types_index = data.getTypesIndex()
series_id = data.getSeriesID()
series_name = data.getSeriesName()
image = data.getImage()
thumbnail = data.getThumbnail()
pdf = data.getPDF()
desc = data.getDesc()
customType = data.getCustomType()

def main():

	data = []

	types = []
	series = []

	d = {}

	# Untuk Types
	for p in products.keys():
		d['_id'] = types_id[p]
		d['name'] = p
		d['index'] = types_index[p]
		d['description'] = ''
		d['isCustom'] = types_id[p] in customType
		types += [d]
		d = {}


		# print(d)

	# Untuk Series
	# d = {}
	# for p in products.keys():
	# 	for s in products[p]:
	# 		d['_id'] = series_id[s]
	# 		d['code'] = s
	# 		d['name'] = series_name[s]
	# 		d['type'] = types_id[p]
	# 		d['descriptions'] = {
	# 		'description': desc[s]
	# 		}
	# 		d['image'] = image[s]
	# 		d['thumbnail'] = thumbnail[s]
	# 		d['pdf'] = pdf[s]
	# 		d['param'] = series_id[s][0]
	# 		series += [d]
	# 		d = {}
			# print(d)	





	cred = credentials.Certificate("./serviceAccountKey.json")
	firebase_admin.initialize_app(cred)
	db = firestore.client()
	
	for t in types:
		ref = db.collection(u'types').document(t['_id']).set(t, merge=True)
		print('[+] Types {}'.format(t['_id']))

	# for s in series:
	# 	ref = db.collection(u'series').document(s['_id']).set(s, merge=True)
	# 	print('[+] Series {}'.format(s['_id']))


	print('[+] Data stored.')



if __name__ == '__main__':
	main()