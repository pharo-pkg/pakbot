Class {
	#name : #PBDropDownColumn,
	#superclass : #PBConflictsColumn,
	#instVars : [
		'dialog'
	],
	#category : #'CargoPackageManager-UI-Conflicts'
}

{ #category : #accessing }
PBDropDownColumn >> dialog: aPBResolveConflictsDialog [ 
	
	dialog := aPBResolveConflictsDialog
]

{ #category : #reading }
PBDropDownColumn >> read: aPBConflict [

	^	PBConflictDropListMorph new
		model: (PBConflictDropModel on: aPBConflict dialog: dialog);
		getIndexSelector: #selected;
		setIndexSelector: #selected:;
		getListSelector: #list;
		height: 20;
		useSelectionIndex: false;
		updateList;
		updateListSelectionIndex;
		updateContents;
		yourself
]
