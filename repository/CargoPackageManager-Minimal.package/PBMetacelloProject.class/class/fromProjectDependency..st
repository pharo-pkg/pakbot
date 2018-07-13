instance creation
fromProjectDependency: aCGOMetacelloProjectDependency
	^ aCGOMetacelloProjectDependency class projectClass
		repository: aCGOMetacelloProjectDependency repositoryUrl
		name: aCGOMetacelloProjectDependency name
		version: aCGOMetacelloProjectDependency version