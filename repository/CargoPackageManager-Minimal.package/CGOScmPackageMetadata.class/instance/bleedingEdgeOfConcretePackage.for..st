versions fetching
bleedingEdgeOfConcretePackage: aPackageName for: platformAttributes
	"just pick the current version in the SCM"
	^ (self package: aPackageName) asPackageVersionReference