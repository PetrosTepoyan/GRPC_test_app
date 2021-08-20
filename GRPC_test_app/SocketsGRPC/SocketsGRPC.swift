//
//  File.swift
//  
//
//  Created by Алексей Плакош on 21.06.2021.
//

import Foundation
//import StorageManager
import GRPC


typealias Request = Service_StreamRequest
typealias Response = Service_StreamResponse
typealias StreamingRecognizeCall = BidirectionalStreamingCall

public protocol SocketsGRPCProtocol {
    func connect()
    func sendMessage(from: Int64?, to: Int64?, message: MessageEntity?)
}

public protocol GRPCProtocol {
    func didReciveMessageText(message: String?)
    func didReciveMessageChronicle(message: String?)
	func didReceiveMessage(message: MessageEntity)
}

enum State {
    case idle
    case streaming(StreamingRecognizeCall<Request, Response>)
}

public class SocketsGRPC: SocketsGRPCProtocol {
    private var state : State = .idle
    private var delegate : GRPCProtocol!
    private var callOptions: CallOptions!
    var client : Service_ChatClient!
	
	let streamQueue: DispatchQueue = DispatchQueue(label: "stream.messages.sfera", attributes: [.concurrent])

    public init(delegate: GRPCProtocol) {
        self.delegate = delegate
        callOptions = CallOptions(customMetadata: [
              "authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyM30.ZkQ57ZnrYjr7-C607jGm4TnSt_Ia3D_yTFgZZfAQJl0"
            ])
        connect()
    }
    
    deinit {
        _ = client.channel.close()
    }
    
    /*
     1516239023 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyM30.ZkQ57ZnrYjr7-C607jGm4TnSt_Ia3D_yTFgZZfAQJl0
     1516239022 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyMn0.zI7GSyiBdaZNJyzIFzUkmR3wEr0u0z7N3QDinuTj9sQ
     1516239024 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyNH0.UrHaHvk5xyDoSjshgzf7ancQcgxQmNWtOfiBHMumysI
     1516239025 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyNX0.DbRfcFXQnRzT5MuW5uIjeuGbbnn-CVtM2-4PX55qneI
     1516239026 eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyNn0.TlDrYtcZgKyxv7K0ZjSaN06kSSunjetI2qyJmZ4xIrU
     */
    
    public func connect() {
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        let channel = ClientConnection.insecure(group: group)
            .connect(host: "core.test.sfera-app.ru", port: 30120)
        channel.connectivity.delegate = self
        client = Service_ChatClient(channel: channel, defaultCallOptions: callOptions, interceptors: nil)
        sendMessage()
    }
    
    public func sendMessage(from: Int64? = nil, to: Int64? = nil, message: MessageEntity? = nil) {
		streamQueue.async { [weak self] in
            guard let self = self else {return}
            switch self.state {
            case .idle :
				let call = self.makeCall()
                self.state = .streaming(call)
                let request = Request.with {
                    $0.auth.token.text = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJRCI6MTUxNjIzOTAyM30.ZkQ57ZnrYjr7-C607jGm4TnSt_Ia3D_yTFgZZfAQJl0"
                }
                print("GRPC: IDL send \"\(request.message)")
                call.sendMessage(request, promise: nil)
                _ = try! call.status.wait()
                break
            case .streaming(let call):
                let request = Request.with {
                    $0.message.id = UUID().uuidString
                    $0.message.from = from ?? 0
                    $0.message.to = to ?? 0
                }
                print("GRPC: STR send \"\(request.message)")
                call.sendMessage(request, promise: nil)
                break
            }
        }
    }
	
	private func makeCall() -> StreamingRecognizeCall<Request, Response> {
		return self.client.stream(callOptions: self.callOptions) { [weak self] response in
			
			DispatchQueue.main.async {
				self?.delegate.didReceiveMessage(message: response.message as MessageEntity)
			}
			
			switch response.message.content {
				case let .choose(service_choose):
					let choose = service_choose as MTChoose
					print("GRPC:", choose)
				case let .chronicle(chronicle):
					print("GRPC:", chronicle)
				case let .forward(forward):
					print("GRPC:", forward)
				case let .media(media):
					print("GRPC:", media)
				case let .moment(moment):
					print("GRPC:", moment)
				case let .news(news):
					print("GRPC:", news)
				case let .profile(profile):
					print("GRPC:", profile)
				case let .profilePhoto(profilePhoto):
					print("GRPC:", profilePhoto)
				case let .quote(quote):
					print("GRPC:", quote)
				case let .text(text):
					print("GRPC:", text)
					DispatchQueue.main.async {
						self?.delegate.didReciveMessageText(message: text.text)
					}
				default:
					fatalError("Wrong content type")
			}
			
		}
	}
}

extension SocketsGRPC : ConnectivityStateDelegate {
    public func connectivityStateDidChange(from oldState: ConnectivityState, to newState: ConnectivityState) {
        print("GRPC:", oldState)
        print("GRPC:", newState)
    }
}
