Class {
	#name : #ZincCharacterEncodingSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Adaptors'
}

{ #category : #'as yet unclassified' }
ZincCharacterEncodingSpec >> name [
	^ 'Zinc-Character-Encoding'
]

{ #category : #'as yet unclassified' }
ZincCharacterEncodingSpec >> repositories [
	^ #('http://mc.stfx.eu/ZincHTTPComponents')
]

{ #category : #'as yet unclassified' }
ZincCharacterEncodingSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://mc.stfx.eu/ZincHTTPComponents' .
		#packageName -> 'Zinc-Character-Encoding-Core' .
		#versionString -> 'SvenVanCaekenberghe.28' } asDictionary
]

{ #category : #'as yet unclassified' }
ZincCharacterEncodingSpec >> srcArtifact [
	^ 'Zinc-Character-Encoding-Core-SvenVanCaekenberghe.28'
]

{ #category : #'as yet unclassified' }
ZincCharacterEncodingSpec >> version [
	^  '2.4.8'
]
