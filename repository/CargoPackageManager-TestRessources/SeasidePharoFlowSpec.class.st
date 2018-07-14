Class {
	#name : #SeasidePharoFlowSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #spec }
SeasidePharoFlowSpec >> dependencies [
	"(package addDependency: 'Seaside-Flow')
		addFixedVersionConstraint: package version;
		yourself."
	^ { #'Seaside-Continuation-Platform' -> #('=1') }
]

{ #category : #'as yet unclassified' }
SeasidePharoFlowSpec >> name [
	^ 'Seaside-Pharo-Flow'
]

{ #category : #'as yet unclassified' }
SeasidePharoFlowSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #spec }
SeasidePharoFlowSpec >> provisions [
	^ #(#'Seaside-Flow-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasidePharoFlowSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasidePharoFlowSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Pharo-Flow' .
		#versionString -> 'lr.5' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasidePharoFlowSpec >> srcArtifact [
	^ 'Seaside-Pharo-Flow-lr.5'
]

{ #category : #'as yet unclassified' }
SeasidePharoFlowSpec >> version [
	^  '3.1'
]
