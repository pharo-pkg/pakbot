Class {
	#name : #SeasideTestsUTF8Spec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsUTF8Spec >> dependencies [
	^ { #'Seaside-Tests-Core' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsUTF8Spec >> name [
	^ 'Seaside-Tests-UTF8'
]

{ #category : #'as yet unclassified' }
SeasideTestsUTF8Spec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsUTF8Spec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsUTF8Spec >> version [
	^  '3.1.0'
]
