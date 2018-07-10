initialization
initializeWidgets
	
	statusLabel := self newLabel.
	actionButton := self newButton label: 'Repair'.
	statusIcon := self newImage.
	
	statusIcon image: (self iconNamed: project problemIcon).
	statusLabel label: project problemShortDescription.
	statusLabel help: project problemLongDescription.
	statusIcon help: project problemLongDescription 

	
