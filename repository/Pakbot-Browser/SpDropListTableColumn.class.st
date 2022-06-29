"
A column that displays drop lists.

The user need to set the evaluation block (by sending `SpDropListColumn>>#evaluated:`) to answer a drop list (an instance of `SpDropListPresenter`).

## Example
```
self example
```
"
Class {
	#name : #SpDropListTableColumn,
	#superclass : #SpTableColumn,
	#instVars : [
		'display',
		'selectedItemChangedAction'
	],
	#category : #'Pakbot-Browser'
}

{ #category : #examples }
SpDropListTableColumn class >> example [

	^ SpTablePresenter new
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		addColumn:
			((SpDropListTableColumn title: 'Value' evaluated: [ {true . false} ])
				width: 50;
				yourself);
		items: self class environment allClasses;
		beResizable;
		open
]

{ #category : #visiting }
SpDropListTableColumn >> acceptColumnVisitor: aBuilder [

	^ aBuilder visitDropListColumn: self
]

{ #category : #accessing }
SpDropListTableColumn >> display [
	
	^ display
]

{ #category : #accessing }
SpDropListTableColumn >> display: aBlock [

	display := aBlock
]

{ #category : #accessing }
SpDropListTableColumn >> selectedItemChangedAction [
		
	^ selectedItemChangedAction
]

{ #category : #accessing }
SpDropListTableColumn >> selectedItemChangedAction: aBlock [

	selectedItemChangedAction := aBlock
]