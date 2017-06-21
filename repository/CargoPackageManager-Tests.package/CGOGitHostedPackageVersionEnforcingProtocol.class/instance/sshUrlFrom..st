converting
sshUrlFrom: aString 
	| matcher |
	matcher := 'https\://((\w|\d|\.)+)/(.+)' asRegex.
	^ (matcher matches: aString) 
		ifTrue: [ 'git@', (matcher subexpression: 2) , ':' , (matcher subexpression: 4), '.git' ]
		ifFalse: [ aString ]
		