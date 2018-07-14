tests
testCanSerializeAPackageDependencyOnExternalCargoProject
	| project projectStonString |
	
	project := self counterUiProject.
	projectStonString := STON toStringPretty: project asVcsSerializedCargoProject.
	
	self 
		assert: projectStonString
		equals: 'OngoingProject {
	#name : #Counter-UI,
	#description : ''Small UI for the counter model.'',
	#externalProjects : [
		CGOCargoProjectDependency {
			#repository : CGOGitRepository {
				#repositoryUrl : ''git://git@github.com/demarey/pharo-counter-ui.git'',
				#version : ''master''
			},
			#name : ''pharo-counter'',
			#version : ''''
		}
	],
	#units : [
		OngoingPackageUnit {
			#name : #Counter-UI-Spec,
			#description : ''Core package with the counter UI based on Spec.'',
			#dependencies : [
				#''Counter::Counter-Core''
			]
		}
	]
}'