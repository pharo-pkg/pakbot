"
I'm in charge of displaying meta-information on Cargo projects.
I also allow to edit these meta-data.
"
Class {
	#name : #PBProjectPanel,
	#superclass : #PBLoadableUnitPanel,
	#instVars : [
		'overview',
		'dependencies',
		'projectStatus'
	],
	#category : #'CargoPackageManager-UI'
}

{ #category : #'instance creation' }
PBProjectPanel class >> buildOnOngoing: aProjectVersion [
	^ (self on: aProjectVersion) buildWithSpec
]

{ #category : #example }
PBProjectPanel class >> example [
	^ (self on: PBProjectVersion example)
		openWithSpec
]

{ #category : #specs }
PBProjectPanel >> defaultLayout [

	^ SpBoxLayout newTopToBottom 
		add: projectStatus expand: false;
		add: (	SpBoxLayout newLeftToRight
			add: overview;
			add: dependencies;
			yourself);
		yourself.
]

{ #category : #initialization }
PBProjectPanel >> initializeWidgets [

	overview := self instantiate: PBLoadableUnitOverviewPanel on: self projectVersion.
	dependencies := self instantiate: CGOPackageDependenciesView on: self projectVersion.
	projectStatus := self instantiate: PBProjectStatusPresenter on: self projectVersion.
	
	self layout: self defaultLayout.
]

{ #category : #accessing }
PBProjectPanel >> projectVersion [ 
	^ self model
]

{ #category : #specs }
PBProjectPanel >> refreshUI [
	self needRebuild: false.
	self buildWithSpecLayout: self defaultLayout.
]
