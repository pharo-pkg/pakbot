versions posting
savePackageVersion: aPackageVersion
	| existingPackageVersion |
	
	existingPackageVersion := self checkPreviousRegistrationOf: aPackageVersion.
	aPackageVersion isDevelopmentVersion
		ifTrue: [ existingPackageVersion 
				ifNil: [ aPackageVersion save ]
				ifNotNil: [ self updatePackageVersion: existingPackageVersion with: aPackageVersion ] ]
		ifFalse: [ aPackageVersion save ]