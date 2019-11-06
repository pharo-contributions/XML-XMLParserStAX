"
Unit tests for StAXConfiguration
"
Class {
	#name : #StAXConfigurationTest,
	#superclass : #XMLConfigurationTest,
	#category : #'XML-ParserStAX-Tests-Configuration'
}

{ #category : #accessing }
StAXConfigurationTest >> configurationClass [
	^ StAXConfiguration
]

{ #category : #accessing }
StAXConfigurationTest >> domConfigurationClass [
	^ XMLDOMConfiguration
]

{ #category : #accessing }
StAXConfigurationTest >> parserHandlerClass [
	^ StAXParser
]

{ #category : #tests }
StAXConfigurationTest >> testDOMConfiguration [
	| configuration domConfiguration |

	configuration := self newConfiguration.
	domConfiguration := configuration domConfiguration.
	self
		assert: domConfiguration class == self domConfigurationClass;
		assert: domConfiguration isValidating equals: configuration isValidating;
		assert: domConfiguration usesNamespaces equals: configuration usesNamespaces;
		assert: domConfiguration requiresSchema equals: configuration requiresSchema;
		assert: domConfiguration parserLimits == configuration parserLimits;
		assert: domConfiguration entityConfiguration == configuration entityConfiguration;
		assert: domConfiguration preservesCDataNodes equals: configuration usesSeparateCDataEvents;
		assert: domConfiguration preservesCommentNodes equals: configuration skipsCommentEvents not.
]

{ #category : #tests }
StAXConfigurationTest >> testDecodesCharacters [
	| configuration |

	super testDecodesCharacters.

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
	| configuration newEntityConfiguration |

	super testEntityConfiguration.

	configuration := self newConfiguration.
	newEntityConfiguration := DTDEntityConfiguration new.
	self assert:
		(configuration entityConfiguration: newEntityConfiguration) ==
			configuration.
	self
		assert: configuration entityConfiguration == newEntityConfiguration;
		assert:
			configuration domConfiguration entityConfiguration ==
				newEntityConfiguration.
]

{ #category : #tests }
StAXConfigurationTest >> testIsValidating [
	| configuration |

	super testIsValidating.

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
	| configuration newNodeFactory |

	configuration := self newConfiguration.
	newNodeFactory := XMLNodeFactory new.
	self
		assert: (configuration nodeFactory: newNodeFactory) == configuration;
		assert: configuration nodeFactory == newNodeFactory;
		assert: configuration domConfiguration nodeFactory == newNodeFactory.
]

{ #category : #tests }
StAXConfigurationTest >> testParserLimits [
	| configuration newParserLimits |

	super testParserLimits.

	configuration := self newConfiguration.
	newParserLimits := XMLParserLimits new.
	self
		assert: (configuration parserLimits: newParserLimits) == configuration;
		assert: configuration parserLimits == newParserLimits;
		assert: configuration domConfiguration parserLimits == newParserLimits.
]

{ #category : #tests }
StAXConfigurationTest >> testRequiresSchema [
	| configuration |

	super testRequiresSchema.

	(configuration := self newConfiguration) requiresSchema: false.
	self
		deny: configuration requiresSchema;
		deny: configuration domConfiguration requiresSchema.

	configuration requiresSchema: true.
	self
		assert: configuration requiresSchema;
		assert: configuration domConfiguration requiresSchema.
]

{ #category : #tests }
StAXConfigurationTest >> testSkipsCommentEvents [
	| configuration |

	configuration := self newConfiguration.
	self
		assert: configuration skipsCommentEvents;
		assert: (configuration skipsCommentEvents: false) == configuration;
		deny: configuration skipsCommentEvents;
		assert: configuration domConfiguration preservesCommentNodes.

	self
		assert: (configuration skipsCommentEvents: true) == configuration;
		assert: configuration skipsCommentEvents;
		deny: configuration domConfiguration preservesCommentNodes.
]

{ #category : #tests }
StAXConfigurationTest >> testUsesNamespaces [
	| configuration |

	super testUsesNamespaces.

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

	configuration := self newConfiguration.
	self
		assert: (configuration usesSeparateCDataEvents: false) == configuration;
		deny: configuration usesSeparateCDataEvents;
		deny: configuration domConfiguration preservesCDataNodes.

	self
		assert: (configuration usesSeparateCDataEvents: true) == configuration;
		assert: configuration usesSeparateCDataEvents;
		assert: configuration domConfiguration preservesCDataNodes.
]
