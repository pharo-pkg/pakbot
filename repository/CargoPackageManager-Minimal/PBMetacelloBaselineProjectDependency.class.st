"
I represent a dependency to a project managed by a Metacello BaselineOf.
"
Class {
	#name : #PBMetacelloBaselineProjectDependency,
	#superclass : #PBMetacelloProjectDependency,
	#category : #'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #example }
PBMetacelloBaselineProjectDependency class >> example [
	^ self
		name: 'PakbotTestExample'
		repositoryUrl: 'ssh://git@github.com/pharo-pkg/PakbotTestExample.git'
		version: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'
]

{ #category : #'instance-creation' }
PBMetacelloBaselineProjectDependency class >> fromMetacelloSpec: aMetacelloSpec [

	| metacelloUrl repoSpec |
	metacelloUrl := aMetacelloSpec repositories map values first description.
	repoSpec := PBMetacelloRepositorySpec url: metacelloUrl.
	
	"No version specified? We cannot compare versions so we build the dependency from the info we have to further handle a conflict if needed"
	^ self
		name: aMetacelloSpec name
		repositoryUrl: repoSpec
		version: repoSpec version
]

{ #category : #accessing }
PBMetacelloBaselineProjectDependency class >> iconName [
	^ #komitterSmalltalkhubRemote
]

{ #category : #accessing }
PBMetacelloBaselineProjectDependency class >> projectClass [
	^ PBMetacelloBaselineProject 
]

{ #category : #'ston-core' }
PBMetacelloBaselineProjectDependency class >> stonName [
	^ #MetacelloBaselineProject
]

{ #category : #converting }
PBMetacelloBaselineProjectDependency >> asPakbotProjectDependency [

	^ (PBPakbotProjectDependency
		named: self name
		repositoryUrl: self repositoryUrl
		version: self version)
			project: self project;
			loads: packagesToLoad copy;
			platformRequirements: platformRequirements copy;
			yourself
]

{ #category : #accessing }
PBMetacelloBaselineProjectDependency >> fullVersionString [

	^ self version, ' (Baseline from ' , self icebergUrl , ')'
]

{ #category : #'querying - installed' }
PBMetacelloBaselineProjectDependency >> icebergUrl [
	^ url asGitUrl scpUrl
]

{ #category : #'querying - installed' }
PBMetacelloBaselineProjectDependency >> isInstalledInMetacello [
	| baseline |
	
	"If a baseline is already installed from a configuration, we consider it as a conflict
	even if, in some cases, it could refer to the same version."
	baseline := self metacelloProjectRegistry baselineRegistry 
		at: #BaselineOf , name 
		ifAbsent: [ ^ false ].
		
	^ (self isSameVersionAs: baseline currentVersionString)
		and: [ baseline loadedInImage 
			and: [ baseline baselineProjectSpec loads isEmptyOrNil ] ]
]

{ #category : #testing }
PBMetacelloBaselineProjectDependency >> isMetacelloConfiguration [
	^ false
]

{ #category : #'querying - installed' }
PBMetacelloBaselineProjectDependency >> isSameVersionAs: aVersionString [
	| repository |
	repository := IceRepository registry 
		detect: [ :repo | 
					repo remotes anySatisfy: [ :remote | 
			      remote referencesSameRemoteLocationAs: (IceGitRemote url: self icebergUrl) ] ]
		ifNone: [ ^ true ]. "See #testDependencyIsSatisfiedIfBaselineFoundButNoIceRepositoryToCheckTheVersion"
	^ aVersionString = version or: [ 
		  aVersionString = repository head commit id ]
]

{ #category : #'querying - installed' }
PBMetacelloBaselineProjectDependency >> satisfyConstraints: aVersionString [ 
	^ self isSameVersionAs: aVersionString
]

{ #category : #ston }
PBMetacelloBaselineProjectDependency >> stonMap [
	| dict |
	dict := OrderedDictionary 
		with: #baseline -> name
		with:	#url -> url asString
		with: 	#version -> version.
	packagesToLoad ifNotEmpty: [  dict at: #packagesToLoad put: packagesToLoad asArray ].
	^ dict
]
