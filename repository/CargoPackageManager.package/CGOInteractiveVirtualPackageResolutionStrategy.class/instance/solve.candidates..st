solving
solve: aDependency candidates: aListOfPackageVersionReferences
	| candidates |
	
	candidates := (aListOfPackageVersionReferences collect: #asPackageVersionReference) 
							groupedBy: #packageName.	
	
	^ (candidates size = 1)
		ifTrue: [ (candidates values first detectMax: #versionNumber) asString ]
		ifFalse: [ CGOUnresolvedDependency 
			package: aDependency targetedPackage 
			candidates: (candidates values collect: [ :each | each detectMax: #versionNumber ]) ]