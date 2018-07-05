test data
stonStringForExampleProject
	^ 'CGOProject {
	#description : ''A simple project used for illustration.'',
	#version : ''0.1.0-dev'',
	#name : #MyProject,
	#repository : CGOGitRepository {
		#repositoryUrl : ''git@github.com:foo/bar.git'',
		#subdirectory : ''repository''
	},
	#unitNames : [
		#Package1,
		#Package2
	]
}'