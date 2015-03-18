"
A start of document event.
"
Class {
	#name : #StAXStartDocumentEvent,
	#superclass : #StAXEvent,
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #building }
StAXStartDocumentEvent >> buildWith: aBuilder [
	aBuilder startDocumentEvent: self
]

{ #category : #testing }
StAXStartDocumentEvent >> isStartDocument [
	^ true
]
