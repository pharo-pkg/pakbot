Class {
	#name : #SeasideGroupCoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideGroupCoreSpec >> dependencies [
	^ { #'Seaside-Core' -> #('=3.1') .
		#'Seaside-Canvas' -> #('=3.1') .
		#'Seaside-Session' -> #('=3.1') .
		#'Seaside-Component' -> #('=3.1') .
		#'Seaside-RenderLoop' -> #('=3.1') .
		#'Seaside-Tools-Core' -> #('=3.1') .
		#'Seaside-Flow' -> #('=3.1') .
		#'Seaside-Environment' -> #('=3.1') .
		#'Seaside-Widgets' -> #('=3.1') }

]

{ #category : #'as yet unclassified' }
SeasideGroupCoreSpec >> name [
	^ 'Seaside-Group-Core'
]

{ #category : #'as yet unclassified' }
SeasideGroupCoreSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideGroupCoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideGroupCoreSpec >> version [
	^  '3.1'
]
