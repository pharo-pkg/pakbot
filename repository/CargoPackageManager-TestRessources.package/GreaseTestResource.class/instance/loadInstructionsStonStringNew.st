data
loadInstructionsStonStringNew
	"Cargo new
		package: 'Grease-Slime';
		loadInstructions"
		
	^  'CGOLoadInstructions {
	#groups : OrderedCollection [
		CGOPackageLoadGroup {
			#name : ''Grease-Core'',
			#packageVersionRefs : [ ''Grease-Core@1.1.13'' ]
		},
		CGOPackageLoadGroup {
			#name : ''Grease-Pharo30-Core'',
			#packageVersionRefs : [ ''Grease-Pharo30-Core@1.1.13'' ]
		},
		CGOPackageLoadGroup {
			#name : ''Grease-Pharo40-Slime'',
			#packageVersionRefs : [ ''Grease-Pharo40-Slime@1.1.13'' ]
		}
	]
}'