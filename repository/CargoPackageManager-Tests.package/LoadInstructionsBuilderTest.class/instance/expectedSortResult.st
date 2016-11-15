expected results
expectedSortResult
	"self collect: [ :item | item packageVersion packageName , '@' , item packageVersion version asString]"
	^ #('B@3.1.0' 'D@1.1.0' 'C@1.0.0' 'E@1.0.0' 'A@1.0.0' 'Foo@1.0.0')