//
//  SurveyTask.swift
//  ResearchKit
//
//  Created by Joseph Duran on 8/14/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

import Foundation
import ResearchKit

public var SurveyTask: ORKOrderedTask {
    
    var steps = [ORKStep]()
    
    // MARK: Instruction
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Anxiety Episode Reflection"
    instructionStep.text = "Let's reflect on what happened so we can help you feel better."
    steps += [instructionStep]
    
    let severityStepAnswerFormat = ORKAnswerFormat.scaleAnswerFormatWithMaximumValue(10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: "High", minimumValueDescription: "Low")
    
    let severityScaleStep = ORKQuestionStep(identifier: "severity", title: "Severity Scale", answer: severityStepAnswerFormat)
        // The first step is a scale control with 10 discrete ticks.
    
    
    severityScaleStep.text = "How severe was this incident?"

    
    steps += [severityScaleStep]
    
    
    //MARK: sleep
    let sleepQuestionStepTitle = "How much sleep did you get last night?"
    let sleepTextChoices = [
        ORKTextChoice(text: "Below the average amount", value: 0),
        ORKTextChoice(text: "average amount", value: 1),
        ORKTextChoice(text: "more than average", value: 2)
    ]
    let sleepAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.SingleChoice, textChoices: sleepTextChoices)
    let sleepQuestionStep = ORKQuestionStep(identifier: "sleep_quality", title: sleepQuestionStepTitle, answer: sleepAnswerFormat)
    steps += [sleepQuestionStep]
    
    //MARK: Symptoms
    let symptomQuestionStepTitle = "Did you notice any of the following physical symptoms?"
    let symptomTextChoices = [
        ORKTextChoice(text: "ringing in the ears", value: 0),
        ORKTextChoice(text: "lightheadedness", value: 1),
        ORKTextChoice(text: "difficulty breathing", value: 2),
        ORKTextChoice(text: "tingling in the extremities", value: 3),

    ]
    let symptomAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormatWithStyle(.MultipleChoice, textChoices: symptomTextChoices)
    let symptomQuestionStep = ORKQuestionStep(identifier: "symptoms", title: symptomQuestionStepTitle, answer: symptomAnswerFormat)
    steps += [symptomQuestionStep]
    
    
    //MARK: Notes
    let notesAnswerFormat = ORKTextAnswerFormat()
    notesAnswerFormat.multipleLines = true
    let notesQuestionStepTitle = "Feel free to jot down other notes here."
    let notesQuestionStep = ORKQuestionStep(identifier: "comments", title: notesQuestionStepTitle, text:"What were you doing in the moments leading up to the episode? Did you feel like this episode was linked to anything specific?" , answer: notesAnswerFormat )
    steps += [notesQuestionStep]
    
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Right. Off you go!"
    summaryStep.text = "That was easy!"
    steps += [summaryStep]

    
    
    return ORKOrderedTask(identifier: "SurveyTask", steps: steps)
}