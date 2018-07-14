Class {
	#name : #SeasideTestsPharo20CoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasideTestsPharo20CoreSpec >> dependencies [
	"(package addDependency: 'Seaside-Pharo20-Core')
		version: '';
		yourself.
	(package addDependency: 'Seaside-Tests-Core')
		version: '';
		yourself."
	^ #()
]

{ #category : #'as yet unclassified' }
SeasideTestsPharo20CoreSpec >> name [
	^ 'Seaside-Tests-Pharo20-Core'
]

{ #category : #'as yet unclassified' }
SeasideTestsPharo20CoreSpec >> platformRequirements [
	^ #(#'pharo4.x')
]

{ #category : #spec }
SeasideTestsPharo20CoreSpec >> provisions [
	^ #(#'Seaside-Tests-Core-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasideTestsPharo20CoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsPharo20CoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsPharo20CoreSpec >> version [
	^  '3.1.0'
]
