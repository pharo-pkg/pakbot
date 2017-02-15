spec
dependencies
	^ { #'Seaside-Tools-Web' -> #('=3.1') .
		#'Seaside-Flow' -> #('=3.1') .
		#'Seaside-Development-Platform' -> #('=1') }

	"(package addDependency: 'Seaside-Pharo-Development')
		platform: #squeakCommon;
		yourself."