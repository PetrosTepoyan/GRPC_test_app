//
//  SendingManager.swift
//  Sfera
//
//  Created by Петрос Тепоян on 7/28/21.
//  Copyright © 2021 Sfera. All rights reserved.
//

import Foundation
import SocketsGRPC

class SendingManager {
	
	static let shared = SendingManager()
	
    let queue = DispatchQueue(label: "messages.incoming.background", attributes: [.concurrent])
    private var priorityQueue: PriorityQueue<NetworkTask> = .init()
    
    private var socketGRPC: SocketsGRPC!
    
    init(delegate: GRPCProtocol) {
        self.socketGRPC = SocketsGRPC(delegate: delegate, token: myToken)
    }
    
    private init() {
        self.socketGRPC = SocketsGRPC(delegate: self, token: myToken)
    }
    
    func setDelegate(_ delegate: GRPCProtocol) {
//        self.socketGRPC.delegate = delegate
    }
    
    func sendTextMessage(from: Int64, to: Int64, text: String) {
        let message = MessageEntity(from: from,
                                    to: to,
                                    type: .text,
                                    text: text,
                                    status: .recieved,
                                    chatType: .direct,
                                    content: nil)
        self.socketGRPC.sendMessage(from: from, to: to, message: message)
        let networkTask = NetworkTask(priority: .middle, block: {
            self.socketGRPC.sendMessage(from: from, to: to, message: message)
        })
        
        priorityQueue.enqueue(networkTask)
        networkTask.execute()
    }
}

extension SendingManager: GRPCProtocol {
    func didReciveMessageText(message: String?) {
        print(#function, message as Any)
    }
    
    func didReciveMessageChronicle(message: String?) {
        print(#function, message as Any)
    }
    
    func didReceiveMessage(message: MessageEntity) {
        print(#function, message)
        
    }
    
}

class NetworkTask: Prioritizable {
	@PriorityWrapper var priority: Priority = 1
	var id: UUID = UUID()
	var queueDelegate: PriotiyQueueNetworkTaskDelegate?
    var workItem: DispatchWorkItem!
    
    private var dispatchQueue: DispatchQueue = SendingManager.shared.queue
    
    init(priority: Priority, block: @escaping () -> Void) {
        self.priority = priority
        self.workItem = DispatchWorkItem(block: block)
        self.workItem.notify(queue: .main) {
            self.queueDelegate?.didFinish(task: self)
        }
	}
    
    func execute() {
        dispatchQueue.async(execute: workItem)
    }
    
    func cancel() {
        self.workItem.cancel()
    }
	
	func increasePriority(by stride: Int = 1) {
		priority += stride
		queueDelegate?.didChangePriority(for: self, priority: priority)
	}
	
	func decreasePriority(by stride: Int = 1) {
		priority -= stride
		queueDelegate?.didChangePriority(for: self, priority: priority)
	}
	
	func setPriority(to value: Priority) {
		priority = value
		queueDelegate?.didChangePriority(for: self, priority: priority)
	}
}

extension NetworkTask: Comparable, Equatable {
	static func < (lhs: NetworkTask, rhs: NetworkTask) -> Bool {
		lhs.priority < rhs.priority
	}
	
	static func == (lhs: NetworkTask, rhs: NetworkTask) -> Bool {
		lhs.priority == rhs.priority && lhs.id == rhs.id
	}
}

extension NetworkTask: CustomStringConvertible {
    var description: String {
        return "NetworkTask(priority: \(priority))"
    }
}
