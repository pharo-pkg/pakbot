Class {
	#name : #SeasideTestsDevelopmentSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsDevelopmentSpec >> dependencies [
	^ { #'Seaside-Development' -> #('=3.1') .
		#'Seaside-Tests-Tools-Web' -> #('=3.1') .
		#'Seaside-Tests-Environment' -> #('=3.1') .
		#'Seaside-Tests-Development-Platform' -> #('=3.1') }

	"	(package addDependency: 'Seaside-Tests-Pharo-Development')
		platform: #squeakCommon;
		yourself."
]

{ #category : #'as yet unclassified' }
SeasideTestsDevelopmentSpec >> name [
	^ 'Seaside-Tests-Development'
]

{ #category : #'as yet unclassified' }
SeasideTestsDevelopmentSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsDevelopmentSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsDevelopmentSpec >> version [
	^  '3.1.0'
]
