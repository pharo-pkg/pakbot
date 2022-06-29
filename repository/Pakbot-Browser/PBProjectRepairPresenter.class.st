"
Presenter showing available options to repair the project.
You can select an option and then proceed with the selected action.
"
Class {
	#name : #PBProjectRepairPresenter,
	#superclass : #PBProjectOptionPresenter,
	#instVars : [
		'reasonPanel'
	],
	#category : #'Pakbot-Browser-Presenters'
}

{ #category : #examples }
PBProjectRepairPresenter class >> example [
	
	(self on: PBProjectVersion exampleWithDependency) 
		application: PakbotBrowser new;
		openDialog
]

{ #category : #accessing }
PBProjectRepairPresenter >> availableRepairOptions [
	
	^ PBRepairProjectAction allAvailableFor: self project
]

{ #category : #layout }
PBProjectRepairPresenter >> defaultLayout [ 
	^ SpBoxLayout newTopToBottom 
		add: reasonPanel height: 70;
		add: optionList;
		add: detailPanel;
		yourself
]

{ #category : #initialization }
PBProjectRepairPresenter >> initializePresenters [ 
	super initializePresenters.
	
	reasonPanel := self newText
		beNotEditable;
		addStyle: 'readonly';
		beWrapWord;
		text: self project problemLongDescription;
		yourself.
]

{ #category : #initialization }
PBProjectRepairPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Repair Cargo Project';
		initialExtent:  700@500

]
