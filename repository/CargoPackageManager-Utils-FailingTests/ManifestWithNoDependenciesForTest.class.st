Class {
	#name : #ManifestWithNoDependenciesForTest,
	#superclass : #PackageManifest,
	#category : 'CargoPackageManager-Utils-FailingTests'
}

{ #category : #'meta-data' }
ManifestWithNoDependenciesForTest class >> description [
	^ 'I represent the manifest of a fake package. I''m used for test purposes.'
]

{ #category : #'meta-data' }
ManifestWithNoDependenciesForTest class >> packageName [
	^ #'NoDependency'
]

{ #category : #'meta-data' }
ManifestWithNoDependenciesForTest class >> repositories [
	^ #('http://smalltalkhub.com/mc/Pharo/Pharo60/main')
]
