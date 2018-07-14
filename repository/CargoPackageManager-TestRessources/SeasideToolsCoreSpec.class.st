Class {
	#name : #SeasideToolsCoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #spec }
SeasideToolsCoreSpec >> dependencies [
	^ { #'Seaside-Core' -> #('=3.1') .
		#'Seaside-Component' -> #('=3.1') .
		#'Seaside-RenderLoop' -> #('=3.1') .
		#'Seaside-Session' -> #('=3.1') .
		#'Seaside-Tools-Core-Platform' -> #('=1') }

	"(package addDependency: 'Seaside-Pharo-Tools-Spec')
		addFixedVersionConstraint: package version;
		platform: #pharo3
		yourself."


]

{ #category : #'as yet unclassified' }
SeasideToolsCoreSpec >> name [
	^ 'Seaside-Tools-Core'
]

{ #category : #'as yet unclassified' }
SeasideToolsCoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideToolsCoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'Seaside-Tools-Core' .
		#versionString -> 'pmm.23' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideToolsCoreSpec >> srcArtifact [
	^ 'Seaside-Tools-Core-pmm.23'
]

{ #category : #'as yet unclassified' }
SeasideToolsCoreSpec >> version [
	^  '3.1'
]
