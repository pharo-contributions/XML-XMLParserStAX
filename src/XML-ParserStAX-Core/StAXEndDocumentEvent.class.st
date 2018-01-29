"
An end of document event.
"
Class {
	#name : #StAXEndDocumentEvent,
	#superclass : #StAXStatelessEvent,
	#category : #'XML-ParserStAX-Core'
}

{ #category : #building }
StAXEndDocumentEvent >> buildWith: aBuilder [
	aBuilder buildEndDocumentEvent: self
]

{ #category : #testing }
StAXEndDocumentEvent >> isEndDocument [
	^ true
]
