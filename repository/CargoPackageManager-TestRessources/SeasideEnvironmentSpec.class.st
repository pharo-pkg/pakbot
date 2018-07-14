Class {
	#name : #SeasideEnvironmentSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #spec }
SeasideEnvironmentSpec >> dependencies [
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
]

{ #category : #'as yet unclassified' }
SeasideEnvironmentSpec >> name [
	^ 'Seaside-Environment'
]

{ #category : #'as yet unclassified' }
SeasideEnvironmentSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideEnvironmentSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Environment' .
		#versionString -> 'pmm.81' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideEnvironmentSpec >> srcArtifact [
	^ 'Seaside-Environment-pmm.81'
]

{ #category : #'as yet unclassified' }
SeasideEnvironmentSpec >> version [
	^  '3.1'
]
