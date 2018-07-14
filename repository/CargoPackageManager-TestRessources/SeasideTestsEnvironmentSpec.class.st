Class {
	#name : #SeasideTestsEnvironmentSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsEnvironmentSpec >> dependencies [
	^ { #'Seaside-Environment' -> #('=3.1') .
		#'Seaside-Tests-Component' -> #('=3.1') .
		#'Seaside-Tests-RenderLoop' -> #('=3.1') .
		#'Seaside-Tests-Session' -> #('=3.1') .
		#'Seaside-Tests-Canvas' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsEnvironmentSpec >> name [
	^ 'Seaside-Tests-Environment'
]

{ #category : #'as yet unclassified' }
SeasideTestsEnvironmentSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsEnvironmentSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsEnvironmentSpec >> version [
	^  '3.1.0'
]
