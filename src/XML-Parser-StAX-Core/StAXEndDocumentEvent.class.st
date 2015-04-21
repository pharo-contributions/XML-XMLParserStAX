"
An end of document event.
"
Class {
	#name : #StAXEndDocumentEvent,
	#superclass : #StAXEvent,
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #building }
StAXEndDocumentEvent >> buildWith: aBuilder [
	aBuilder buildEndDocumentEvent: self
]

{ #category : #testing }
StAXEndDocumentEvent >> isEndDocument [
	^ true
]
