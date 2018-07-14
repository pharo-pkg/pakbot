"
I handle REST requests for /packages/{1}

I return the list of versions available for the specified package.
"
Class {
	#name : #CGORepositoryPackageVersionListHandler,
	#superclass : #CGORepositoryRestCallHandler,
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #matching }
CGORepositoryPackageVersionListHandler class >> pattern [
	^ #( 'packages' '*')
]

{ #category : #public }
CGORepositoryPackageVersionListHandler >> get [
	| packageName versions |
	
	packageName := variables first asSymbol.
	[ versions := self packageRepository versionStringsOf: packageName ]
		on: CGOPackageVersionNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: versions
]
