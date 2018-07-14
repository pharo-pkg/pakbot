"
A PPMTestPackageRepository is used as a replacement for the database for test purposes.

"
Class {
	#name : #CGOTestPackageRepository,
	#superclass : #CGOPackageRepository,
	#instVars : [
		'packages'
	],
	#category : 'CargoPackageManager-Repository-Tests'
}

{ #category : #'versions fetching' }
CGOTestPackageRepository >> fetch: aPackageName version: aVersion [
	^ packages 
		detect: [ :package | (package packageName = aPackageName) and: [ package version = aVersion ]  ]
		ifNone: [ CGOPackageVersionNotFoundError signal ]
]

{ #category : #initialization }
CGOTestPackageRepository >> initialize [
	super initialize.
	packages := Seaside31TestResource current seaside31PackageVersions
]

{ #category : #'versions fetching' }
CGOTestPackageRepository >> latestVersionOfConcretePackage: aPackageName suitableForEnvironment: platformAttributes [
	^ packages 
		detect: [ :package | 
				(package packageName = aPackageName)
				and: [ (package platformRequirements difference: platformAttributes) isEmpty ] ]
		ifNone: [ CGOPackageNotFoundError signal ]
]

{ #category : #fetching }
CGOTestPackageRepository >> package: aString [ 
	^ (packages
		detect: [ :pkgVersion | pkgVersion packageName = aString ]
		ifNone: [ CGOPackageNotFoundError signal: 'Cannot find package ' , aString ]) package
]

{ #category : #accessing }
CGOTestPackageRepository >> packageNames [
	^ packages collect: [ :package | package packageName ]
]

{ #category : #'versions fetching' }
CGOTestPackageRepository >> packagesProviding: aName for: platformAttributes [
	(aName = #'foo-dbDriver')
		ifTrue: [ ((platformAttributes isEmpty) or: [ platformAttributes includes: 'pharo' ])
						ifTrue: [^ #('foo-mysql@1.0') ] ].
	CGOPackageNotFoundError signal
]

{ #category : #'versions fetching' }
CGOTestPackageRepository >> packagesProviding: aName version: aSemanticVersion forPlatformAttributes: platformAttributes [
	(aName endsWith: '-virtual')
		ifTrue: [ (aSemanticVersion major < 3)
					ifTrue: [ ((platformAttributes isEmpty) or: [ platformAttributes includes: 'pharo' ])
								ifTrue: [^ #('Grease-Core@1.1.5') ] ] ].
	CGOPackageVersionNotFoundError signal
]

{ #category : #'versions posting' }
CGOTestPackageRepository >> savePackageVersion: aPackageVersion [
	[ self fetch: aPackageVersion packageName version: aPackageVersion version.
	CGOPackageVersionAlreadyExistsError signal: aPackageVersion asString , ' already defined' ]
		on: CGOPackageNotFoundError, CGOPackageVersionNotFoundError
		do: [ packages := packages copyWith: aPackageVersion ]
]

{ #category : #'versions fetching' }
CGOTestPackageRepository >> versionStringsOf: aPackageName [
	^ packages 
		detect: [ :package | (package packageName = aPackageName) ]
		ifFound: [ #( '1.0.0' '1.1.5' '2.0.0') ]
		ifNone: [ CGOPackageVersionNotFoundError signal ] 
]
