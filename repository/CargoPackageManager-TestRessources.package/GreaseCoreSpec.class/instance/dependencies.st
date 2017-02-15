spec
dependencies
	"(package addDependency: 'Grease-Tests-Core')
		version: self package version;
		applyStrictUpdatePolicy;
		yourself.
"
	^ { #'Grease-Core-Platform' -> #('=1') }