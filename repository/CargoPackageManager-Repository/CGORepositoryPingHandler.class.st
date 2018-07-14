"
I handle REST requests for /ping.
I simply answer ""pong"".
I can be used to test if the web server is started and is able to handle requests. Tools like monit will be able to restart this image if a simple request to /ping fails.
"
Class {
	#name : #CGORepositoryPingHandler,
	#superclass : #CGORepositoryRestCallHandler,
	#category : 'CargoPackageManager-Repository-ReST'
}

{ #category : #matching }
CGORepositoryPingHandler class >> pattern [
	^ #('ping')
]

{ #category : #public }
CGORepositoryPingHandler >> get [
	^ self response: (ZnResponse ok: (ZnEntity with: 'pong'))
]
