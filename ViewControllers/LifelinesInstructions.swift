//
//  ConsentDocument.swift
//  Camelot
//
//  Created by Joseph Duran on 8/14/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import Foundation
import ResearchKit

public var LifelineInstructions: ORKConsentDocument{

let consentDocument = ORKConsentDocument()
    consentDocument.title = "Lifelines"
    
    
    let introSection = ORKConsentSection(type: .StudyTasks)
    introSection.title = "Store Your Lifelines"
    introSection.summary = "Select some contacts who you'd like to be able call immediately when you need help."
    let availabilitySection = ORKConsentSection(type: .StudySurvey)
    availabilitySection.title = "LifeLine Availability"
    availabilitySection.summary = "Pick a time when you know your lifeline will be available. Available lifelines will glow green so you know who to call."

    let consentSections = [introSection, availabilitySection]
    consentDocument.sections = consentSections

    
    return consentDocument
}