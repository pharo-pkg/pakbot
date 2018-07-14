Class {
	#name : #SeasidePharoToolsSpecSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasidePharoToolsSpecSpec >> dependencies [
	"(package addDependency: 'Seaside-Tools-Core')
		addFixedVersionConstraint: package version;
		yourself."
	^ #()
]

{ #category : #'as yet unclassified' }
SeasidePharoToolsSpecSpec >> name [
	^ 'Seaside-Pharo-Tools-Spec'
]

{ #category : #'as yet unclassified' }
SeasidePharoToolsSpecSpec >> platformRequirements [
	^ #(#'pharo4.x')
]

{ #category : #spec }
SeasidePharoToolsSpecSpec >> provisions [
	^ #(#'Seaside-Tools-Core-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasidePharoToolsSpecSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasidePharoToolsSpecSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Pharo-Tools-Spec' .
		#versionString -> 'pmm.9' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasidePharoToolsSpecSpec >> srcArtifact [
	^ 'Seaside-Pharo-Tools-Spec-pmm.9'
]

{ #category : #'as yet unclassified' }
SeasidePharoToolsSpecSpec >> version [
	^  '3.1'
]
