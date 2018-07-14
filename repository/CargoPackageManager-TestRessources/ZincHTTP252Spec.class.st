Class {
	#name : #ZincHTTP252Spec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Adaptors'
}

{ #category : #'as yet unclassified' }
ZincHTTP252Spec >> name [
	^ 'Zinc-HTTP'
]

{ #category : #'as yet unclassified' }
ZincHTTP252Spec >> repositories [
	^ #('http://mc.stfx.eu/ZincHTTPComponents')
]

{ #category : #'as yet unclassified' }
ZincHTTP252Spec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://mc.stfx.eu/ZincHTTPComponents' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
ZincHTTP252Spec >> version [
	^  '2.5.2'
]
