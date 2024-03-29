"
A processing instruction event.
"
Class {
	#name : #StAXPIEvent,
	#superclass : #StAXEvent,
	#instVars : [
		'target',
		'data'
	],
	#category : #'XML-ParserStAX-Core'
}

{ #category : #'instance creation' }
StAXPIEvent class >> target: aTargetString data: aDataString [
	^ self new
		target: aTargetString;
		data: aDataString
]

{ #category : #building }
StAXPIEvent >> buildWith: aBuilder [
	aBuilder buildPIEvent: self
]

{ #category : #accessing }
StAXPIEvent >> data [
	^ data ifNil: [data := ''].
]

{ #category : #accessing }
StAXPIEvent >> data: aString [
	data := aString
]

{ #category : #testing }
StAXPIEvent >> isPI [
	^ true
]

{ #category : #printing }
StAXPIEvent >> printOn: aStream [
	super printOn: aStream.

	aStream
		nextPut: $(;
		nextPutAll: self target;
		nextPut: $).
]

{ #category : #accessing }
StAXPIEvent >> target [
	^ target ifNil: [target := ''].
]

{ #category : #accessing }
StAXPIEvent >> target: aString [
	target := aString
]

{ #category : #printing }
StAXPIEvent >> writeXMLOn: aWriter [
	aWriter pi
		target: self target;
		data: self data;
		write
]
