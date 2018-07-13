instance-creation
onDependency: aDependency resolution: aResolution
	
	^ self new
		dependency: aDependency;
		resolution: aResolution;
		yourself