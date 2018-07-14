Class {
	#name : #SeasidePharo20CoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasidePharo20CoreSpec >> dependencies [
	"(package addDependency: 'Seaside-Core')
		addFixedVersionConstraint: package version;
		yourself."
	^ #()
]

{ #category : #'as yet unclassified' }
SeasidePharo20CoreSpec >> name [
	^ 'Seaside-Pharo20-Core'
]

{ #category : #'as yet unclassified' }
SeasidePharo20CoreSpec >> platformRequirements [
	^ #(#'pharo4.x')
]

{ #category : #spec }
SeasidePharo20CoreSpec >> provisions [
	^ #(#'Seaside-Core-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasidePharo20CoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasidePharo20CoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Pharo20-Core' .
		#versionString -> 'pmm.3' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasidePharo20CoreSpec >> srcArtifact [
	^ 'Seaside-Pharo20-Core-pmm.3'
]

{ #category : #'as yet unclassified' }
SeasidePharo20CoreSpec >> version [
	^  '3.1'
]
