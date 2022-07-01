"
Meta-action that represent the loading of a particular project assembly.
I'm dynamically collected by `PBLoadProjectPresenter`.
"
Class {
	#name : #PBLoadAssemblyAction,
	#superclass : #PBLoadProjectAction,
	#instVars : [
		'assembly'
	],
	#category : #'Pakbot-Browser-Actions'
}

{ #category : #'instance creation' }
PBLoadAssemblyAction class >> forProject: aProject [

	^ aProject assemblies 
		collect: [ :each |
			self new
				project: aProject;
				assembly: each;
				yourself	]

]

{ #category : #testing }
PBLoadAssemblyAction class >> isAvailableFor: aProject [

	^ aProject assemblies isEmpty not
]

{ #category : #'instance creation' }
PBLoadAssemblyAction class >> on: aProject [

	^ aProject assemblies 
		collect: [ :each |
			(super on: aProject)
				assembly: each;
				yourself	]

]

{ #category : #accessing }
PBLoadAssemblyAction >> assembly: anAssembly [ 

	assembly := anAssembly
]

{ #category : #accessing }
PBLoadAssemblyAction >> description [

	^ 'Loads the packages of this assembly and their dependencies.
Packages not belonging to this asembly will not be loaded.'
]

{ #category : #execution }
PBLoadAssemblyAction >> doExecute [

	assembly load
]

{ #category : #accessing }
PBLoadAssemblyAction >> iconName [

	^ #group
]

{ #category : #accessing }
PBLoadAssemblyAction >> name [

	^ 'Load {1} assembly' format: { assembly name }
]
