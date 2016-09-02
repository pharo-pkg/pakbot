private - utilities
updateAssociationsWith: anAssociation from: aSelector
	| associations |
	associations := (aSelector value: self).
	associations
		detect: [ :each | each key = anAssociation key ]
		ifFound: [ :foundAssociation | foundAssociation value: anAssociation value ]
		ifNone: [ associations := associations copyWith: anAssociation ].
	self updateMethod: aSelector withContent: associations printString