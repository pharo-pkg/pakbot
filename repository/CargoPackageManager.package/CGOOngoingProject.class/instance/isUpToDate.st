querying - installed
isUpToDate
	
	^ self allDependencies allSatisfy: [ :each | each isInstalled ]