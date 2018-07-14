Class {
	#name : #SeasideTestsCoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsCoreSpec >> dependencies [
	^ { #'Seaside-Core' -> #('=3.1') .
		#'Grease Core Tests' -> #('=3.1') .
		#'Seaside-Tests-Core-Platform' -> #('=3.1') }

"	(package addDependency: 'Seaside-Tests-Pharo20-Core')
		platform: #pharo3;
		yourself."
]

{ #category : #'as yet unclassified' }
SeasideTestsCoreSpec >> name [
	^ 'Seaside-Tests-Core'
]

{ #category : #'as yet unclassified' }
SeasideTestsCoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsCoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsCoreSpec >> version [
	^  '3.1.0'
]
