Class {
	#name : #SeasideTestsPharoFunctionalSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasideTestsPharoFunctionalSpec >> dependencies [
	^ { #'Seaside-Tests-Functional' -> #('=3.1') .
		#'Seaside-Tests-Environment' -> #('=3.1') .
		#'Seaside-Pharo-Environment' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoFunctionalSpec >> name [
	^ 'Seaside-Tests-Pharo-Functional'
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoFunctionalSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoFunctionalSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoFunctionalSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoFunctionalSpec >> version [
	^  '3.1.0'
]
