versions fetching
versionsOf: aPackageName
	"Returns the list of versions available in the repository for the given package name"
	| packageId |
	packageId := self packageVoyageId: aPackageName.
	^ CGOPackageVersion selectMany: [ :each | (each at: 'package.__id') = packageId ]