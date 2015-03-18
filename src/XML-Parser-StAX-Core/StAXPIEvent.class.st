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
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXPIEvent class >> target: aTarget data: aData [
	^ self new
		target: aTarget;
		data: aData
]

{ #category : #building }
StAXPIEvent >> buildWith: aBuilder [
	aBuilder piEvent: self
]

{ #category : #accessing }
StAXPIEvent >> data [
	^ data ifNil: [data := ''].
]

{ #category : #accessing }
StAXPIEvent >> data: aData [
	data := aData
]

{ #category : #testing }
StAXPIEvent >> isPI [
	^ true
]

{ #category : #accessing }
StAXPIEvent >> target [
	^ target ifNil: [target := ''].
]

{ #category : #accessing }
StAXPIEvent >> target: aTarget [
	target := aTarget
]

{ #category : #printing }
StAXPIEvent >> writeXMLOn: aWriter [
	aWriter pi
		target: self target;
		data: self data
]
