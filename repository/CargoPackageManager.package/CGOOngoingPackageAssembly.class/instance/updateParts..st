updating - ui
updateParts: anAssociation
	| constraintsString |
	constraintsString := UIManager default 
		request: 'Constraints on package ' , anAssociation key, ':'
		initialAnswer: (Character space join: anAssociation value).
	constraintsString ifNil: [ ^ self ].
	anAssociation value: ('\s+' asRegex split: constraintsString) asArray.
	self updateAssociationsWith: anAssociation from: #parts.