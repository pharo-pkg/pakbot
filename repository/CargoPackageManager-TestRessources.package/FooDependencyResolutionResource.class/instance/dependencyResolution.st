building
dependencyResolution
	resolution := CGODependencyResolution new.
	resolution addOriginDependency: self rootDependency.
	(self class methodsInProtocol: #packages) 
		do: [ :each | self addResolvedPackage: each selector ].
	^ resolution