//
//  ConsentTask.swift
//  Camelot
//
//  Created by Joseph Duran on 8/14/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import Foundation
import ResearchKit

public var LifelineInstructionTask: ORKOrderedTask{

    var steps = [ORKStep]()
    
    var consentDocument = LifelineInstructions
    let visualConsentStep = ORKVisualConsentStep(identifier:"VisualConsentStep", document: consentDocument)
    steps += [visualConsentStep]
    
    return ORKOrderedTask(identifier:"LifelineInstructionTask", steps:steps)
}


