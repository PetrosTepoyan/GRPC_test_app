//
//  ViewController.swift
//  GRPC_test_app
//
//  Created by Петрос Тепоян on 8/19/21.
//

import UIKit
import SocketsGRPC

let isiPhone12Pro: Bool = UIDevice.current.name == "iPhone 12 Pro"
var myiD: Int64 = isiPhone12Pro ? 1516239023 : 1516239022
var myToken: String = isiPhone12Pro ? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyM30.ZkQ57ZnrYjr7-C607jGm4TnSt_Ia3D_yTFgZZfAQJl0" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyMn0.zI7GSyiBdaZNJyzIFzUkmR3wEr0u0z7N3QDinuTj9sQ"

var otheriD: Int64 = !isiPhone12Pro ? 1516239023 : 1516239022
var otherToken: String = !isiPhone12Pro ? "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyM30.ZkQ57ZnrYjr7-C607jGm4TnSt_Ia3D_yTFgZZfAQJl0" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyMn0.zI7GSyiBdaZNJyzIFzUkmR3wEr0u0z7N3QDinuTj9sQ"




class ViewController: UIViewController {

    @IBOutlet weak var myIdLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
	@IBOutlet weak var messageTextField: UITextField!
	
    var sendingManager: SendingManager!
    
	override func viewDidLoad() {
		super.viewDidLoad()
        sendingManager = .init(delegate: self)
        myIdLabel.text = "My id: \(myiD)"
		
        /*
        1516239023 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyM30.ZkQ57ZnrYjr7-C607jGm4TnSt_Ia3D_yTFgZZfAQJl0
        1516239022 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyMn0.zI7GSyiBdaZNJyzIFzUkmR3wEr0u0z7N3QDinuTj9sQ
         */
        
	}

	@IBAction func sendButtonTouchUpInside(_ sender: Any) {
        guard let text = messageTextField.text else { return }
        
        sendingManager.sendTextMessage(from: myiD, to: otheriD, text: text)
        print("Did send message")
		messageTextField.text = nil
	}
	
}

extension ViewController : GRPCProtocol {
    func didReciveMessageText(message: String?) {
        print("did receive message text", message as Any)
        messageLabel.text = message
    }
    
    func didReciveMessageChronicle(message: String?) {
        print("did receive message text chronicle", message as Any)
    }
    
    func didReceiveMessage(message: MessageEntity) {
        print("did receive message", message)
        messageLabel.text = "New message arrived"
        
    }
    
    
}

