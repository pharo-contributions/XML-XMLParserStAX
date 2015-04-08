"
A list for StAX events that supports conversion to DOM.
"
Class {
	#name : #StAXEventList,
	#superclass : #XMLOrderedList,
	#instVars : [
		'configuration'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #'instance creation' }
StAXEventList class >> configuration: aConfiguration [
	^ self new configuration: aConfiguration
]

{ #category : #converting }
StAXEventList >> asDOM [
	^ self asDOMBuilder build
]

{ #category : #converting }
StAXEventList >> asDOMBuilder [
	| builder |

	builder := self domBuilderClass on: self.
	configuration
		ifNotNil: [builder configuration: configuration asDOMConfiguration].
	^ builder.
]

{ #category : #initialization }
StAXEventList >> configuration: aConfiguration [
	configuration := aConfiguration
]

{ #category : #private }
StAXEventList >> domBuilderClass [
	^ StAXDOMBuilder
]
