specs
defaultSpec
	^ SpecLayout composed
		newRow: [ :row |
			row
				add: #packageOverview;
				add: #partsView ]