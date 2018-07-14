Class {
	#name : #SeasideWelcomeSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Welcome'
}

{ #category : #spec }
SeasideWelcomeSpec >> dependencies [
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
]

{ #category : #'as yet unclassified' }
SeasideWelcomeSpec >> name [
	^ 'Seaside-Welcome'
]

{ #category : #'as yet unclassified' }
SeasideWelcomeSpec >> srcArtifact [
	^ 'Seaside-Welcome-pmm.47'
]

{ #category : #'as yet unclassified' }
SeasideWelcomeSpec >> version [
	^  '3.1'
]
