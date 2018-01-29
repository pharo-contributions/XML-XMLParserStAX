"
A start of document event.
"
Class {
	#name : #StAXStartDocumentEvent,
	#superclass : #StAXStatelessEvent,
	#category : #'XML-ParserStAX-Core'
}

{ #category : #building }
StAXStartDocumentEvent >> buildWith: aBuilder [
	aBuilder buildStartDocumentEvent: self
]

{ #category : #testing }
StAXStartDocumentEvent >> isStartDocument [
	^ true
]
