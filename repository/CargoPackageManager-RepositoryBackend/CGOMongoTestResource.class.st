"
Test resource used to avoid populating mongo database too often.
"
Class {
	#name : #CGOMongoTestResource,
	#superclass : #TestResource,
	#instVars : [
		'repository'
	],
	#category : 'CargoPackageManager-RepositoryBackend'
}

{ #category : #running }
CGOMongoTestResource >> packageVersions [
	^ Seaside31TestResource current seaside31PackageVersions
]

{ #category : #running }
CGOMongoTestResource >> packages [
	^ Seaside31TestResource current seaside31Packages
]

{ #category : #accessing }
CGOMongoTestResource >> repository [
	^ repository
]

{ #category : #running }
CGOMongoTestResource >> setUp [
	super setUp.
	repository := CGOMongoRepository newWithDbName: 'PPM-Tests'.
	repository reset. "remove old data"
	self packageVersions do: #save.
	self packages do: #save
]
