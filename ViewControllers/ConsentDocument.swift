//
//  ConsentDocument.swift
//  Camelot
//
//  Created by Joseph Duran on 8/14/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import Foundation
import ResearchKit

public var ConsentDocument: ORKConsentDocument{

let consentDocument = ORKConsentDocument()
    consentDocument.title = "Repose Consent"
    
    //consent sections
    
    let consentSectionTypes: [ORKConsentSectionType] = [
    .StudyTasks,
    .DataGathering,
    .Privacy,
    .Withdrawing]
    
    // .studyTasks. .DataGathering, .Privacy, .Withdrawl
  
    
    let introSection = ORKConsentSection(type: .StudyTasks)
    introSection.title = "Welcome to Repose!"
    introSection.summary = "Repose gives you personalized ways to cope with anxiety, and provides powerful tools to help you find peace."
    let dataSection = ORKConsentSection(type: .DataGathering)
    dataSection.title = "Know thyself..."
    dataSection.summary = "Track your anxiety attacks over time to see what's working for you. Repose can help you remember details about your anxiety attacks, and help you build strategies for coping."
    let privacySection = ORKConsentSection(type: .Privacy)
    privacySection.summary = "We will never use your data for any purpose. Really. Any data you provide will be totally voluntary, and it will be encrypted so even we can't read it."
    let withdrawlSection = ORKConsentSection(type: .Withdrawing)
    withdrawlSection.title = "Opt out any time!"
    withdrawlSection.summary = "Just click withdraw in the menu bar and we'll delete all your data, no questions asked."

    let consentSections = [introSection, dataSection, privacySection, withdrawlSection]
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle:nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}