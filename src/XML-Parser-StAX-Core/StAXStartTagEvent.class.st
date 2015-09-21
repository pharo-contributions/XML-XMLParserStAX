"
An start tag event.
"
Class {
	#name : #StAXStartTagEvent,
	#superclass : #StAXTagEvent,
	#instVars : [
		'attributes',
		'namespaceScope'
	],
	#category : #'XML-Parser-StAX-Core'
}

{ #category : #accessing }
StAXStartTagEvent >> attributeAt: aName [
	^ self attributes at: aName
]

{ #category : #accessing }
StAXStartTagEvent >> attributeAt: aName ifAbsent: aBlock [
	^ self attributes
		at: aName
		ifAbsent: aBlock
]

{ #category : #accessing }
StAXStartTagEvent >> attributeAt: aName ifAbsentPut: aBlock [
	^ self attributes
		at: aName
		ifAbsentPut: aBlock
]

{ #category : #accessing }
StAXStartTagEvent >> attributeAt: aName put: aValue [
	^ self attributes at: aName put: aValue
]

{ #category : #accessing }
StAXStartTagEvent >> attributes [
	^ attributes ifNil: [attributes := OrderPreservingStringDictionary new]
]

{ #category : #building }
StAXStartTagEvent >> buildWith: aBuilder [
	aBuilder buildStartTagEvent: self
]

{ #category : #testing }
StAXStartTagEvent >> hasAttributes [
	^ self attributes notEmpty
]

{ #category : #testing }
StAXStartTagEvent >> hasNamespaces [
	^ namespaceScope notNil
		and: [namespaceScope hasNamespaces].
]

{ #category : #testing }
StAXStartTagEvent >> includesAttribute: anAttributeName [
	^ self attributes includesKey: anAttributeName
]

{ #category : #testing }
StAXStartTagEvent >> isStartTag [
	^ true
]

{ #category : #testing }
StAXStartTagEvent >> isStartTagNamed: aTagName [
	^ self isNamed: aTagName
]

{ #category : #testing }
StAXStartTagEvent >> isStartTagNamedAny: aTagNameCollection [
	^ self isNamedAny: aTagNameCollection
]

{ #category : #private }
StAXStartTagEvent >> namespaceScope [
	^ namespaceScope
]

{ #category : #initialization }
StAXStartTagEvent >> setName: aName localName: aLocalName namespaceURI: aNamespaceURI attributes: anAttributeDictionary [
	name := aName.
	localName := aLocalName.
	namespaceURI := aNamespaceURI.
	attributes := anAttributeDictionary
]

{ #category : #initialization }
StAXStartTagEvent >> setNamespaceScope: aNamespaceScope [
	namespaceScope := aNamespaceScope
]

{ #category : #printing }
StAXStartTagEvent >> writeXMLOn: aWriter [
	| tagWriter |

	tagWriter := aWriter startTag: name.
	self hasNamespaces
		ifTrue: [tagWriter setXMLNSDeclarations: self namespaceScope prefixMappings].
	self hasAttributes
		ifTrue: [tagWriter setAttributes: self attributes].
	tagWriter write.
]
