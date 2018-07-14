Class {
	#name : #ZincHTTPSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Adaptors'
}

{ #category : #'as yet unclassified' }
ZincHTTPSpec >> dependencies [
	^ { #'Zinc-Character-Encoding' -> #('=2.4.8') .
		#'Zinc-Resource-Meta-Core' -> #('=2.4.8') }
]

{ #category : #'as yet unclassified' }
ZincHTTPSpec >> name [
	^ 'Zinc-HTTP'
]

{ #category : #'as yet unclassified' }
ZincHTTPSpec >> repositories [
	^ #('http://mc.stfx.eu/ZincHTTPComponents')
]

{ #category : #'as yet unclassified' }
ZincHTTPSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://mc.stfx.eu/ZincHTTPComponents' .
		#packageName -> 'no-file-specified' .
		#versionString -> 'JohnDoe.0' } asDictionary
]

{ #category : #'as yet unclassified' }
ZincHTTPSpec >> version [
	^  '2.4.8'
]
