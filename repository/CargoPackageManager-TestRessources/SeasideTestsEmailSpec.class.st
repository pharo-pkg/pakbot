Class {
	#name : #SeasideTestsEmailSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsEmailSpec >> dependencies [
	^ { #'Seaside-Email' -> #('=3.1') .
		#'Seaside-Tests-Core' -> #('=3.1') .
		#'Seaside-Tests-Email-Platform' -> #('=3.1') }

"	(package addDependency: 'Seaside-Tests-Pharo-Email')
		platform: #squeakCommon;
		yourself."
]

{ #category : #'as yet unclassified' }
SeasideTestsEmailSpec >> name [
	^ 'Seaside-Tests-Email'
]

{ #category : #'as yet unclassified' }
SeasideTestsEmailSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsEmailSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsEmailSpec >> version [
	^  '3.1.0'
]
