Extension { #name : #String }

{ #category : #'*Pakbot-Core' }
String >> asPackageVersionReference [
	^ PBPackageVersionReference newOn: self
]
