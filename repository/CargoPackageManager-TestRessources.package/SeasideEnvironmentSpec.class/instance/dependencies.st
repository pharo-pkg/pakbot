spec
dependencies
	^ { #'Seaside-Core' -> #('=3.1') .
		#'Seaside-Canvas' -> #('=3.1') .
		#'Seaside-Session' -> #('=3.1') .
		#'Seaside-Component' -> #('=3.1') .
		#'Seaside-RenderLoop' -> #('=3.1') .
		#'Seaside-Tools-Core' -> #('=3.1') .
		#'Seaside-Widgets' -> #('=3.1') .
		#'Seaside-Environment-Platform' -> #('=1') }

	"	(package addDependency: 'Seaside-Pharo-Environment')
		platform: #squeakCommon;
		yourself."