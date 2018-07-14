Class {
	#name : #SeasideCoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #spec }
SeasideCoreSpec >> dependencies [
	^ { #'Grease-Core' -> #('=1.1.5') .
		#'Seaside-Core-Platform' -> #('=1.0') }
	"(package addDependency: 'Seaside-Pharo20-Core')
		platform: #pharo3;
		yourself."
]

{ #category : #'as yet unclassified' }
SeasideCoreSpec >> name [
	^ 'Seaside-Core'
]

{ #category : #'as yet unclassified' }
SeasideCoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideCoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Core' .
		#versionString -> 'pmm.808' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideCoreSpec >> srcArtifact [
	^ 'Seaside-Core-pmm.808'
]

{ #category : #'as yet unclassified' }
SeasideCoreSpec >> version [
	^  '3.1'
]
