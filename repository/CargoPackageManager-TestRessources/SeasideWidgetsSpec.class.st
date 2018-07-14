Class {
	#name : #SeasideWidgetsSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideWidgetsSpec >> dependencies [
	^ { #'Seaside-Component' -> #('=3.1') .
		#'Seaside-Canvas' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideWidgetsSpec >> name [
	^ 'Seaside-Widgets'
]

{ #category : #'as yet unclassified' }
SeasideWidgetsSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideWidgetsSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Widgets' .
		#versionString -> 'pmm.33' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideWidgetsSpec >> srcArtifact [
	^ 'Seaside-Widgets-pmm.33'
]

{ #category : #'as yet unclassified' }
SeasideWidgetsSpec >> version [
	^  '3.1'
]
