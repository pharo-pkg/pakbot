private
solveVirtualPackageDependency: aDependency
	| packageName candidates |
	
	packageName := aDependency targetedPackage.
	candidates := repositories flatCollect: [ :repository |
		repository
			packagesProviding: packageName
			version: (self versionFor: packageName)
			forPlatformAttributes: Cargo platformAttributes ].
	
	candidates ifEmpty: [ CGOUnresolvedDependency signal: 'Cannot find ' , packageName , ' virtual package!' ].

	candidates := (candidates collect: #asPackageVersionReference) groupedBy: #packageName.	
	^ (candidates size = 1)
		ifTrue: [ (candidates values first detectMax: #versionNumber) name ]
		ifFalse: [ CGOUnresolvedDependency 
			package: packageName 
			candidates: (candidates values collect: [ :each | each detectMax: #versionNumber ]) ]