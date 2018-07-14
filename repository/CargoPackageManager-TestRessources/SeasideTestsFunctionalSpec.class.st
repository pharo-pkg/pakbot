Class {
	#name : #SeasideTestsFunctionalSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsFunctionalSpec >> dependencies [
	^ { #'Seaside-Environment' -> #('=3.1') .
		#'Seaside-Tests-Core' -> #('=3.1') .
		#'Seaside-Widgets' -> #('=3.1') .
		#'Seaside-Tests-Functional-Platform' -> #('=3.1') }

"	(package addDependency: 'Seaside-Tests-Pharo-Functional')
		platform: #squeakCommon;
		yourself."
]

{ #category : #'as yet unclassified' }
SeasideTestsFunctionalSpec >> name [
	^ 'Seaside-Tests-Functional'
]

{ #category : #'as yet unclassified' }
SeasideTestsFunctionalSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsFunctionalSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsFunctionalSpec >> version [
	^  '3.1.0'
]
