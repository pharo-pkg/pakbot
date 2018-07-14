Class {
	#name : #SeasidePharoWelcomeSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Welcome'
}

{ #category : #'as yet unclassified' }
SeasidePharoWelcomeSpec >> dependencies [
"	(package addDependency: 'Seaside-Welcome')
		addFixedVersionConstraint: package version;
		yourself.
"
	^ #()
]

{ #category : #'as yet unclassified' }
SeasidePharoWelcomeSpec >> name [
	^ 'Seaside-Pharo-Welcome'
]

{ #category : #'as yet unclassified' }
SeasidePharoWelcomeSpec >> platformRequirements [
	^ #(#'pharo4.x')
]

{ #category : #spec }
SeasidePharoWelcomeSpec >> provisions [
	^ #(#'Seaside-Welcome-Platform@1')
]

{ #category : #'as yet unclassified' }
SeasidePharoWelcomeSpec >> srcArtifact [
	^ 'Seaside-Pharo-Welcome-NickAger.2'
]

{ #category : #'as yet unclassified' }
SeasidePharoWelcomeSpec >> version [
	^  '3.1'
]
