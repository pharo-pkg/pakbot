"
I represent a repository containing source code hosted on a Monticello SCM.

	self example inspect
"
Class {
	#name : #CGOMonticelloRepository,
	#superclass : #PBSourceRepository,
	#category : #'CargoPackageManager-Loading'
}

{ #category : #example }
CGOMonticelloRepository class >> example [
	^ self
			repositoryUrl: 'http://smalltalkhub.com/mc/demarey/CargoPackageManager/main'
]

{ #category : #'instance creation' }
CGOMonticelloRepository class >> repositoryUrl: aStringOrUrl [
	^ self basicNew 
		initializeWithRepositoryUrl: aStringOrUrl;
		yourself
]

{ #category : #initialization }
CGOMonticelloRepository >> initializeWithRepositoryUrl: aStringOrUrl [
	repositoryUrl := aStringOrUrl
]

{ #category : #accessing }
CGOMonticelloRepository >> mcRepository [
	^ MCRepository fromUrl: repositoryUrl
]

{ #category : #loading }
CGOMonticelloRepository >> mcVersionFor: anMCVersionReferenceString [
	^ self mcRepository
		versionFrom: anMCVersionReferenceString
]

{ #category : #querying }
CGOMonticelloRepository >> sourcePackageVersionClass [
	^ CGOMonticelloHostedPackageVersion 
]
