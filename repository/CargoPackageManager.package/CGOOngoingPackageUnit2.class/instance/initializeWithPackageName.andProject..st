initialization
initializeWithPackageName: aPackageName andProject: aCargoProject
	super initializeWithPackageName: aPackageName andProject: aCargoProject.
	dependencies := OrderedCollection new.
	provisions := OrderedCollection new: 0.
	platformRequirements := OrderedCollection new: 0.	