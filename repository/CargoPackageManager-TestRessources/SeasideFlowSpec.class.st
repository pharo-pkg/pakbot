Class {
	#name : #SeasideFlowSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #spec }
SeasideFlowSpec >> dependencies [
	^ { #'Seaside-Core' -> #('=3.1') .
		#'Seaside-Component' -> #('=3.1') .
		#'Seaside-RenderLoop' -> #('=3.1') .
		#'Seaside-Tools-Core' -> #('=3.1') .
		#'Seaside-Flow-Platform' -> #('=1') }

	"(package addDependency: 'Seaside-Pharo-Flow')
		platform: #squeakCommon;
		yourself."
]

{ #category : #'as yet unclassified' }
SeasideFlowSpec >> name [
	^ 'Seaside-Flow'
]

{ #category : #'as yet unclassified' }
SeasideFlowSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideFlowSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Flow' .
		#versionString -> 'pmm.24' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideFlowSpec >> srcArtifact [
	^ 'Seaside-Flow-pmm.24'
]

{ #category : #'as yet unclassified' }
SeasideFlowSpec >> version [
	^  '3.1'
]
