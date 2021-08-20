//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: messages.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import SwiftProtobuf


/// Usage: instantiate `Service_ChatClient`, then call methods of this protocol to make API calls.
internal protocol Service_ChatClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: Service_ChatClientInterceptorFactoryProtocol? { get }

  func stream(
    callOptions: CallOptions?,
    handler: @escaping (Service_StreamResponse) -> Void
  ) -> BidirectionalStreamingCall<Service_StreamRequest, Service_StreamResponse>

  func sendMessage(
    _ request: Service_Message,
    callOptions: CallOptions?
  ) -> UnaryCall<Service_Message, Service_MessageResponse>
}

extension Service_ChatClientProtocol {
  internal var serviceName: String {
    return "service.Chat"
  }

  /// Bidirectional streaming call to Stream
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata and status.
  internal func stream(
    callOptions: CallOptions? = nil,
    handler: @escaping (Service_StreamResponse) -> Void
  ) -> BidirectionalStreamingCall<Service_StreamRequest, Service_StreamResponse> {
    return self.makeBidirectionalStreamingCall(
      path: "/service.Chat/Stream",
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeStreamInterceptors() ?? [],
      handler: handler
    )
  }

  /// Unary call to SendMessage
  ///
  /// - Parameters:
  ///   - request: Request to send to SendMessage.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  internal func sendMessage(
    _ request: Service_Message,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<Service_Message, Service_MessageResponse> {
    return self.makeUnaryCall(
      path: "/service.Chat/SendMessage",
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSendMessageInterceptors() ?? []
    )
  }
}

internal protocol Service_ChatClientInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when invoking 'stream'.
  func makeStreamInterceptors() -> [ClientInterceptor<Service_StreamRequest, Service_StreamResponse>]

  /// - Returns: Interceptors to use when invoking 'sendMessage'.
  func makeSendMessageInterceptors() -> [ClientInterceptor<Service_Message, Service_MessageResponse>]
}

internal final class Service_ChatClient: Service_ChatClientProtocol {
  internal let channel: GRPCChannel
  internal var defaultCallOptions: CallOptions
  internal var interceptors: Service_ChatClientInterceptorFactoryProtocol?

  /// Creates a client for the service.Chat service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  internal init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: Service_ChatClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

/// To build a server, implement a class that conforms to this protocol.
internal protocol Service_ChatProvider: CallHandlerProvider {
  var interceptors: Service_ChatServerInterceptorFactoryProtocol? { get }

  func stream(context: StreamingResponseCallContext<Service_StreamResponse>) -> EventLoopFuture<(StreamEvent<Service_StreamRequest>) -> Void>

  func sendMessage(request: Service_Message, context: StatusOnlyCallContext) -> EventLoopFuture<Service_MessageResponse>
}

extension Service_ChatProvider {
  internal var serviceName: Substring { return "service.Chat" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "Stream":
      return BidirectionalStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Service_StreamRequest>(),
        responseSerializer: ProtobufSerializer<Service_StreamResponse>(),
        interceptors: self.interceptors?.makeStreamInterceptors() ?? [],
        observerFactory: self.stream(context:)
      )

    case "SendMessage":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Service_Message>(),
        responseSerializer: ProtobufSerializer<Service_MessageResponse>(),
        interceptors: self.interceptors?.makeSendMessageInterceptors() ?? [],
        userFunction: self.sendMessage(request:context:)
      )

    default:
      return nil
    }
  }
}

internal protocol Service_ChatServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'stream'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeStreamInterceptors() -> [ServerInterceptor<Service_StreamRequest, Service_StreamResponse>]

  /// - Returns: Interceptors to use when handling 'sendMessage'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeSendMessageInterceptors() -> [ServerInterceptor<Service_Message, Service_MessageResponse>]
}