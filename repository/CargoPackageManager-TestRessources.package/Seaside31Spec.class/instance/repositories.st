as yet unclassified
repositories
	"classes := (RPackage organizer packageNamed: 'PackagesManager') classesForClassTag: #'PackagesManager-SeasideDescCommon'.
classes
	select: [ :class | class name beginsWith: 'Seaside' ]
	thenDo: [  :class | class compile: 'repositories
	package addRepository: ''http://smalltalkhub.com/mc/Seaside/Seaside31/main'''  ]"

	^ #('http://smalltalkhub.com/mc/Seaside/Seaside31/main')