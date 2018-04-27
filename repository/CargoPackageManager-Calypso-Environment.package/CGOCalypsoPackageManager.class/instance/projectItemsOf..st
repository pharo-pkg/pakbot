accessing
projectItemsOf: aCGOProject
	^ (self packagesOf: aCGOProject), 
		(aCGOProject assemblies collect: [:each | 
			CGOClyPackageAssembly of: (self projectOf: each) on: each]), 
		(aCGOProject virtualPackages collect: [:each | 
			CGOClyVirtualPackage of: (self projectOf: each) on: each])