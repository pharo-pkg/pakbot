Class {
	#name : #SeasideToolsWebSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #spec }
SeasideToolsWebSpec >> dependencies [
	^ { #'Seaside-Tools-Core' -> #('=3.1') .
		#'Seaside-RenderLoop' -> #('=3.1') .
		#'Seaside-Widgets' -> #('=3.1') .
		#'Seaside-Tools-Web-Platform' -> #('=1') }

	"(package addDependency: 'Seaside-Pharo20-Tools-Web')
		platform: #pharo3;
		yourself."
]

{ #category : #'as yet unclassified' }
SeasideToolsWebSpec >> name [
	^ 'Seaside-Tools-Web'
]

{ #category : #'as yet unclassified' }
SeasideToolsWebSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideToolsWebSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Tools-Web' .
		#versionString -> 'pmm.118' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideToolsWebSpec >> srcArtifact [
	^ 'Seaside-Tools-Web-pmm.118'
]

{ #category : #'as yet unclassified' }
SeasideToolsWebSpec >> version [
	^  '3.1'
]
