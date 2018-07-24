"
Subclass me to provide a new way of loading a project.
My subclasses are dynamically collected by PBLoadProjectDialog.
"
Class {
	#name : #PBLoadProjectAction,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-UI-Loading'
}

{ #category : #querying }
PBLoadProjectAction class >> allAvailableFor: aProject [

	^ (self allSubclasses 
		select: [ :aClass | aClass isAvailableFor: aProject ] 
		thenCollect: [ :aClass | aClass forProject: aProject ]) flattened
]

{ #category : #'instance creation' }
PBLoadProjectAction class >> forProject: aProject [

	^ self new
		project: aProject;
		yourself
]

{ #category : #accessing }
PBLoadProjectAction >> description [
	self subclassResponsibility
]

{ #category : #running }
PBLoadProjectAction >> execute [
	self subclassResponsibility
]

{ #category : #accessing }
PBLoadProjectAction >> iconName [
	self subclassResponsibility
]

{ #category : #initializing }
PBLoadProjectAction >> project: aProject [ 
	^ aProject assemblies isEmpty not
]
