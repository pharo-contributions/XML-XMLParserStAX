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
StAXEvent >> isTag [
	^ false
]

{ #category : #testing }
StAXEvent >> isText [
	^ false
]

{ #category : #testing }
StAXEvent >> isText: aString [
	^ false
]

{ #category : #printing }
StAXEvent >> printBodyOn: aStream [
]

{ #category : #printing }
StAXEvent >> printNameOn: aStream [
	aStream
		nextPutAll: 'a ';
		nextPutAll: self className asString
]

{ #category : #printing }
StAXEvent >> printOn: aStream [
	self
		printNameOn: aStream;
		printBodyOn: aStream
]

{ #category : #printing }
StAXEvent >> writeXMLOn: aWriter [
]
