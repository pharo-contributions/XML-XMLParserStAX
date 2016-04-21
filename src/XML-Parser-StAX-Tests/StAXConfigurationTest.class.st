Class {
	#name : #StAXConfigurationTest,
	#superclass : #TestCase,
	#category : #'XML-Parser-StAX-Tests'
}

{ #category : #'instance creation' }
StAXConfigurationTest >> newConfiguration [
	^ StAXConfiguration new
]

{ #category : #tests }
StAXConfigurationTest >> testDOMConfiguration [
	| configuration domConfiguration |

	configuration := self newConfiguration.
	domConfiguration := configuration domConfiguration.
	self
		assert: (domConfiguration isKindOf: XMLDOMConfiguration);
		assert: domConfiguration isValidating = configuration isValidating;
		assert: domConfiguration usesNamespaces = configuration usesNamespaces;
		assert: domConfiguration requiresDocumentConstraints = configuration requiresDocumentConstraints;
		assert: domConfiguration parserLimits == configuration parserLimits;
		assert: domConfiguration entityConfiguration == configuration entityConfiguration;
		assert: domConfiguration preservesCDataNodes = configuration usesSeparateCDataEvents;
		assert: domConfiguration preservesCommentNodes = configuration skipsCommentEvents not.
]

{ #category : #tests }
StAXConfigurationTest >> testDecodesCharacters [
	| configuration |

	(configuration := self newConfiguration) decodesCharacters: false.
	self
		deny: configuration decodesCharacters;
		deny: configuration domConfiguration decodesCharacters.

	configuration decodesCharacters: true.
	self
		assert: configuration decodesCharacters;
		assert: configuration domConfiguration decodesCharacters.
]

{ #category : #tests }
StAXConfigurationTest >> testEntityConfiguration [
	| entityConfiguration configuration |

	configuration := self newConfiguration.
	2 timesRepeat: [
		entityConfiguration :=DTDEntityConfiguration new.
		configuration entityConfiguration: entityConfiguration.
		self
			assert: configuration entityConfiguration == entityConfiguration;
			assert:
				configuration domConfiguration entityConfiguration ==
					entityConfiguration].
]

{ #category : #tests }
StAXConfigurationTest >> testIsValidating [
	| configuration |

	(configuration := self newConfiguration) isValidating: false.
	self
		deny: configuration isValidating;
		deny: configuration domConfiguration isValidating.

	configuration isValidating: true.
	self
		assert: configuration isValidating;
		assert: configuration domConfiguration isValidating.
]

{ #category : #tests }
StAXConfigurationTest >> testNodeFactory [
	| nodeFactory configuration |

	configuration := self newConfiguration.
	2 timesRepeat: [
		nodeFactory := XMLNodeFactory new.
		configuration nodeFactory: nodeFactory.
		self
			assert: configuration nodeFactory == nodeFactory;
			assert: configuration domConfiguration nodeFactory == nodeFactory].
]

{ #category : #tests }
StAXConfigurationTest >> testParserLimits [
	| parserLimits configuration |

	configuration := self newConfiguration.
	2 timesRepeat: [
		parserLimits :=XMLParserLimits new.
		configuration parserLimits: parserLimits.
		self
			assert: configuration parserLimits == parserLimits;
			assert: configuration domConfiguration parserLimits == parserLimits].
]

{ #category : #tests }
StAXConfigurationTest >> testRequiresDocumentConstraints [
	| configuration |

	(configuration := self newConfiguration) requiresDocumentConstraints: false.
	self
		deny: configuration requiresDocumentConstraints;
		deny: configuration domConfiguration requiresDocumentConstraints.

	configuration requiresDocumentConstraints: true.
	self
		assert: configuration requiresDocumentConstraints;
		assert: configuration domConfiguration requiresDocumentConstraints.
]

{ #category : #tests }
StAXConfigurationTest >> testSkipsCommentEvents [
	| configuration |

	(configuration := self newConfiguration) skipsCommentEvents: false.
	self
		deny: configuration skipsCommentEvents;
		assert: configuration domConfiguration preservesCommentNodes.

	configuration skipsCommentEvents: true.
	self
		assert: configuration skipsCommentEvents;
		deny: configuration domConfiguration preservesCommentNodes.
]

{ #category : #tests }
StAXConfigurationTest >> testUsesNamespaces [
	| configuration |

	(configuration := self newConfiguration) usesNamespaces: false.
	self
		deny: configuration usesNamespaces;
		deny: configuration domConfiguration usesNamespaces.

	configuration usesNamespaces: true.
	self
		assert: configuration usesNamespaces;
		assert: configuration domConfiguration usesNamespaces.
]

{ #category : #tests }
StAXConfigurationTest >> testUsesSeparateCDataEvents [
	| configuration |

	(configuration := self newConfiguration) usesSeparateCDataEvents: false.
	self
		deny: configuration usesSeparateCDataEvents;
		deny: configuration domConfiguration preservesCDataNodes.

	configuration usesSeparateCDataEvents: true.
	self
		assert: configuration usesSeparateCDataEvents;
		assert: configuration domConfiguration preservesCDataNodes.
]
