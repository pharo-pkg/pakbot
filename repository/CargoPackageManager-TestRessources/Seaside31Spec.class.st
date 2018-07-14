Class {
	#name : #Seaside31Spec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
Seaside31Spec >> dependencies [
	^ { #'Seaside-Group-Default' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
Seaside31Spec >> description [
	^ 'Seaside 3 description'
]

{ #category : #'as yet unclassified' }
Seaside31Spec >> name [
	^ 'Seaside31'
]

{ #category : #'as yet unclassified' }
Seaside31Spec >> repositories [
	"classes := (RPackage organizer packageNamed: 'PackagesManager') classesForClassTag: #'PackagesManager-SeasideDescCommon'.
classes
	select: [ :class | class name beginsWith: 'Seaside' ]
	thenDo: [  :class | class compile: 'repositories
	package addRepository: ''http://smalltalkhub.com/mc/Seaside/Seaside31/main'''  ]"

	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
Seaside31Spec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
Seaside31Spec >> version [
	^  '3.1'
]
