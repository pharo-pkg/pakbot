versions fetching
bleedingEdgeOfConcretePackage: aPackageName for: platformAttributes
	"just pick the current version in the SCM"
	^ Array with: (self package: aPackageName) asPackageVersionReference