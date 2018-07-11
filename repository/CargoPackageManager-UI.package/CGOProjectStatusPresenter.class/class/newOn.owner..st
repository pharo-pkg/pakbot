specs
newOn: aProject owner: anOwner.

	^ self basicNew
		project: aProject;
		owner: anOwner;
		initialize;
		yourself