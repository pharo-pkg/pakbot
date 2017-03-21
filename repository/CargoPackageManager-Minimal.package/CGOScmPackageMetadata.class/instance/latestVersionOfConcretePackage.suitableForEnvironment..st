versions fetching
latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes
	"just pick the current version in the SCM"
	^ (self package: aPackageName) asPackageVersionReference