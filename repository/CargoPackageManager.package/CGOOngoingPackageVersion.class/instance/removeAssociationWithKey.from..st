private - utilities
removeAssociationWithKey: aKey from: aSelector
	| associations |
	associations := (aSelector value: self) 
		reject: [ :association | association key = aKey ].
	self 
		updateMethod: aSelector
		withContent: associations printString