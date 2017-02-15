spec
dependencies
	"(package addDependency: 'Seaside-Flow')
		addFixedVersionConstraint: package version;
		yourself."
	^ { #'Seaside-Continuation-Platform' -> #('=1') }