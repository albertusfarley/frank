products = {
	'Axial': ['ADT', 'ADF', 'ADB', 'ARD'],
	'Centrifugal': ['ASH', 'RSH', 'ADH', 'RDH'],
	'Cabinet': ['CD'],
	'Propeller Axial': ['AF', 'NVF-AK'],
	'Centrifugal Inline': ['BIO'],
	'Ceiling': ['NVF-BC'],
	'Spring': ['FDS', 'FLS', 'NP', 'NG', 'RH', 'SHAA', 'SHAB', 'SM', 'SRH'],
	'_': ['_']
	
}

def getProducts():
	return products

types_id = {
	'Axial': 'axial',
	'Centrifugal': 'centrifugal',
	'Cabinet': 'cabinet',
	'Propeller Axial': 'propeller_axial',
	'Centrifugal Inline': 'centrifugal_inline',
	'Ceiling': 'ceiling',
	'Spring': 'spring',
	'_': '_'
}

def getTypesID():
	return types_id

types_index = {
	'Axial': 1,
	'Centrifugal': 2,
	'Cabinet': 3,
	'Propeller Axial': 4,
	'Centrifugal Inline': 5,
	'Ceiling': 6,
	'Spring': 7,
	'_': 8
}

def getTypesIndex():
	return types_index

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
def getSeriesID():
	return series_id

series_name = {
	'ADT': 'Axial Long Cased',
	'ADB': 'Axial Bifurcated',
	'ADF': 'Axial Smoke Fan',
	'ARD': 'Axial Roof',
	'ASH': 'Single Inlet Centrifugal Fans Belt Driven with Forward Curved Blades',
	'RSH': 'Single Inlet Centrifugal Fans Belt Driven with Backward Curved Blades',
	'ADH': 'Centrifugal Double Inlet Fans with Forward Curved Blades',
	'RDH': 'Centrifugal Double Inlet Fans Backward Curves Blades',
	'CD': 'Cabinet Fans Direct Drive',
	'AF': 'Propeller Axial Fans',
	'NVF-AK': 'Ultra Thin Panel Full Plastic Ventilating Fans',
	'BIO': 'Outer Rotor Inline Fans',
	'NVF-BC': 'Tubular Ventilating Fans',
	'FDS': 'Mounted Spring',
	'FLS': 'Mounted Spring',
	'NP': 'Rubber Pad',
	'NG': 'Rubber Pad',
	'RH': 'Spring Hanger',
	'SHAA': 'Spring Hanger',
	'SHAB': 'Spring Hanger',
	'SM': 'Mounted Spring',
	'SRH': 'Spring Hanger',
	'_': '_',
}
def getSeriesName():
	return series_name

image = {
	'ADT': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/ADT.jpg',
	'ADB': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/ADB.jpg',
	'ADF': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/ADF.jpg',
	'ARD': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/ARD.jpg',
	'ASH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/ASH.jpg',
	'RSH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/RSH.jpg',
	'ADH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/ADH.jpg',
	'RDH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/RDH.jpg',
	'CD': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/CD.jpg',
	'AF': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/AF.jpg',
	'NVF-AK': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/NVF-AFK.jpg?',
	'BIO': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/BIO.jpg',
	'NVF-BC': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/NVF-BC.jpg?',
	'FDS': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/FDS.jpg',
	'FLS': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/FLS.jpg',
	'NP': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/NP.jpg',
	'NG': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/NG.jpg',
	'RH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/RH.jpg',
	'SHAA': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/SHAA.jpg',
	'SHAB': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/SHAB.jpg',
	'SM': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/SM.jpg',
	'SRH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/images/SRH.jpg',
	'_': '',
}
def getImage():
	return image

thumbnail = {
	'ADT': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/ADT.png',
	'ADB': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/ADB.png',
	'ADF': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/ADF.png',
	'ARD': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/ARD.png',
	'ASH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/ASH.png',
	'RSH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/RSH.png',
	'ADH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/ADH.png',
	'RDH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/RDH.png',
	'CD': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/CD.png',
	'AF': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/AF.png',
	'NVF-AK': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/NVF-AFK.png',
	'BIO': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/BIO.png',
	'NVF-BC': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/NVF-BC.png',
	'FDS': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/FDS.png',
	'FLS': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/FLS.png',
	'NP': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/NP.png',
	'NG': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/NG.png',
	'RH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/RH.png',
	'SHAA': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/SHAA.png',
	'SHAB': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/SHAB.png',
	'SM': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/SM.png',
	'SRH': 'https://raw.githubusercontent.com/albertusfarley/frank/main/assets/thumbnails/SRH.png',
	'_': '',
}
def getThumbnail():
	return thumbnail

pdf = {
	'ADT': ['http://www.simtex.co.id/catalogue/ADT.pdf'],
	'ADB': ['http://www.simtex.co.id/catalogue/ADB_1.pdf', 'http://www.simtex.co.id/catalogue/ADB2.pdf'],
	'ADF': ['http://www.simtex.co.id/catalogue/ADF.pdf'],
	'ARD': ['http://www.simtex.co.id/catalogue/ARD_1.pdf ', 'http://www.simtex.co.id/catalogue/ARD_2.pdf'],
	'ASH': ['http://www.simtex.co.id/catalogue/ASH-RSH.pdf'],
	'RSH': ['http://www.simtex.co.id/catalogue/ASH-RSH.pdf'],
	'ADH': ['http://www.simtex.co.id/catalogue/ADH.pdf'],
	'RDH': ['http://www.simtex.co.id/catalogue/RDH.pdf'],
	'CD': ['http://www.simtex.co.id/catalogue/CD.pdf'],
	'AF': ['http://www.simtex.co.id/catalogue/AFQ.pdf'],
	'NVF-AK': ['http://www.simtex.co.id/catalogue/NVF-AK.pdf'],
	'BIO': ['http://www.simtex.co.id/catalogue/BIO.pdf'],
	'NVF-BC': ['http://www.simtex.co.id/catalogue/NVF-BC.pdf'],
	'FDS': ['http://www.simtex.co.id/catalogue/FDS.pdf'],
	'FLS': ['http://www.simtex.co.id/catalogue/FLS.pdf'],
	'NP': ['http://www.simtex.co.id/catalogue/NP_&_NG.pdf'],
	'NG': ['http://www.simtex.co.id/catalogue/NP_&_NG.pdf'],
	'RH': ['http://www.simtex.co.id/catalogue/RH.pdf'],
	'SHAA': ['http://www.simtex.co.id/catalogue/SHAA-SHAB.pdf'],
	'SHAB': ['http://www.simtex.co.id/catalogue/SHAA-SHAB.pdf'],
	'SM': '',
	'SRH': ['http://www.simtex.co.id/catalogue/SRH.pdf'],
	'_': [''],
}
def getPDF():
	return pdf



desc = {
	'ADT': '',
	'ADB': 
	'''
- Nicotra Gebhardt ADB series fan are particularly Suitable for the extraction removal of hot, dusty laden, corrosive fumes or gaseous. Widely used in the kitchen fumes extraction and other dusty envinronment where the electrical motor is isolated from the hazardous air stream.
- The Nicotra Gebhardt axial fan provide wide range of air volume from 360 cmh to 216000 cmh, at static pressure up to 1000 Pa 
	''',
	'ADF':
	'''
- Nicotra Gebhardt ADF smoke spill axial fans areparticularly designed for the removal of hot toxic smoke
- The Nicotra Gebhardt axial fan provide wide range of air volume from 360 cmh to 216000 cmh, at static pressure up to 1000 Pa
	''',
	'ARD': 
	'''
- Nicotra ARD are particularly suitable for the roof extraction of stale air, for general ventilation.
- The Nicotra Gebhardt axial fan provide wide range of air volume from 360 cmh to 216000 cmh, at static pressure up to 1000 Pa 
	''',
	'ASH':
	'''
- The ASH fans have single width, single inlet centrifugal impellers with forward curved blades.
- The ASH range is based on 15 sizes, from 200 up to 1000 mm of wheel diameter
- The ASH volume rates range is from 450 cmh to 78000 cmh
- All the scrolls are made with hot dip galvanised steel EN 10142
- ASH are available in four arrangement 3 versions, L, R, K and K1 and in two arrangements 1 versions, T and T1
- ASH impellers are statically and dynamically balanced according to ISO 1940 with grade G4
- Ignition protected versions can be built on request.
- All the versions with side frames can be easily turned to install them in one of the four orientations 
	''',
	'RSH':
	'''
- The RSH fans have single width, single inlet centrifugal impellers with backward curved blades.
- The RSH range is based on 13 sizes, from 250 up to 1000 mm of wheel diameter
- The RSH volume rates range is from 450 cmh to 72000 cmh
- All the scrolls are made with hot dip galvanised steel EN 10142
- RSH are available in four arrangement 3 versions, L, R, K and K1 and in two arrangements 1 versions, T and T1
- RSH impellers are statically and dynamically balanced according to ISO 1940 with grade G4
- Ignition protected versions can be built on request.
- All the versions with side frames can be easily turned to install them in one of the four orientations 
	''', 
	'ADH': 
	'''
Double Inlet Centrifugal Fans Belt Driven with Forward Curved Blades
	''',
	'RDH': 
	'''
Double Inlet Centrifugal Fans Belt Driven with Backward Curved Blades
	''',
	'CD': 
	'''
- The CD cabinet fans is available in 5 standard sizes.
- The CD cabinet fans has maximum flow rates of 3500 CMH and maximum Static Pressure of 500 Pa
- The CD cabinet fans has maximum noise of 68 dB(A)
	''',
	'AF': 
	'''
- This Series comprises of 7 model sizes with impeller diameter 315, 355, 400, 450, 500 and 630.
- The wide range of electrical motors together with the possibility of using different blade angles
- The AF propeller Axial Fans covers an airflow range between 500 CMH and 14000 CMH
	''',
	'NVF-AK': 
	'''
- This Series comprises of 4 model sizes consist of NVF-AK6, NVF-AK8, NVF-AK10 and NVF-AK12.
- The NVF-AK covers an airflow range between 300 CMH and 1200 CMH
- Top Grade plastic Material
- Easy instalation for wall
- Complete with automatic shutter
	''',
	'BIO': 
	'''
- This Series comprises of 6 model sizes consist of BIO-100, BIO-125, BIO-150, BIO-200, BIO-250 and BIO-300
- The BIO fan covers an airflow range at maximum range 1400 cmh
- 3 speed motor for H/M/L air volume
- General ventilation for house meeting room.
- Duct boosting
- High efficiency, Low noise
	''',
	'NVF-BC': 
	'''
- This Series comprises of 4 model sizes consist of NVF-BC810, NVF-BC815, NVF-BC1020 and NVF-BC1030.
- The NVF-BC covers an airflow range between 140 CMH and 300 CMH
- Quiet
- Long life motor or NMB ball bearing
	''',
	'FDS': 
	'''
Spring Vibration Isolator model Kinetic terdiri dari defleksi tinggi, Free-standing, unhoused, diameter besar, dan  steel spring lateral stabil yang dirakit menjadi upper load plate dan leveling assembly. Spring FDS dilapisi menggunakan epoxy powder, dengan salt spray rating selama 1000 jam sesuai dengan ASTM B-117. FDS Isolator tersedia dengan defleksi sampai dengan 4" dan kapasitas beban sampai dengan 23.200 lbs (10.523 kg) sebagai standard produk. isolator custom dengan defleksi yang lebih tinggi dan kapasitas beban yang lebih besar tersedia. Spring Mount Kinetic model FDS direkomendasikan untuk mengisolasi sumber suara dan noise yang floor mounted, yang terletak dekat daerah yang kritis tenang.
	''',
	'FLS': 
	'''
Spring Vibration Isolator model Kinetic terdiri dari defleksi tinggi, Free-standing, diameter besar, dan  steel spring lateral stabil yang dirakit menjadi welded steel housing assemblies yang dibuat untuk membatasi pergerakan vertical dari peralatan yang terisolasi apabila beban beban peralatan mengalami pengurangan atau apabila peralatan menerima tenaga luar yang besar. Spring FLS dilapisi menggunakan epoxy powder, dengan salt spray rating selama 1000 jam sesuai dengan ASTM B-117. FDS Isolator tersedia dengan defleksi sampai dengan 2.03" (52 mm) dan kapasitas beban sampai dengan 15.600 lbs (7076 kg) sebagai standard produk. isolator custom dengan defleksi yang lebih tinggi dan kapasitas beban yang lebih besar tersedia. Spring Mount Kinetic model FLS direkomendasikan untuk mengisolasi sumber suara dan untuk Peralatan mekanikal yang terletak dekat daerah yang kritis tenang, ketika peralatan yang ingin diisolasi memiliki perubahan berat yang signifikan pada saat operasi maintenance, dan ketika peralatan akan mendapatkan tekanan dari luar atau memiliki beban angin yang tinggi.
	''',
	'NP': 
	'''
Kinetics Model NP and NG Pads are produced from a high quality elastomer and are available in single ribbed or crossed double ribbed in one or more layers separated with steel shims. Pads are 45 or 65 durometer and are designed for 60 or 120 PSI (4 or 8 kg/m2) maximum loading. The elastomer is oil and water resistant and has been designed to operate within the strain limits of the isolator and to provide long life expectancy. NP Pads are available with rated deflections from 0.04" to 0.09" (1 mm to 2 mm). NG Pads are available with rated deflections from 0.13" to 0.19" (3 mm to 5 mm).
	''',
	'NG': 
	'''
Kinetics Model NP and NG Pads are produced from a high quality elastomer and are available in single ribbed or crossed double ribbed in one or more layers separated with steel shims. Pads are 45 or 65 durometer and are designed for 60 or 120 PSI (4 or 8 kg/m2) maximum loading. The elastomer is oil and water resistant and has been designed to operate within the strain limits of the isolator and to provide long life expectancy. NP Pads are available with rated deflections from 0.04" to 0.09" (1 mm to 2 mm). NG Pads are available with rated deflections from 0.13" to 0.19" (3 mm to 5 mm).
	''',
	'RH': 
	'''
Kinetics Model RH Vibration Isolation Hangers are designed to reduce the transmission of vibration and noise produced by suspended equipment, piping, and ductwork. 
	''',
	'SHAA':
	'''
With lighter weight construction materials used in office buildings, schools and hospitals today, it does not take much energy to generate annoying vibration problems. The SHAA & SHAB rubber and spring vibration isolation hangers are designed to provide high efficiency isolation from structure-borne vibration for lighter point load applications. The SHAA provides 1" (25 mm) deflection at loads of 25, 45 and 55 pounds (11, 20 and 25 kg) and the SHAB provides deflection of 0.5" (13 mm) under loads of 15, 30 and 70 pounds (7, 14 and 32 kg).
	''',
	'SHAB': 
	'''
With lighter weight construction materials used in office buildings, schools and hospitals today, it does not take much energy to generate annoying vibration problems. The SHAA & SHAB rubber and spring vibration isolation hangers are designed to provide high efficiency isolation from structure-borne vibration for lighter point load applications. The SHAA provides 1" (25 mm) deflection at loads of 25, 45 and 55 pounds (11, 20 and 25 kg) and the SHAB provides deflection of 0.5" (13 mm) under loads of 15, 30 and 70 pounds (7, 14 and 32 kg).
	''',
	'SM': 
	'''
Kinetics Model SM Spring Vibration Isolators consist of high deflection, color-coded stabile springs assembled into telescoping cast iron or aluminum housings which are complete with a 1/4" (13 mm) thick ribbed noise isolation pad bonded to the lower load surface, and with an adjusting and leveling bolt as a part of the top assembly. Model SM Spring Isolators are available in deflections up to 1.79" (46 mm) and with load capacities from 250 to 7000 lbs. (115 to 3170 kg). Springs are epoxy powder coated, with a 1000 hour salt spray rating per ASTM B-117.
	''',
	'SRH': 
	'''
Kinetics Model SRH vibration isolation hangers consist of free-standing, large diameter, laterally stable steel springs in series with an elastomer-in-shear insert, assembled into a stamped or welded hanger bracket. Isolation brackets will carry a 500% overload without failure. Hangers are available in deflections from 1.20" to 2.40" (30 to 61 mm), and in capacities from 35 to 3500 lbs. (16 to 1588 kg). 
	''',
	'_': '',
}
def getDesc():
	return desc

customType = ['axial', 'centrifugal']
def getCustomType():
	return customType