"
A PackageGroup represents a set of artifacts to load together.
"
Class {
	#name : #PBLoadGroup,
	#superclass : #Object,
	#instVars : [
		'name',
		'loadableUnits'
	],
	#category : #'CargoPackageManager-Minimal-Loader'
}

{ #category : #'instance creation' }
PBLoadGroup class >> newWithAll: aListOfPackageVersionReferenceStrings [
	^ self new 
		intializeWithPackageVersions: aListOfPackageVersionReferenceStrings;
		yourself
		
]

{ #category : #comparing }
PBLoadGroup >> = anotherObject [
	self species = anotherObject species
		ifFalse: [ ^ false ].
		
	^ self name = anotherObject name
		and: [ self loadableUnits = anotherObject loadableUnits ]
]

{ #category : #testing }
PBLoadGroup >> anySatisfy: aBlock [
	
	^ loadableUnits anySatisfy: aBlock
]

{ #category : #private }
PBLoadGroup >> computeName [
	name := ', ' join: (loadableUnits collect: #name)
]

{ #category : #loading }
PBLoadGroup >> fetchInto: aMCRepository [
	^ self mcVersions
		do: [ :version | aMCRepository storeVersion: version ];
		yourself
]

{ #category : #testing }
PBLoadGroup >> includes: aLoadableUnit [ 

	^ loadableUnits 
		detect: [ :each | each resolvedProjectVersion = aLoadableUnit ]   
		ifFound: [ true ]
		ifNone: [ false ]
]

{ #category : #initialization }
PBLoadGroup >> intializeWithPackageVersions: aListOfPackageVersions [
	loadableUnits := aListOfPackageVersions.
	self computeName
]

{ #category : #loading }
PBLoadGroup >> load [

	self loadableUnits do: [ :aLoadableUnit | aLoadableUnit basicLoad ].
]

{ #category : #accessing }
PBLoadGroup >> loadableUnits [
	^ loadableUnits
]

{ #category : #loading }
PBLoadGroup >> mcVersionFor: aPackageVersion [
	^ aPackageVersion repository mcVersionFor: aPackageVersion
]

{ #category : #loading }
PBLoadGroup >> mcVersions [
	^ self packageVersions
		reject: #isAssembly "Assemblies are not associated to a code artefact, so nothing to load ..."
		thenCollect: [ :pkgVersion | self mcVersionFor: pkgVersion ]
]

{ #category : #accessing }
PBLoadGroup >> name [
	^ name
]

{ #category : #accessing }
PBLoadGroup >> packageVersions [
	^ self loadableUnits
]

{ #category : #printing }
PBLoadGroup >> printOn: aStream [
	aStream
		<< self class name
		<< '('
		<< name
		<< '::'
		<< loadableUnits asString
		<< ')'
]
