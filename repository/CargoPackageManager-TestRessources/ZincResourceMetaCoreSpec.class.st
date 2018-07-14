Class {
	#name : #ZincResourceMetaCoreSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Adaptors'
}

{ #category : #'as yet unclassified' }
ZincResourceMetaCoreSpec >> name [
	^ 'Zinc-Resource-Meta-Core'
]

{ #category : #'as yet unclassified' }
ZincResourceMetaCoreSpec >> repositories [
	^ #('http://mc.stfx.eu/ZincHTTPComponents')
]

{ #category : #'as yet unclassified' }
ZincResourceMetaCoreSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://mc.stfx.eu/ZincHTTPComponents' .
		#packageName -> 'Zinc-Resource-Meta-Core' .
		#versionString -> 'SvenVanCaekenberghe.30' } asDictionary
]

{ #category : #'as yet unclassified' }
ZincResourceMetaCoreSpec >> srcArtifact [
	^ 'Zinc-Resource-Meta-Core-SvenVanCaekenberghe.30'
]

{ #category : #'as yet unclassified' }
ZincResourceMetaCoreSpec >> version [
	^  '2.4.8'
]
