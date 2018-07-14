Class {
	#name : #SeasideTestsPharoDevelopmentSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasideTestsPharoDevelopmentSpec >> dependencies [
	^ { #'Seaside-Tests-Development' -> #('=3.1') .
		#'Seaside-Pharo-Development' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoDevelopmentSpec >> name [
	^ 'Seaside-Tests-Pharo-Development'
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoDevelopmentSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoDevelopmentSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoDevelopmentSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsPharoDevelopmentSpec >> version [
	^  '3.1.0'
]
