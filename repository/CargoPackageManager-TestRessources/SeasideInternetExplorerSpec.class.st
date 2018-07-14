Class {
	#name : #SeasideInternetExplorerSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideInternetExplorerSpec >> dependencies [
	^ { #'Seaside-Core' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideInternetExplorerSpec >> name [
	^ 'Seaside-InternetExplorer'
]

{ #category : #'as yet unclassified' }
SeasideInternetExplorerSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideInternetExplorerSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideInternetExplorerSpec >> version [
	^  '3.1.0'
]
