Class {
	#name : #SeasideGroupTestsSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideGroupTestsSpec >> dependencies [
	^ { #'Core' -> #('=3.1') .
		#'Seaside-Tests-Core' -> #('=3.1') .
		#'Seaside-Tests-Canvas' -> #('=3.1') .
		#'Seaside-Tests-Session' -> #('=3.1') .
		#'Seaside-Tests-Component' -> #('=3.1') .
		#'Seaside-Tests-RenderLoop' -> #('=3.1') .
		#'Seaside-Tests-Environment' -> #('=3.1') .
		#'Seaside-Tests-Flow' -> #('=3.1') .
		#'Seaside-Tests-UTF8' -> #('=3.1') .
		#'Seaside-Tests-InternetExplorer' -> #('=3.1') .
		#'Seaside-Tests-Email' -> #('=3.1') .
		#'Seaside-Tests-Examples' -> #('=3.1') .
		#'RSS Tests' -> #('=3.1') .
		#'Welcome Tests' -> #('=3.1') . }
]

{ #category : #'as yet unclassified' }
SeasideGroupTestsSpec >> name [
	^ 'Seaside-Group-Tests'
]

{ #category : #'as yet unclassified' }
SeasideGroupTestsSpec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideGroupTestsSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideGroupTestsSpec >> version [
	^  '3.1.0'
]
