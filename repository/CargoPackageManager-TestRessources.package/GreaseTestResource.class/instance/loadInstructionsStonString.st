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
					#repositories : [
						''http://smalltalkhub.foo/mc/Seaside/Grease11/main/''
					],
					#file : ''Grease-Core-JohanBrichau.94''
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
					#repositories : [
						''http://smalltalkhub.foo/mc/Seaside/Grease11/main/''
					],
					#platformRequirements : [
						#pharo
					],
					#provisions : [
						#Grease-Core-Platform
					],
					#file : ''Grease-Pharo30-Core-JohanBrichau.16''
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
					#repositories : [
						''http://smalltalkhub.foo/mc/Seaside/Grease11/main/''
					],
					#platformRequirements : [
						#pharo4.x
					],
					#provisions : [
						#Grease-Slime
					],
					#file : ''Grease-Pharo40-Slime-JohanBrichau.3''
				}
			]
		}
	]
}'