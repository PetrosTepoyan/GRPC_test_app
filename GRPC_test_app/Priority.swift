//
//  Priority.swift
//  Sfera
//
//  Created by Петрос Тепоян on 8/17/21.
//  Copyright © 2021 Sfera. All rights reserved.
//

import Foundation

protocol Prioritizable : AnyObject, Comparable {
    var id: UUID { get }
	var priority: Priority { get }
	var queueDelegate: PriotiyQueueNetworkTaskDelegate? { get set }
    
    func increasePriority(by stride: Int)
    
    func decreasePriority(by stride: Int)
    
    func setPriority(to value: Priority)
}

typealias Priority = Int

extension Priority {
	static let highest: Priority = 10
    static let middle: Priority = 5
	static let lowest: Priority = 1
}

@propertyWrapper
struct PriorityWrapper {
	private var priority: Priority
	private let minValue: Priority = .highest
	private let maxValue: Priority = .lowest
	
	var wrappedValue: Priority {
		set {
			priority = max(minValue, min(newValue, maxValue))
		}
		get {
			return priority
		}
	}
	
	init(wrappedValue: Priority) {
		self.priority = wrappedValue
	}
}
