Class {
	#name : #SeasideTestsInternetExplorerSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideTestsInternetExplorerSpec >> dependencies [
	^ { #'Seaside-InternetExplorer' -> #('=3.1') .
		#'Seaside-Tests-Core' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideTestsInternetExplorerSpec >> name [
	^ 'Seaside-Tests-InternetExplorer'
]

{ #category : #'as yet unclassified' }
SeasideTestsInternetExplorerSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideTestsInternetExplorerSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideTestsInternetExplorerSpec >> version [
	^  '3.1.0'
]
