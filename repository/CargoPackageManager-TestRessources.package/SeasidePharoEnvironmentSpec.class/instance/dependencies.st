as yet unclassified
dependencies
	"(package addDependency: 'Seaside-Environment')
		addFixedVersionConstraint: package version;
		yourself.
	(package addDependency: 'Seaside-Core')
		addFixedVersionConstraint: package version;
		yourself.
	(package addDependency: 'Seaside-Canvas')
		addFixedVersionConstraint: package version;
		yourself."
	^ #()