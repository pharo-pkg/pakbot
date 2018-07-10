initialization
handleAnnouncement: ann

	ann project = self project
		ifTrue: [ 
			self needRebuild: false.
			owner refreshUI ]