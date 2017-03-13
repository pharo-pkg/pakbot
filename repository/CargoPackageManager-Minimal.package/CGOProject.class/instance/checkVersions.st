checking
checkVersions
	self packageUnits , assemblies
		detect: [ :unit | (unit version = version) not ]
		ifFound: [ :unit | 
			CGODifferentPackageVersionsPublication 
				signal: 'Unit ' , unit packageName , ' has a different version (' , unit version asString , ') than the project (' , version asString, ')' ].