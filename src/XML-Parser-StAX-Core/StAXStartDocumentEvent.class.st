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
	aBuilder buildStartDocumentEvent: self
]

{ #category : #testing }
StAXStartDocumentEvent >> isStartDocument [
	^ true
]
