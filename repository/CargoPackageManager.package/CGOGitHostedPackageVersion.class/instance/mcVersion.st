accessing
mcVersion
	| iceSavedPackage icePackageVersion |
	iceSavedPackage := self iceRepository packageNamed: packageName.
	icePackageVersion := commitish
		ifNil: [ iceSavedPackage latestVersion ]
		ifNotNil: [ iceSavedPackage versionFor: commitish ].
	^ icePackageVersion mcVersion