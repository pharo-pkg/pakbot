Class {
	#name : #SeasideComponentSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideComponentSpec >> dependencies [
	^ { #'Seaside-Core' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideComponentSpec >> name [
	^ 'Seaside-Component'
]

{ #category : #'as yet unclassified' }
SeasideComponentSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideComponentSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Component' .
		#versionString -> 'pmm.101' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideComponentSpec >> srcArtifact [
	^ 'Seaside-Component-pmm.101'
]

{ #category : #'as yet unclassified' }
SeasideComponentSpec >> version [
	^  '3.1'
]
