"
Unit tests for StAXPIEvent
"
Class {
	#name : #StAXPIEventTest,
	#superclass : #StAXEventTest,
	#category : #'XML-ParserStAX-Tests-Events'
}

{ #category : #accessing }
StAXPIEventTest >> eventClass [
	^ StAXPIEvent
]

{ #category : #tests }
StAXPIEventTest >> testData [
	| pi |

	pi := self newEvent.
	self
		assert: pi data equals: '';
		assert: (pi data: 'test') == pi;
		assert: pi data equals: 'test'
]

{ #category : #tests }
StAXPIEventTest >> testIsPI [
	self assert: self newEvent isPI
]

{ #category : #tests }
StAXPIEventTest >> testTarget [
	| pi |

	pi := self newEvent.
	self
		assert: pi target equals: '';
		assert: (pi target: 'test') == pi;
		assert: pi target equals: 'test'
]

{ #category : #tests }
StAXPIEventTest >> testTargetData [
	| pi |

	pi :=
		self eventClass
			target: 'target'
			data: 'data'.
	self
		assert: pi class == self eventClass;
		assert: pi target equals: 'target';
		assert: pi data equals: 'data'
]
