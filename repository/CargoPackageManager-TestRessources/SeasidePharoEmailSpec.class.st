Class {
	#name : #SeasidePharoEmailSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasidePharoEmailSpec >> dependencies [
	"(package addDependency: 'Seaside-Email')
		platform: #pharo3;
		yourself.
	(package addDependency: 'Seaside-Pharo20-Core')
		platform: #pharo3;
		yourself."
	^ #()
]

{ #category : #'as yet unclassified' }
SeasidePharoEmailSpec >> name [
	^ 'Seaside-Pharo-Email'
]

{ #category : #'as yet unclassified' }
SeasidePharoEmailSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #spec }
SeasidePharoEmailSpec >> provisions [
	^ #(#'Seaside-Email-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasidePharoEmailSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasidePharoEmailSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasidePharoEmailSpec >> version [
	^  '3.1.0'
]
