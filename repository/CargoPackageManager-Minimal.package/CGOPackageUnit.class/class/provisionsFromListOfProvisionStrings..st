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
					ifEmpty: [ '1.0.0' ]
					ifNotEmpty: [ pkgVersionRef versionNumber asSemanticVersion asString "Ensure versionNumber is a valid semanantic version"]) ]