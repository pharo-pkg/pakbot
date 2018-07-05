test data
stonStringForExampleProject
	"
		STON toStringPretty: CGOOngoingProject example asVcsSerializedCargoProject
	"
	^ 'OngoingProject {
	#name : #MyProject,
	#description : ''A simple project used for illustration.'',
	#units : [
		OngoingPackageUnit {
			#name : #UnitTest,
			#description : ''A simple ongoing package unit.'',
			#dependencies : [ ]
		}
	]
}'