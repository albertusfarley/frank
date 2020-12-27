import openpyxl

import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

file = 'data.xlsx'
name_column = 'A'
qty_column = 'D'
n = 180

fan = ['ADT', 'ADF', 'ADB', 'ARD', 'ASH', 'RSH', 'ADH', 'RDH', 'CD', 'AF', 'NVF-AK', 'BIO','NVF-BC']
spring = ['FDS', 'FLS', 'NP', 'NG', 'RH', 'SHAA', 'SHAB', 'SM', 'SRH']

category = {
	'Axial Fan': ['ADT', 'ADF', 'ADB', 'ARD'],
	'Centrifugal Fan': ['ASH', 'RSH', 'ADH', 'RDH'],
	'Cabinet Fan': ['CD'],
	'Propeller Axial Fan': ['AF', 'NVF-AK'],
	'Centrifugal Inline': ['BIO'],
	'Ceiling Fan': ['NVF-BC'],
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

def read_data(file, name_column, qty_column, n):
	data = {}

	workbook = openpyxl.load_workbook(file)
	worksheet = workbook['Sheet1']

	cell_value = worksheet['A1'].value.strip() 

	for i in range(1, 181):
		name_cell = name_column + str(i)
		qty_cell = qty_column + str(i)

		name = worksheet[name_cell].value.strip()
		qty = worksheet[qty_cell].value

		data[name] = qty
	return data

def print_data(data):
	for (name, qty) in data.items():
		print('{} [{}]'.format(name, qty))

def main():
	products = []

	count = 0
	data = []
	all_item = read_data(file, name_column, qty_column, n)
	items = all_item.keys()

	fan_category = {}
	for f in fan:
		fan_category[f] = 'Fan'
	for s in spring:
		fan_category[s] = 'Spring'

	for key in category.keys():
		for fan_type in category[key]:
			len_type = len(fan_type)


			items_type = [item for item in items if item[:len_type] == fan_type]

			fc = fan_category[fan_type]
			fan_type = series_id[fan_type]
			if items_type:
				for item in items_type:
					_id = item.lower().replace(' - ', '_').replace(' -', '_').replace('_ ', '_').replace('  ', '_').replace(' ', '_').replace('-', '_').replace('/', '_').replace('(', '').replace(')', '').replace('"', '').replace(',', '.')
					my_item = {
						'_id': _id,
						'name': item,
						'quantity': all_item[item],
						# 'category': fc,
						'series': fan_type,
						'param': _id[0],
					}
					# print('{} {}'.format(fan_type, _id))
					del all_item[item]
					count += 1
					data += [my_item]

	for item in all_item.keys():
		_id = item.lower().replace(' - ', '_').replace(' -', '_').replace('_ ', '_').replace('  ', '_').replace(' ', '_').replace('-', '_').replace('/', '_').replace('(', '').replace(')', '').replace('"', '').replace(',', '.')
		my_item = {
						'_id': _id,
						'name': item,
						'quantity': all_item[item],
						# 'category': '_',
						'series': '_',
						'param': _id[0],

					}
		# print('{} {}'.format('_', _id))
		data += [my_item]
		count += 1

	print('\nitem = {}'.format(count))
	print('\ndata = {}'.format(len(data)))

	cred = credentials.Certificate("./serviceAccountKey.json")
	firebase_admin.initialize_app(cred)
	db = firestore.client()
	for d in data:
		print('[+] Storing {}'.format(d['_id']))
		db.collection(u'items').document(d['_id']).set(d, merge=True)

	print('[+] Data stored.')

if __name__ == '__main__':
	main()