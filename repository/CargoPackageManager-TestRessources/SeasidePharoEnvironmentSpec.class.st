Class {
	#name : #SeasidePharoEnvironmentSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasidePharoEnvironmentSpec >> dependencies [
	"(package addDependency: 'Seaside-Environment')
		addFixedVersionConstraint: package version;
		yourself.
	(package addDependency: 'Seaside-Core')
		addFixedVersionConstraint: package version;
		yourself.
	(package addDependency: 'Seaside-Canvas')
		addFixedVersionConstraint: package version;
		yourself."
	^ #()
]

{ #category : #'as yet unclassified' }
SeasidePharoEnvironmentSpec >> name [
	^ 'Seaside-Pharo-Environment'
]

{ #category : #'as yet unclassified' }
SeasidePharoEnvironmentSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #spec }
SeasidePharoEnvironmentSpec >> provisions [
	^ #(#'Seaside-Environment-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasidePharoEnvironmentSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasidePharoEnvironmentSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Pharo-Environment' .
		#versionString -> 'lr.6' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasidePharoEnvironmentSpec >> srcArtifact [
	^ 'Seaside-Pharo-Environment-lr.6'
]

{ #category : #'as yet unclassified' }
SeasidePharoEnvironmentSpec >> version [
	^  '3.1'
]
