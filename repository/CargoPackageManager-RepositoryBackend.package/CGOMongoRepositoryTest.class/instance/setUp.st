running
setUp
	super setUp.
	repository := CGOMongoTestResource current repository.
	repository beSingleton.