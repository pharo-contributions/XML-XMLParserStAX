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
StAXPIEvent >> target: aString [
	target := aString
]

{ #category : #printing }
StAXPIEvent >> writeXMLOn: aWriter [
	aWriter pi
		target: self target;
		data: self data
]
