instance creation
with: aStringOrSemanticVersion 
	^ self new
		initializeWith: aStringOrSemanticVersion asSemanticVersion;
		yourself.