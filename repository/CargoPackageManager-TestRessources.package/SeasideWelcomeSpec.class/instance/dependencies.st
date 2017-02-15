spec
dependencies
	^ { #'Seaside-Environment' -> #('=3.1') .
		#'Seaside-Tools-Web' -> #('=3.1') .
		#'Seaside-Widgets' -> #('=3.1') .
		#'Seaside-Examples' -> #('=3.1') .
		#'Seaside-Development' -> #('=3.1') .
		#'Seaside-Flow' -> #('=3.1') .
		#'JQuery-Core' -> #('=3.1') .
		#'JQuery-UI' -> #('=3.1') .
		#'Seaside-Welcome-Platform' -> #('=1') }

	"(package addDependency: 'Seaside-Tests-Flow')
		version: '';
		yourself."