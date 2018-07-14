Class {
	#name : #ManifestOneDependency,
	#superclass : #PackageManifest,
	#category : 'CargoPackageManager-Utils-FailingTests'
}

{ #category : #'meta-data' }
ManifestOneDependency class >> dependencies [
	^ #(#NoDependency)
]

{ #category : #'meta-data' }
ManifestOneDependency class >> description [
	^ 'I represent the manifest of a fake package. I''m used for test purposes.'
]

{ #category : #'meta-data' }
ManifestOneDependency class >> packageName [
	^ #'OneDependency'
]

{ #category : #'meta-data' }
ManifestOneDependency class >> repositories [
	^ #('http://smalltalkhub.com/mc/Pharo/Pharo60/main')
]

{ #category : #'meta-data' }
ManifestOneDependency class >> version [
	^ '1.0'
]
