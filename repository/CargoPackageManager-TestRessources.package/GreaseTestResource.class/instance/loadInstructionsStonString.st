data
loadInstructionsStonString
	"Cargo new
		package: 'Grease-Slime';
		loadInstructions"
		
	^  'CGOLoadInstructions {
	#groups : OrderedCollection [
		CGOPackageLoadGroup {
			#name : ''Grease-Core'',
			#packageVersions : [
				CGOPackageUnit {
					#package : #Grease-Core,
					#description : ''Core package of the Grease library.'',
					#version : ''1.1.13'',
					#timestamp : DateAndTime [ ''2015-04-14T14:51:50.116+00:00'' ],
					#dependencies : [ ],
					#src: CGOMonticelloHostedPackageVersion {
						#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main'',
						#packageName : #Grease-Core,
						#versionString : ''JohanBrichau.94''
					}
				}
			]
		},
		CGOPackageLoadGroup {
			#name : ''Grease-Pharo30-Core'',
			#packageVersions : [
				CGOPackageUnit {
					#package : #Grease-Pharo30-Core,
					#description : ''Platform-specific package of the Grease-Core package for Pharo.'',
					#version : ''1.1.13'',
					#timestamp : DateAndTime [ ''2015-05-11T14:56:14.307+00:00'' ],
					#dependencies : [
						#Grease-Core : [
							''=1.1.13''
						]
					],
					#src: CGOMonticelloHostedPackageVersion {
						#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main'',
						#packageName : #Grease-Pharo30-Core,
						#versionString : ''JohanBrichau.16''
					},
					#platformRequirements : [
						#pharo
					],
					#provisions : [
						#Grease-Core-Platform
					]
				}
			]
		},
		CGOPackageLoadGroup {
			#name : ''Grease-Pharo40-Slime'',
			#packageVersions : [
				CGOPackageUnit {
					#package : #Grease-Pharo40-Slime,
					#description : ''Slime uses the Refactoring Browser to find and, in some cases, rewrite common compatibility problems.'',
					#version : ''1.1.13'',
					#timestamp : DateAndTime [ ''2015-05-11T14:56:09.456+00:00'' ],
					#dependencies : [
						#Grease-Core-Platform : [
							''=1.1.13''
						]
					],
					#src: CGOMonticelloHostedPackageVersion {
						#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Grease11/main'',
						#packageName : #Grease-Pharo40-Slime,
						#versionString : ''JohanBrichau.3''
					},
					#platformRequirements : [
						#pharo4.x
					],
					#provisions : [
						#Grease-Slime
					]
				}
			]
		}
	]
}'