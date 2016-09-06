versions fetching
fetch: aPackageName version: aVersion
	| versionString packageId |
	versionString := aVersion asString.
	packageId := self packageVoyageId: aPackageName.
	^ (CGOPackageVersion selectOne: [ :each | (each at: 'package.__id') = packageId & (each version = versionString) ])
		ifNil: [ CGOPackageVersionNotFoundError signal: 'Cannot find ' , aPackageName , '@' , versionString ]