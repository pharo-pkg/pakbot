accessing
defaultPackageRepository
	^ DefaultPackageRepository ifNil: [ self initialize. DefaultPackageRepository ]