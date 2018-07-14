Class {
	#name : #SeasideDevelopmentSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #spec }
SeasideDevelopmentSpec >> dependencies [
	^ { #'Seaside-Tools-Web' -> #('=3.1') .
		#'Seaside-Flow' -> #('=3.1') .
		#'Seaside-Development-Platform' -> #('=1') }

	"(package addDependency: 'Seaside-Pharo-Development')
		platform: #squeakCommon;
		yourself."
]

{ #category : #'as yet unclassified' }
SeasideDevelopmentSpec >> name [
	^ 'Seaside-Development'
]

{ #category : #'as yet unclassified' }
SeasideDevelopmentSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideDevelopmentSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Development' .
		#versionString -> 'pmm.163' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideDevelopmentSpec >> srcArtifact [
	^ 'Seaside-Development-pmm.163'
]

{ #category : #'as yet unclassified' }
SeasideDevelopmentSpec >> version [
	^  '3.1'
]
