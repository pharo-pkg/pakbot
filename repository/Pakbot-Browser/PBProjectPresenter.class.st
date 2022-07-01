"
I'm in charge of displaying meta-information on Pakbot projects.
I also allow to edit these meta-data.
"
Class {
	#name : #PBProjectPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'overview',
		'dependencies',
		'projectStatus'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #initialization }
PBProjectPresenter >> connectPresenters [

	self
		transmitTo: projectStatus transform: [ :projectElement | 
			projectElement ifNotNil: [ :element | element project ] ];
		transmitTo: overview;
		transmitTo: dependencies
]

{ #category : #layout }
PBProjectPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom 
		add: projectStatus expand: false;
		add: overview;
		add: dependencies;
		yourself.
]

{ #category : #initialization }
PBProjectPresenter >> initializePresenters [

	overview := self instantiate: PBLoadableUnitOverviewPresenter on: self projectVersion.
	dependencies := self instantiate: PBPackageDependenciesView on: self projectVersion.
	projectStatus := self instantiate: PBProjectStatusPresenter on: self projectVersion.
]

{ #category : #accessing }
PBProjectPresenter >> projectVersion [ 
	^ self model
]

{ #category : #refreshing }
PBProjectPresenter >> refreshUI [
	self setModel: self projectVersion
]
