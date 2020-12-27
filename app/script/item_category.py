import openpyxl

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

fan = ['ADT', 'ADF', 'ADB', 'ARD', 'ASH', 'RSH', 'ADH', 'RDH', 'CD', 'AF', 'NVF-AK', 'BIO','NVF-BC']
spring = ['FDS', 'FLS', 'NP', 'NG', 'RH', 'SHAA', 'SHAB', 'SM', 'SRH']

category = {
	'axial': ['ADT', 'ADF', 'ADB', 'ARD'],
	'centrifugal': ['ASH', 'RSH', 'ADH', 'RDH'],
	'cabinet': ['CD'],
	'prepeller_axial': ['AF', 'NVF-AK'],
	'centrifugal_inline': ['BIO'],
	'ceiling': ['NVF-BC'],
}

series_to_type = {
	'adt': 'axial',
	'adf': 'axial',
	'adb': 'axial',
	'ard': 'axial',
	'ash': 'centrifugal',
	'rsh': 'centrifugal',
	'adh': 'centrifugal',
	'rdh': 'centrifugal',
	'cd': 'cabinet',
	'af': 'propeller_axial',
	'nvf_ak': 'propeller_axial',
	'bio': 'centrifugal_inline',
	'nvf_bc': 'ceiling',
	'fds': 'spring',
	'fls': 'spring',
	'np': 'spring',
	'ng': 'spring',
	'rh': 'spring',
	'shaa': 'spring',
	'shab': 'spring',
	'sm': 'spring',
	'srh': 'spring',

}

series_id = {
	'ADT': 'adt',
	'ADB': 'adb',
	'ADF': 'adf',
	'ARD': 'ard',
	'ASH': 'ash',
	'RSH': 'rsh',
	'ADH': 'adh',
	'RDH': 'rdh',
	'CD': 'cd',
	'AF': 'af',
	'NVF-AK': 'nvf_ak',
	'BIO': 'bio',
	'NVF-BC': 'nvf_bc',
	'FDS': 'fds',
	'FLS': 'fls',
	'NP': 'np',
	'NG': 'ng',
	'RH': 'rh',
	'SHAA': 'shaa',
	'SHAB': 'shab',
	'SM': 'sm',
	'SRH': 'srh',
	'_': '_',
}


'category': {
	'axial': {
		'_id': 'axial',
		'name': 'Axial',
		'type': ['adb', 'adt', 'ard'],
		''

	}
}


def main():

	cred = credentials.Certificate("./serviceAccountKey.json")
	firebase_admin.initialize_app(cred)
	db = firestore.client()
	for d in data:
		print('[+] Storing {}'.format(d['_id']))
		db.collection(u'items').document(d['_id']).set(d, merge=True)

	print('[+] Data stored.')

if __name__ == '__main__':
	main()