Class {
	#name : #SeasideTestsPharoEmailSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasideTestsPharoEmailSpec >> dependencies [
	^ { #'Seaside-Email' -> #('=3.1') .
		#'Seaside-Pharo-Email' -> #('=3.1') .
		#'Grease Core Tests' -> #('=3.1') }

]

{ #category : #'as yet unclassified' }
SeasideTestsPharoEmailSpec >> name [
	^ 'Seaside-Tests-Pharo-Email'
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoEmailSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoEmailSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoEmailSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoEmailSpec >> version [
	^  '3.1.0'
]
