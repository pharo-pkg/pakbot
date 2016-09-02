private
bleedingEdgeOfVirtualPackage: aVirtualPackageName for: platformAttributes
	| packagesDict |
	
	packagesDict := ((self packagesProviding: aVirtualPackageName for: platformAttributes) collect: #asPackageVersionReference)
		groupedBy: #packageName.
	
	packagesDict ifEmpty: [ CGOPackageNotFoundError signal: 'Cannot find ' , aVirtualPackageName , ' package'  ].
	
	^ (packagesDict size = 1)
		ifTrue: [ Array with: (packagesDict values first versionNumber) ]
		ifFalse: [ packagesDict values collect: [ :each | each detectMax: #versionNumber ] ]