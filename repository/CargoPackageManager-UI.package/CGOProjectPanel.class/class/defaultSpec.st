specs
defaultSpec
	^ SpecLayout composed
		newRow: [ :row | 
			row
				add: #overview;
				add: #dependencies ]