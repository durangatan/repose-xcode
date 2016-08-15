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
    .Overview,
    .DataGathering]
//    .Privacy,
//    .DataUse,
//    .TimeCommitment,
//    .StudySurvey,
//    .StudyTasks,
//    .Withdrawing]
    
    var consentSections: [ORKConsentSection] = consentSectionTypes.map{ contentSectionType in
        let consentSection = ORKConsentSection(type: contentSectionType)
        consentSection.summary = "This application stores data about you for your own reflection and analysis."
        consentSection.content = "You will be asked to reflect on anxiety events after you experience them. All the questions will be totally optional."
        return consentSection
    }
    consentDocument.sections = consentSections
    
    // signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle:nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}