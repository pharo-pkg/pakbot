*CargoPackageManager-Utils
includesAny: aListOfPackageName
	^ (self parts collect: #key) 
		includesAny: aListOfPackageName