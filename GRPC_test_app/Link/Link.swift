import AsapManager
import AuthorizationManager

public class LinkApp {
    public var asap : AsapServiceProtocol
    public var autorization : AuthorizationProtocol

    public init() {
        autorization = AuthorizationService()
        asap = AsapService()
    }
}
