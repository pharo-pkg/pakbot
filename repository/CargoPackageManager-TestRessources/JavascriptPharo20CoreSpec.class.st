Class {
	#name : #JavascriptPharo20CoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-JsJquery'
}

{ #category : #'as yet unclassified' }
JavascriptPharo20CoreSpec >> dependencies [
	"(package addDependency: 'Javascript-Core')
		addFixedVersionConstraint: package version;
		yourself.
	(package addDependency: 'Seaside-Pharo20-Core')
		addFixedVersionConstraint: package version;
		yourself.
"
	^ #()
]

{ #category : #'as yet unclassified' }
JavascriptPharo20CoreSpec >> name [
	^ 'Javascript-Pharo20-Core'
]

{ #category : #'as yet unclassified' }
JavascriptPharo20CoreSpec >> platformRequirements [
	^ #(#squeakCommon)
]

{ #category : #spec }
JavascriptPharo20CoreSpec >> provisions [
	^ #(#'Javascript-Core-Platform@1')
]

{ #category : #'as yet unclassified' }
JavascriptPharo20CoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
JavascriptPharo20CoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Javascript-Pharo20-Core' .
		#versionString -> 'JohanBrichau.4' } asDictionary
]

{ #category : #'as yet unclassified' }
JavascriptPharo20CoreSpec >> srcArtifact [
	^ 'Javascript-Pharo20-Core-JohanBrichau.4'
]

{ #category : #versions }
JavascriptPharo20CoreSpec >> version [
	^  '3.1'
]
