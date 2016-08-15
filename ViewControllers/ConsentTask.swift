//
//  ConsentTask.swift
//  Camelot
//
//  Created by Joseph Duran on 8/14/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentTask: ORKOrderedTask{

    var steps = [ORKStep]()
    
    var consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier:"VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    let signature = consentDocument.signatures!.first as! ORKConsentSignature!
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, inDocument: consentDocument)
    
    reviewConsentStep.text = "Review Consent!"
    reviewConsentStep.reasonForConsent = "Consent to join study"
    
    steps += [reviewConsentStep]
    
    return ORKOrderedTask(identifier:"ConsentTask", steps:steps)
}