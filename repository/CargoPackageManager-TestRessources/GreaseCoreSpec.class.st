Class {
	#name : #GreaseCoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #spec }
GreaseCoreSpec >> dependencies [
	"(package addDependency: 'Grease-Tests-Core')
		version: self package version;
		applyStrictUpdatePolicy;
		yourself.
"
	^ { #'Grease-Core-Platform' -> #('=1') }
]

{ #category : #spec }
GreaseCoreSpec >> name [
	^ 'Grease-Core'
]

{ #category : #'as yet unclassified' }
GreaseCoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Grease11/main')
]

{ #category : #'as yet unclassified' }
GreaseCoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Grease11/main' .
		#packageName -> 'Grease-Core' .
		#versionString -> 'JohanBrichau.83' } asDictionary
]

{ #category : #'as yet unclassified' }
GreaseCoreSpec >> srcArtifact [
	^ 'Grease-Core-JohanBrichau.83'
]

{ #category : #'as yet unclassified' }
GreaseCoreSpec >> testArtifact [
	^ 'Grease-Tests-Core-pmm.94'
]

{ #category : #'as yet unclassified' }
GreaseCoreSpec >> version [
	^  '1.1.5'
]
