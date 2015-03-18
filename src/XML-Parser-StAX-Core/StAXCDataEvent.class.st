"
A text event from CDATA
"
Class {
	#name : #StAXCDataEvent,
	#superclass : #StAXTextEvent,
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #building }
StAXCDataEvent >> buildWith: aBuilder [
	aBuilder cdataEvent: self
]

{ #category : #testing }
StAXCDataEvent >> isCData [
	^ true
]

{ #category : #printing }
StAXCDataEvent >> writeXMLOn: aWriter [
	aWriter cdata: self string
]
