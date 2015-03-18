"
Initial (null) event returned by current before parsing has started.
"
Class {
	#name : #StAXInitialEvent,
	#superclass : #StAXEvent,
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #testing }
StAXInitialEvent >> isInitialEvent [
	^ true
]
