specs
refreshUI
	self needRebuild: false.
	self buildWithSpecLayout: (self retrieveSpec: spec selector).