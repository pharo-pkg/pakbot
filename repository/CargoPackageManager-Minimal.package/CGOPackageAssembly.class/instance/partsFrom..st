initialization - private
partsFrom: aDictionary
	^ (self mandatoryKey: #parts from: aDictionary)
		collect: #asPackageDependency