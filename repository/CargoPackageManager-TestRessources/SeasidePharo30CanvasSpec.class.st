Class {
	#name : #SeasidePharo30CanvasSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasidePharo30CanvasSpec >> dependencies [
	"(package addDependency: 'Seaside-Core')
		addFixedVersionConstraint: package version;
		yourself."
	"(package addDependency: 'Seaside-Canvas')
		addFixedVersionConstraint: package version;
		yourself."
	^ #()
]

{ #category : #spec }
SeasidePharo30CanvasSpec >> name [
	^ 'Seaside-Canvas-Pharo'
]

{ #category : #'as yet unclassified' }
SeasidePharo30CanvasSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #spec }
SeasidePharo30CanvasSpec >> provisions [
	^ #(#'Seaside-Canvas-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasidePharo30CanvasSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasidePharo30CanvasSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Pharo-Canvas' .
		#versionString -> 'pmm.4' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasidePharo30CanvasSpec >> srcArtifact [
	^ 'Seaside-Pharo-Canvas-pmm.4'
]

{ #category : #'as yet unclassified' }
SeasidePharo30CanvasSpec >> version [
	^  '1.2'
]
