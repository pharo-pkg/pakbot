Class {
	#name : #SeasideSessionSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideSessionSpec >> dependencies [
	^ { #'Seaside-Component' -> #('=3.1') .
		#'Seaside-Canvas' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideSessionSpec >> name [
	^ 'Seaside-Session'
]

{ #category : #'as yet unclassified' }
SeasideSessionSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideSessionSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Session' .
		#versionString -> 'pmm.168' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideSessionSpec >> srcArtifact [
	^ 'Seaside-Session-pmm.168'
]

{ #category : #'as yet unclassified' }
SeasideSessionSpec >> version [
	^  '3.1'
]
