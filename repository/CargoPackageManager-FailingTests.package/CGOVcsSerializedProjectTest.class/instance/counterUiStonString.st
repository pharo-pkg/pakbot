test data
counterUiStonString
	" STON toStringPretty: (self new counterUIProject asVcsSerializedCargoProject) "
	^ 'OngoingProject {
	#name : #Counter-UI,
	#description : ''Small UI for the counter model.'',
	#externalProjects : {
		#Counter : CGOCargoProjectDependency {
			#repository : CGOGitRepository {
				#repositoryUrl : ''git+ssh://git@github.com/demarey/pharo-counter-ui.git'',
				#version : ''master''
			}
		}
	},
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