instance-creation
onProject: aProject
	^ self basicNew
		project: aProject;
		initialize;
		yourself.