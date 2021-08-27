import wso2/gateway;
import ballerina/lang.'object;

const string MAIN_MUSTACHE = "Main";
int totalResourceLength = 0;
string projectName = "";
public function main() {
    gateway:initNativeImpLog4jConfig();
    boolean isRequestValidationEnabled  = gateway:getConfigBooleanValue(gateway:VALIDATION_CONFIG_INSTANCE_ID,
    gateway:REQUEST_VALIDATION_ENABLED, gateway:DEFAULT_REQUEST_VALIDATION_ENABLED);
    boolean isResponseValidationEnabled  = gateway:getConfigBooleanValue(gateway:VALIDATION_CONFIG_INSTANCE_ID,
    gateway:RESPONSE_VALIDATION_ENABLED, gateway:DEFAULT_RESPONSE_VALIDATION_ENABLED);
    
    get_OpenAPI_space_definition__v0_service();
    
    error? err = gateway:extractJAR(projectName);
    if (err is error) {
        gateway:printError(gateway:MAIN, "Error when retrieving the resources artifacts", err);
    }
    gateway:initiateInterceptorArray(totalResourceLength);
    initInterceptorIndexes();
    addTokenServicesFilterAnnotation();
    gateway:startObservabilityListener();

        map<string> receivedRevokedTokenMap = gateway:getRevokedTokenMap();
    boolean jmsListenerStarted = gateway:initiateTokenRevocationJmsListener();

    string persistType = gateway:getConfigValue(gateway:PERSISTENT_MESSAGE_INSTANCE_ID,
        gateway:PERSISTENT_MESSAGE_TYPE, gateway:DEFAULT_PERSISTENT_TYPE);
    boolean useDefault = gateway:getConfigBooleanValue(gateway:PERSISTENT_MESSAGE_INSTANCE_ID,
            gateway:PERSISTENT_USE_DEFAULT, gateway:DEFAULT_PERSISTENT_USE_DEFAULT);

    if (persistType == "default") {
        future<()> initJwtRetriveal = start gateway:registerRevokedJwtRetrievalTask();
    } else if (persistType == "etcd" || useDefault ) {
        future<()> initETCDRetriveal = start gateway:etcdRevokedTokenRetrieverTask();
    } else {
        initiatePersistentRevokedTokenRetrieval(receivedRevokedTokenMap);
    }

    startupExtension();

    future<()> callhome = start gateway:invokeCallHome();
}


public function get_OpenAPI_space_definition__v0_service() {
    string[] OpenAPI_space_definition__v0_service = [ "postaa20f669ccc44dddb0e3f77b1d0f3e97"
                                , "get39d1b4032f98461a8a1586df03162d90"
                                ];
    totalResourceLength = totalResourceLength +  OpenAPI_space_definition__v0_service.length();
    gateway:populateAnnotationMaps("OpenAPI_space_definition__v0", OpenAPI_space_definition__v0, OpenAPI_space_definition__v0_service);
    projectName = "JWTDemo";
    
}


public function initInterceptorIndexes() {
    
    initInterceptorIndexesOpenAPI_space_definition__v0();
    
}

listener ObjectName jmsListener = new(); // This will be your normal listeners like http listner...
type ObjectName object {
    *'object:Listener;
    public function __attach(service s, string? name) returns error? {
    }
    public function __detach(service s) returns error? {
    }
    public function __start() returns error? {
        gateway:printDebug(MAIN_MUSTACHE, "Initializing throttling policies");
        initThrottlePolicies();
        gateway:printDebug(MAIN_MUSTACHE, "Initializing Notification JMS Listener");
        _ = start gateway:initiateNotificationJmsListener();
        gateway:printDebug(MAIN_MUSTACHE, "Initializing Throttle Data Publisher");
        gateway:initThrottleDataPublisher();
        gateway:printDebug(MAIN_MUSTACHE, "Initializing Global Throttle Data Publisher");
        gateway:initGlobalThrottleDataPublisher();
    }
    public function __gracefulStop() returns error? {
    }
    public function __immediateStop() returns error? {
    }
};

