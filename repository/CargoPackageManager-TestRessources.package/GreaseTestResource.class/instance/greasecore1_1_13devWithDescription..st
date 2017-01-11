data - cargo package versions
greasecore1_1_13devWithDescription: aDescription
	^ STON fromString: 
('CGOPackageUnit {
	#package : #Grease-Core,
	#description : ''', aDescription,''',
	#version : ''1.1.13-dev'',
	#timestamp : DateAndTime [ ''2015-04-14T14:51:50.116+00:00'' ],
	#dependencies : [ ],
	#src: CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main/''
		},
		#packageName : #Grease-Core,
		#versionString : ''JohanBrichau.94''
	}
}') 