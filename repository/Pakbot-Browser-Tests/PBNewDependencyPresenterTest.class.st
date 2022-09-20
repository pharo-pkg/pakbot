Class {
	#name : #PBNewDependencyPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'window'
	],
	#category : #'Pakbot-Browser-Tests'
}

{ #category : #tests }
PBNewDependencyPresenterTest >> tearDown [ 

	presenter ifNotNil: [ presenter delete ].
	window ifNotNil: [ window delete ].
	super tearDown
]

{ #category : #tests }
PBNewDependencyPresenterTest >> testCanCreateThreeKindOfDependencies [
	"pakbot, metacello baseline and metacello configuration dependencies"
	
	presenter := PBNewDependencyPresenter new.
	presenter open.
	
	self 
		assert: presenter optionsPresenter items size
		equals: 3.
]

{ #category : #tests }
PBNewDependencyPresenterTest >> testGetNewDependencyWhenOkClicked [
	
	| dependency |

	presenter := PBNewDependencyPresenter new.
	window := presenter 
		openDialogOnAccept: [ :dep | dependency := dep ]
		onCancel: [].
	presenter optionsPresenter selectFirst.
	
	presenter selectedOption 
		name: 'Foo';
		version: '1.0'.
	window okButton click.
	
	self assert: dependency notNil. 
	self 
		assert: dependency	name
		equals: 'Foo'.
	self
		assert: dependency	version
		equals: '1.0'.
]

{ #category : #tests }
PBNewDependencyPresenterTest >> testOkButtonIsDisabledAtOpening [
	
	presenter := PBNewDependencyPresenter new.
	window := presenter openDialog.
	presenter optionsPresenter selectFirst.
	
	self deny: window okButton isEnabled.
]

{ #category : #tests }
PBNewDependencyPresenterTest >> testOkButtonIsDisabledIfOptionPresenterValidationFails [
	
	presenter := PBNewDependencyPresenter new.
	window := presenter openDialog.
	presenter optionsPresenter selectFirst.
	
	presenter selectedOption 
		name: 'Foo'.
	
	self deny: presenter selectedOption isValid.	
	self deny: window okButton isEnabled.
]

{ #category : #tests }
PBNewDependencyPresenterTest >> testOkButtonIsEnabledIfOptionPresenterValidationSucceeds [
	
	presenter := PBNewDependencyPresenter new.
	window := presenter openDialog.
	presenter optionsPresenter selectFirst.
	
	presenter selectedOption
		name: 'Foo';
		version: '1.0'.
		
	self assert: presenter selectedOption isValid.	
	self assert: window okButton isEnabled.
]
