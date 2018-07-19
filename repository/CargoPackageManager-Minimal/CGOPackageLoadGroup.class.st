"
A PackageGroup represents a set of artifacts to load together.
"
Class {
	#name : #CGOPackageLoadGroup,
	#superclass : #Object,
	#instVars : [
		'name',
		'loadableUnits'
	],
	#category : 'CargoPackageManager-Minimal-Loader'
}

{ #category : #'instance creation' }
CGOPackageLoadGroup class >> newWithAll: aListOfPackageVersionReferenceStrings [
	^ self new 
		intializeWithPackageVersions: aListOfPackageVersionReferenceStrings;
		yourself
		
]

{ #category : #private }
CGOPackageLoadGroup >> computeName [
	name := ', ' join: (loadableUnits collect: #name)
]

{ #category : #loading }
CGOPackageLoadGroup >> fetchInto: aMCRepository [
	^ self mcVersions
		do: [ :version | aMCRepository storeVersion: version ];
		yourself
]

{ #category : #testing }
CGOPackageLoadGroup >> includes: aLoadableUnit [ 

	^ loadableUnits includes: aLoadableUnit
]

{ #category : #initialization }
CGOPackageLoadGroup >> intializeWithPackageVersions: aListOfPackageVersions [
	loadableUnits := aListOfPackageVersions.
	self computeName
]

{ #category : #loading }
CGOPackageLoadGroup >> load [

	self loadableUnits do: [ :aLoadableUnit | aLoadableUnit basicLoad ]
]

{ #category : #accessing }
CGOPackageLoadGroup >> loadableUnits [
	^ loadableUnits
]

{ #category : #loading }
CGOPackageLoadGroup >> mcVersionFor: aPackageVersion [
	^ aPackageVersion repository mcVersionFor: aPackageVersion
]

{ #category : #loading }
CGOPackageLoadGroup >> mcVersions [
	^ self packageVersions
		reject: #isAssembly "Assemblies are not associated to a code artefact, so nothing to load ..."
		thenCollect: [ :pkgVersion | self mcVersionFor: pkgVersion ]
]

{ #category : #accessing }
CGOPackageLoadGroup >> name [
	^ name
]

{ #category : #accessing }
CGOPackageLoadGroup >> packageVersions [
	^ self loadableUnits
]

{ #category : #printing }
CGOPackageLoadGroup >> printOn: aStream [
	aStream
		<< self class name
		<< '('
		<< name
		<< '::'
		<< loadableUnits asString
		<< ')'
]

{ #category : #loading }
CGOPackageLoadGroup >> registerLoadedPackages [
	self packageVersions
		do: [ :pkgVersion | 
			pkgVersion versionLoaded.
			CGOPackageRegistry default register: pkgVersion ]
]
