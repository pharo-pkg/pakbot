"
Small dialiog window to ask the user what to load? metadata, all, assembly?
"
Class {
	#name : #PBLoadProjectDialog,
	#superclass : #ComposablePresenter,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-UI-Actions'
}

{ #category : #'as yet unclassified' }
PBLoadProjectDialog >> loadOptionsDataSource [

	^ FTEasyListDataSource new
		elements: (PBLoadProjectAction allAvailableFor: project);
		display: [ :each | each name ];
		icon: [ :each | self iconNamed: each iconName ];
		yourself
]
