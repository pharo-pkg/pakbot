compute - clustering
groupCandidatesFor: aCollection
	| result |
	result := OrderedCollection new.
	
	1 to: aCollection size -1 do: 
		[ :i | 
		result addAll:
			(self groupCandidatesWithFirstElementFor: (aCollection copyFrom: i to: aCollection size)) ].
	^ result asSet