instance creation
fromOngoing: aCGOOngoingPackage project: aCGOProject
	^ self basicNew 
		initializeFromOngoing: aCGOOngoingPackage project: aCGOProject;
		yourself