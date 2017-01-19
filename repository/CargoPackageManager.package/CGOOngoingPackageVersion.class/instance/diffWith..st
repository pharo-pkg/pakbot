comparing
diffWith: anObject
	| morph |
	morph := DiffMorph 
		from: (self serializedStringFor: self)
		to: (self serializedStringFor: anObject).
	^ morph
		extent: 1000@400;
		openInWindowLabeled: 'Diff' translated.