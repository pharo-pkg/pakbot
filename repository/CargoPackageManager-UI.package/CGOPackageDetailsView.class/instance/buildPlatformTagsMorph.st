building
buildPlatformTagsMorph
	| morph |
	morph := Morph new
		color: Color transparent;
		layoutPolicy: RowLayout new;
		cellInset: 10;
		yourself.
	self addPlatformRequirementTagsTo: morph.
	^ morph