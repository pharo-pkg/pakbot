fetching
package: aPackageName
	^ (self rootDirectory / aPackageName asLowercase) exists
		ifTrue: [ CGOPackageProvider default packageNamed: aPackageName ]
		ifFalse: [ (self virtualDirectory / aPackageName asLowercase) exists
			ifTrue: [ CGOPackageProvider default virtualPackageNamed: aPackageName ]
			ifFalse: [ CGOPackageNotFoundError signal: aPackageName ] ]