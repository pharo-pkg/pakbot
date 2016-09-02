private
mandatoryKey: aKey from: aDictionary
	^ aDictionary
		at: aKey
		ifPresent: [ :value |
			value ifNil: [ CGOPackageVersionInitializationError signal: 'No value provided for ' , aKey printString ] ]
		ifAbsent: [ CGOPackageVersionInitializationError signal: 'Cannot find the ', aKey printString , ' key!' ]