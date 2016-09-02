private
checkPreviousRegistrationOf: aPackageVersion
	| existingPackageVersion |
	
	[ existingPackageVersion := self
		fetch: aPackageVersion packageName
		version: aPackageVersion version.
	aPackageVersion isDevelopmentVersion
		ifFalse:
			[ CGOPackageVersionAlreadyExistsError
				signal: aPackageVersion asString , ' already defined' ] ]
		on:
			CGOPackageNotFoundError , CGOPackageVersionNotFoundError
		do: [  ].	"no version found for release versions => ok"
	^ existingPackageVersion