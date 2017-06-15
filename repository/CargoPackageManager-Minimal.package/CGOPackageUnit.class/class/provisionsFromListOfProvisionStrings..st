utility
provisionsFromListOfProvisionStrings: aListOfProvisionStrings
	" example: self provisionsFromListOfProvisionStrings: #('A@2.0' 'B') "
	aListOfProvisionStrings ifNil: [ ^ #() ].
	^ aListOfProvisionStrings
		collect: [ :provision | | pkgVersionRef |
			pkgVersionRef := provision asPackageVersionReference.
			CGOPackageVersionReference 
				packageName: pkgVersionRef packageName 
				version:	(pkgVersionRef versionNumber 
					ifNil: [ '1.0.0' asSemanticVersion ]
					ifNotNil: [ pkgVersionRef versionNumber ]) ]