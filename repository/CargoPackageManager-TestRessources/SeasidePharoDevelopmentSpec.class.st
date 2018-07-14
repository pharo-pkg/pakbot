Class {
	#name : #SeasidePharoDevelopmentSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasidePharoDevelopmentSpec >> dependencies [
	"package addDependency: 'Seaside-Development'."
	"package addRequirement: #'Seaside-Tools-Web-Platform'."
	"package addDependency: 'Seaside-Pharo-Flow'."
	^ #()
]

{ #category : #'as yet unclassified' }
SeasidePharoDevelopmentSpec >> name [
	^ 'Seaside-Pharo-Development'
]

{ #category : #'as yet unclassified' }
SeasidePharoDevelopmentSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #spec }
SeasidePharoDevelopmentSpec >> provisions [
	^ #(#'Seaside-Development-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasidePharoDevelopmentSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasidePharoDevelopmentSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Pharo-Development' .
		#versionString -> 'JohanBrichau.66' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasidePharoDevelopmentSpec >> srcArtifact [
	^ 'Seaside-Pharo-Development-JohanBrichau.66'
]

{ #category : #'as yet unclassified' }
SeasidePharoDevelopmentSpec >> version [
	^  '3.1'
]
