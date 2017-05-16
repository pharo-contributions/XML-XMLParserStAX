"
An abstract class for events.
"
Class {
	#name : #StAXEvent,
	#superclass : #Object,
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #building }
StAXEvent >> buildWith: aBuilder [
]

{ #category : #testing }
StAXEvent >> isCData [
	^ false
]

{ #category : #testing }
StAXEvent >> isComment [
	^ false
]

{ #category : #testing }
StAXEvent >> isEndDocument [
	^ false
]

{ #category : #testing }
StAXEvent >> isEndTag [
	^ false
]

{ #category : #testing }
StAXEvent >> isEndTagNamed: aTagName [
	^ false
]

{ #category : #testing }
StAXEvent >> isEndTagNamedAny: aTagName [
	^ false
]

{ #category : #testing }
StAXEvent >> isInitialEvent [
	^ false
]

{ #category : #testing }
StAXEvent >> isPI [
	^ false
]

{ #category : #testing }
StAXEvent >> isStartDocument [
	^ false
]

{ #category : #testing }
StAXEvent >> isStartTag [
	^ false
]

{ #category : #testing }
StAXEvent >> isStartTagNamed: aTagName [
	^ false
]

{ #category : #testing }
StAXEvent >> isStartTagNamedAny: aTagName [
	^ false
]

{ #category : #testing }
StAXEvent >> isStringEvent [
	^ false
]

{ #category : #testing }
StAXEvent >> isStringEvent: aStringOrStringEvent [
	^ false
]

{ #category : #testing }
StAXEvent >> isTag [
	^ false
]

{ #category : #deprecated }
StAXEvent >> isText [
	^ self isStringEvent
]

{ #category : #deprecated }
StAXEvent >> isText: aString [
	^ self isStringEvent: aString
]

{ #category : #printing }
StAXEvent >> writeXMLOn: aWriter [
]
