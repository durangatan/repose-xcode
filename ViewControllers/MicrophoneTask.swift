//
//  MicrophoneTask.swift
//  Camelot
//
//  Created by Joseph Duran on 8/14/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import Foundation

import ResearchKit

public var MicrophoneTask: ORKOrderedTask {
    return ORKOrderedTask.audioTaskWithIdentifier("AudioTask", intendedUseDescription: "A sentence prompt will be given to you to read.", speechInstruction: "These are the last dying words of Joseph of Aramathea", shortSpeechInstruction: "The Holy Grail can be found in the Castle of Aaaaaaaaaaah", duration: 10, recordingSettings: nil, options:[])
}
