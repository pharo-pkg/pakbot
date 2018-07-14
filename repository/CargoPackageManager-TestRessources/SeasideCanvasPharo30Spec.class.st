Class {
	#name : #SeasideCanvasPharo30Spec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasideCanvasPharo30Spec >> dependencies [
	"(package addDependency: 'Seaside-Core')
		addFixedVersionConstraint: package version;
		yourself."
	"(package addDependency: 'Seaside-Canvas')
		addFixedVersionConstraint: package version;
		yourself."
	^ #()
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo30Spec >> name [
	^ 'Seaside-Pharo-Canvas'
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo30Spec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #spec }
SeasideCanvasPharo30Spec >> provisions [
	^ #(#'Seaside-Canvas-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo30Spec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo30Spec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Pharo-Canvas' .
		#versionString -> 'pmm.4' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo30Spec >> srcArtifact [
	^ 'Seaside-Pharo-Canvas-pmm.4'
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo30Spec >> version [
	^  '3.1'
]
