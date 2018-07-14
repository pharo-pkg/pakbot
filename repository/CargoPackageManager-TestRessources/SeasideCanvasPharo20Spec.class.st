Class {
	#name : #SeasideCanvasPharo20Spec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Common'
}

{ #category : #'as yet unclassified' }
SeasideCanvasPharo20Spec >> dependencies [
	^ { #'Seaside-Core' -> #('=3.1') .
		 #'Seaside-Canvas' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo20Spec >> name [
	^ 'Seaside-Canvas-Pharo20'
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo20Spec >> platformRequirements [
	^ #(#'pharo2.x')
]

{ #category : #spec }
SeasideCanvasPharo20Spec >> provisions [
	^ #(#'Seaside-Canvas-Platform@1.0')
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo20Spec >> repositories [
	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo20Spec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://smalltalkhub.com/mc/Seaside/Seaside31/main' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
SeasideCanvasPharo20Spec >> version [
	^  '3.1'
]
