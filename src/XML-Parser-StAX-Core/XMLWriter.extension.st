Extension { #name : #XMLWriter }

{ #category : #'*XML-Parser-StAX-Core' }
XMLWriter >> writeEvent: anEvent [
	anEvent writeXMLOn: self
]
