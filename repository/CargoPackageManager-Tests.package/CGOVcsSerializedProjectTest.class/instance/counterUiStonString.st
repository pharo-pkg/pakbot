test data
counterUiStonString
	^ 'CGOProject {
	#description : ''Small UI for the counter model.'',
	#name : #''Counter-UI'',
	#externalProjects : [
		#Counter: CGOCargoProjectDependency {
			#url: ''github://demarey/pharo-counter-ui:master''
		}
	],
	#units : [
		CGOPackageUnit {
			#name : #Counter-UI-Spec,
			#description : ''Core package with the counter UI based on Spec.'',
			#dependencies : [ 
				#''Counter::Counter-Core''
			]
		}
	]
}'