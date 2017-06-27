specs
defaultSpec
	^ SpecLayout composed
		newRow: [ :row |
			row
				add: #packageOverview withSpec: #minimalSpec;
				add: #detailsView ]