initialization
initializeFromOngoing: aCGOOngoingPackage project: aCGOProject
	package := aCGOOngoingPackage package.
	description := aCGOOngoingPackage description copy.
	timestamp := DateAndTime now.
	
	self assert: aCGOProject class = CGOProject.
	project := aCGOProject.
