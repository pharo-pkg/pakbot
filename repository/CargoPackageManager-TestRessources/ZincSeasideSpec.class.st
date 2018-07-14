Class {
	#name : #ZincSeasideSpec,
	#superclass : #Seaside31PackageSpec,
	#category : 'CargoPackageManager-TestRessources-SeasideDesc-Adaptors'
}

{ #category : #'as yet unclassified' }
ZincSeasideSpec >> dependencies [
	^ { #'Zinc-HTTP' -> #('=2.4.8') .
		#'Seaside-Core' -> #('=3.1') }
]

{ #category : #'as yet unclassified' }
ZincSeasideSpec >> name [
	^ 'Zinc-Seaside'
]

{ #category : #'as yet unclassified' }
ZincSeasideSpec >> repositories [
	^ #('http://mc.stfx.eu/ZincHTTPComponents')
]

{ #category : #'as yet unclassified' }
ZincSeasideSpec >> sourcePackageVersion [
	^ { #backend -> #monticello .
		#repositoryUrl -> 'http://mc.stfx.eu/ZincHTTPComponents' .
		#packageName -> 'Zinc-Seaside' .
		#versionString -> 'SvenVanCaekenberghe.40' } asDictionary
]

{ #category : #'as yet unclassified' }
ZincSeasideSpec >> srcArtifact [
	^ 'Zinc-Seaside-SvenVanCaekenberghe.40'
]

{ #category : #'as yet unclassified' }
ZincSeasideSpec >> version [
	^  '3.1.0'
]
