specs
defaultSpec
	<spec>

	^ SpecLayout composed
		newRow: [ :row |
			row 
				add: #statusIcon width: 16;
				add: #statusLabel;
				add: #actionButton width: 60 ]