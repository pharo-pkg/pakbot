spec
dependencies
	^ { #'Seaside-Core' -> #('=3.1') .
		#'Seaside-Component' -> #('=3.1') .
		#'Seaside-RenderLoop' -> #('=3.1') .
		#'Seaside-Session' -> #('=3.1') .
		#'Seaside-Tools-Core-Platform' -> #('=1') }

	"(package addDependency: 'Seaside-Pharo-Tools-Spec')
		addFixedVersionConstraint: package version;
		platform: #pharo3
		yourself."

