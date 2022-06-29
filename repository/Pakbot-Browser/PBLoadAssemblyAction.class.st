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

{ #category : #testing }
PBLoadAssemblyAction class >> isAvailableFor: aProject [

	^ aProject assemblies isEmpty not
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
