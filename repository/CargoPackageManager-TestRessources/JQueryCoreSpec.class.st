Class {
	#name : #JQueryCoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-JsJquery'
}

{ #category : #'as yet unclassified' }
JQueryCoreSpec >> dependencies [
	^ { #'Javascript-Core' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
JQueryCoreSpec >> name [
	^ 'JQuery-Core'
]

{ #category : #'as yet unclassified' }
JQueryCoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
JQueryCoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'JQuery-Core' .
		#versionString -> 'pmm.128' } asDictionary
]

{ #category : #'as yet unclassified' }
JQueryCoreSpec >> srcArtifact [
	^ 'JQuery-Core-pmm.128'
]

{ #category : #'as yet unclassified' }
JQueryCoreSpec >> version [
	^  '3.1'
]
