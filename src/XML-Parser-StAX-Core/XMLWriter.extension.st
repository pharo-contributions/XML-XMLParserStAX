Extension { #name : #XMLWriter }

{ #category : #'*XML-Parser-StAX-Core' }
XMLWriter >> writeEvent: anEvent [
	anEvent writeXMLOn: self
]

{ #category : #'*XML-Parser-StAX-Core' }
XMLWriter >> writeEvents: anEventList [
	anEventList do: [:each | each writeXMLOn: self]
]
