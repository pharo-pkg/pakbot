Class {
	#name : #SeasidePharo20ToolsWebSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Pharo'
}

{ #category : #'as yet unclassified' }
SeasidePharo20ToolsWebSpec >> dependencies [
	"(package addDependency: 'Seaside-Tools-Web')
		addFixedVersionConstraint: package version;
		yourself.
	(package addDependency: 'Seaside-Core')
		addFixedVersionConstraint: package version;
		yourself.
	(package addDependency: 'Seaside-Canvas')
		addFixedVersionConstraint: package version;
		yourself.
"
	^ #()
]

{ #category : #'as yet unclassified' }
SeasidePharo20ToolsWebSpec >> name [
	^ 'Seaside-Pharo20-Tools-Web'
]

{ #category : #'as yet unclassified' }
SeasidePharo20ToolsWebSpec >> platformRequirements [
	^ #(#'pharo4.x')
]

{ #category : #spec }
SeasidePharo20ToolsWebSpec >> provisions [
	^ #(#'Seaside-Tools-Web-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasidePharo20ToolsWebSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasidePharo20ToolsWebSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Pharo20-Tools-Web' .
		#versionString -> 'JohanBrichau.3' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasidePharo20ToolsWebSpec >> srcArtifact [
	^ 'Seaside-Pharo20-Tools-Web-JohanBrichau.3'
]

{ #category : #'as yet unclassified' }
SeasidePharo20ToolsWebSpec >> version [
	^  '3.1'
]
