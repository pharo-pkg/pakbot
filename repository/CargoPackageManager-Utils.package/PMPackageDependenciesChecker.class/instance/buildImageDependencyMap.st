compute - dependencies
buildImageDependencyMap
	imageDependencies := (self imagePackageDependencies
		collect: [ :each | 
			each packageName -> (each dependencies collect: [:dep | dep target packageName] as: Array) ])
		asDictionary