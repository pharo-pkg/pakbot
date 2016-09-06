accessing
imageDependencies
	imageDependencies ifNil: [ self buildImageDependencyMap ].
	^ imageDependencies 