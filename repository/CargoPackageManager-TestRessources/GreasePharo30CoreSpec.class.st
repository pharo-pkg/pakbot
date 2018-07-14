Class {
	#name : #GreasePharo30CoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
GreasePharo30CoreSpec >> dependencies [
	"(package addDependency: 'Grease-Tests-Core')
		version: self package version;
		applyStrictUpdatePolicy;
		yourself.
"
	^ #()
]

{ #category : #'as yet unclassified' }
GreasePharo30CoreSpec >> name [
	^ 'Grease-Pharo30-Core'
]

{ #category : #'as yet unclassified' }
GreasePharo30CoreSpec >> platformRequirements [
	^ #(#pharo)
]

{ #category : #spec }
GreasePharo30CoreSpec >> provisions [
	^ #(#'Grease-Core-Platform@1.0')
]

{ #category : #'as yet unclassified' }
GreasePharo30CoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Grease11/main')
]

{ #category : #'as yet unclassified' }
GreasePharo30CoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Grease11/main' .
		#packageName -> 'Grease-Pharo30-Core' .
		#versionString -> 'pmm.11' } asDictionary
]

{ #category : #'as yet unclassified' }
GreasePharo30CoreSpec >> srcArtifact [
	^ 'Grease-Pharo30-Core-pmm.11'
]

{ #category : #'as yet unclassified' }
GreasePharo30CoreSpec >> testArtifact [
	^ 'Grease-Tests-Pharo20-Core-pmm.8'
]

{ #category : #'as yet unclassified' }
GreasePharo30CoreSpec >> version [
	^  '1.1.5'
]
