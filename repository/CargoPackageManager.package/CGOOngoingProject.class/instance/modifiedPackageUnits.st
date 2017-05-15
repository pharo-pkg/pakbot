saving
modifiedPackageUnits 
	"check if either source code or metadata has been modified"
	self flag: 'TODO'.
	" for now, just return all packages part of the project"
	^ self packageUnitNames
		"select: #isDirty"
	"TO DO: isDirty should take into account the metadata state"
	"then return units objects"