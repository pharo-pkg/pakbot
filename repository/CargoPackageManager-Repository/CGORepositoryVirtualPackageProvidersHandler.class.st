"
I give the list of concrete packages providing the specified virtual package.
"
Class {
	#name : #CGORepositoryVirtualPackageProvidersHandler,
	#superclass : #CGORepositoryRestCallHandler,
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #matching }
CGORepositoryVirtualPackageProvidersHandler class >> pattern [
	^ #( 'virtualpackages' '*')
]

{ #category : #public }
CGORepositoryVirtualPackageProvidersHandler >> get [
	| virtualPackageName packages platformAttributes |
	
	virtualPackageName := variables first asSymbol.
	platformAttributes := self platformValues.
	[ packages := self packageRepository 
							packagesProviding: virtualPackageName
							for: platformAttributes ]
		on: CGOPackageNotFoundError
		do: [ ^ self notFound ].
	^ self stonResponse: packages
]
