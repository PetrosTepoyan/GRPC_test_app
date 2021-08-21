//
//  PriorityQueue.swift
//  Sfera
//
//  Created by Петрос Тепоян on 7/28/21.
//  Copyright © 2021 Sfera. All rights reserved.
//

import Foundation


/*
Example: [Task1(10), Task2(10), Task6(6), Task3(3)]
Here, Task
*/

class PriorityQueue<PriorityElement : Prioritizable>: Collection {
	
	fileprivate var elements: [PriorityElement] = []
	
	typealias Element = PriorityElement
	typealias Index = Int
	
	// The upper and lower bounds of the collection, used in iterations
	var startIndex: Index { return elements.startIndex }
	var endIndex: Index { return elements.endIndex }
	
	// Required subscript, based on a dictionary index
	subscript(index: Index) -> Iterator.Element {
		get { return elements[index] }
	}
	
	// Method that returns the next index when iterating
	func index(after i: Index) -> Index {
		return elements.index(after: i)
	}
}

//extension PriorityQueue: ExpressibleByArrayLiteral {
//	typealias ArrayLiteralElement = PriorityElement
//    convenience init(arrayLiteral elements: Self.ArrayLiteralElement...) {
//
//    }
//}

extension PriorityQueue: CustomStringConvertible {
    var description: String {
        return elements.description
    }
}


private protocol QueueStructurable {
	associatedtype Element
	mutating func enqueue(_ element: Element)
	mutating func dequeue() -> Element?
	var isEmpty: Bool { get }
	var peek: Element? { get }
}

extension PriorityQueue: QueueStructurable {
    func enqueue(_ element: PriorityElement) {
		
        element.queueDelegate = self
        
		if element.priority == .highest {
			elements.insert(element, at: 0)
			return
		}
		
		guard !isEmpty || element.priority == .lowest else {
			elements.append(element)
			return
		}
		
		guard let indexToInsert = elements
				.firstIndex(where: { $0.priority <= element.priority}) else {
			elements.append(element)
			return
		}
		
		elements.insert(element, at: indexToInsert)
	}
	
    func dequeue() -> PriorityElement? {
		isEmpty ? nil : elements.removeFirst()
	}
	
    func prioritySort() {
		let sortedArray = self.sorted(by: { $0.priority < $1.priority })
        self.elements.removeAll()
        self.elements.append(contentsOf: sortedArray)
	}
	
	var isEmpty: Bool {
		elements.isEmpty
	}
	
	var peek: PriorityElement? {
		elements.first
	}
}

protocol PriotiyQueueNetworkTaskDelegate {
	func didChangePriority(for task: NetworkTask, priority: Priority)
    func didFinish(task: NetworkTask)
}

extension PriorityQueue: PriotiyQueueNetworkTaskDelegate {
    func didFinish(task: NetworkTask) {
        self.elements.removeAll { $0.id == task.id }
        guard !isEmpty, let nextTask = peek as? NetworkTask else { return }
        nextTask.execute()
    }
    
	func didChangePriority(for task: NetworkTask, priority: Priority) {
		self.prioritySort()
	}
}
