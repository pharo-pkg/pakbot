compute - clustering
groupCandidatesWithFirstElementFor: aCollection
	| result |
	result := OrderedCollection new: aCollection size -1.
	2 to: aCollection size do: 
		[ :i | 
		result add: (aCollection copyFrom: 1 to: i) asSet ].
	^ result