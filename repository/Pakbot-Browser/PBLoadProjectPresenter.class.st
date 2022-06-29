"
Presenter showing available options to load the project.
You can select an option and then proceed with the selected action.
"
Class {
	#name : #PBLoadProjectPresenter,
	#superclass : #PBProjectOptionPresenter,
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #examples }
PBLoadProjectPresenter class >> example [
	
	(self on: PBProjectVersion exampleWithDependency) 
		application: PakbotBrowser new;
		openDialog
]

{ #category : #accessing }
PBLoadProjectPresenter >> availableRepairOptions [
	
	^ PBLoadProjectAction allAvailableFor: self project
]

{ #category : #layout }
PBLoadProjectPresenter >> defaultLayout [ 
	^ SpBoxLayout newTopToBottom 
		add: optionList;
		add: detailPanel;
		yourself
]

{ #category : #initialization }
PBLoadProjectPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Load Project';
		initialExtent:  700@500
]
