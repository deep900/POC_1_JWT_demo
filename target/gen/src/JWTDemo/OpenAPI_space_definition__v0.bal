import ballerina/http;
import ballerina/time;
import ballerina/runtime;

import wso2/gateway;


    
http:Client OpenAPI_space_definition__v0_prod = new (
gateway:retrieveConfig("api_ea4821b381c1b9410c11d138d321befbcadfd7af8258e6dd328022cb5fe46b92_prod_endpoint_0","http://172.17.0.2:8080"),
{ 
httpVersion: gateway:getClientsHttpVersion()
, responseLimits : {
         maxStatusLineLength : gateway:getConfigIntValue(gateway:HTTP_CLIENTS_RESPONSE_LIMITS_CONFIG_INSTANCE_ID,
                    gateway:HTTP_CLIENTS_RESPONSE_MAX_STATUS_LINE_LENGTH, gateway:DEFAULT_HTTP_CLIENTS_RESPONSE_MAX_STATUS_LINE_LENGTH),
         maxHeaderSize : gateway:getConfigIntValue(gateway:HTTP_CLIENTS_RESPONSE_LIMITS_CONFIG_INSTANCE_ID,
                    gateway:HTTP_CLIENTS_RESPONSE_MAX_HEADER_SIZE, gateway:DEFAULT_HTTP_CLIENTS_RESPONSE_MAX_HEADER_SIZE),
         maxEntityBodySize: gateway:getConfigIntValue(gateway:HTTP_CLIENTS_RESPONSE_LIMITS_CONFIG_INSTANCE_ID,
                    gateway:HTTP_CLIENTS_RESPONSE_MAX_ENTITY_BODY_SIZE, gateway:DEFAULT_HTTP_CLIENTS_RESPONSE_MAX_ENTITY_BODY_SIZE)
  }
,
    cache: { enabled: false }


,
secureSocket: gateway:getClientSecureSocket()

,
    poolConfig: gateway:getClientPoolConfig(true, 0, -1, -1, -1)


, http1Settings : {
    proxy: gateway:getClientProxyConfig()
}


});









    
    
    
    
    
    

    
    

    
    


    
    
    
    
    
    

    
    

    
    



//This variable is added for logging purposes
string OpenAPI_space_definition__v0Key = "OpenAPI definition-v0";









@http:ServiceConfig {
    basePath: "/carrental/v1",
    auth: {
        authHandlers: gateway:getAuthHandlers(["oauth2","jwt"], false, false)
    }
   
}

@gateway:API {
    publisher:"",
    name:"OpenAPI definition",
    apiVersion: "v0",
    apiTier : "" ,
    authProviders: ["oauth2","jwt"],
    security: {
            "apikey":[],
            "mutualSSL": "",
            "applicationSecurityOptional": false
        }
}
service OpenAPI_space_definition__v0 on apiListener,
apiSecureListener {


    @http:ResourceConfig {
        methods:["POST"],
        path:"/rentCar",
        auth:{
        
            
        
            authHandlers: gateway:getAuthHandlers(["oauth2","jwt"], false, false)
        }
    }
    @gateway:Resource {
        authProviders: ["oauth2","jwt"],
        security: {
            "apikey":[],
            "applicationSecurityOptional": false 
            }
    }
    @gateway:RateLimit{policy : ""}
    resource function postaa20f669ccc44dddb0e3f77b1d0f3e97 (http:Caller outboundEp, http:Request req
) {
        handleExpectHeaderForOpenAPI_space_definition__v0(outboundEp, req);
        runtime:InvocationContext invocationContext = runtime:getInvocationContext();

        map<string> pathParams = { 
        };
        invocationContext.attributes["pathParams"] = pathParams;
        

        
        string urlPostfix = gateway:replaceFirst(req.rawPath,"/carrental/v1","");
        
        if(urlPostfix != "" && !gateway:hasPrefix(urlPostfix, "/")) {
            urlPostfix = "/" + urlPostfix;
        }
        http:Response|error clientResponse;
        http:Response r = new;
        clientResponse = r;
        string destination_attribute;
        invocationContext.attributes["timeStampRequestOut"] = time:currentTime().time;
        boolean reinitRequired = false;
        string failedEtcdKey = "";
        string failedEtcdKeyConfigValue = "";
        boolean|error hasUrlChanged;
        http:ClientConfiguration newConfig;
        boolean reinitFailed = false;
        boolean isProdEtcdEnabled = false;
        boolean isSandEtcdEnabled = false;
        map<string> endpointEtcdConfigValues = {};
        
            
            
                if("PRODUCTION" == <string>invocationContext.attributes["KEY_TYPE"]) {
                
                    
    clientResponse = OpenAPI_space_definition__v0_prod->forward(urlPostfix, <@untainted>req);

invocationContext.attributes["destination"] = gateway:retrieveConfig("api_ea4821b381c1b9410c11d138d321befbcadfd7af8258e6dd328022cb5fe46b92_prod_endpoint_0","http://172.17.0.2:8080");


                
                    } else {
                
                    http:Response res = new;
res.statusCode = 403;
string errorMessage = "Sandbox key offered to the API with no sandbox endpoint";
if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
    json payload = {
        ERROR_CODE: "900901",
        ERROR_MESSAGE: errorMessage
    };
    res.setPayload(payload);
} else {
    gateway:attachGrpcErrorHeaders (res, errorMessage);
}
invocationContext.attributes["error_code"] = "900901";
clientResponse = res;
                
                }
            
        
        
        invocationContext.attributes["timeStampResponseIn"] = time:currentTime().time;


        if(clientResponse is http:Response) {
            

            invocationContext.attributes[gateway:DID_EP_RESPOND] = true;
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                gateway:printError(OpenAPI_space_definition__v0Key, "Error when sending response", outboundResult);
            }
        } else {
            http:Response res = new;
            res.statusCode = 500;
            string errorMessage = clientResponse.reason();
            int errorCode = 101503;
            string errorDescription = "Error connecting to the back end";

            if(gateway:contains(errorMessage, "connection timed out") || gateway:contains(errorMessage,"Idle timeout triggered")) {
                errorCode = 101504;
                errorDescription = "Connection timed out";
            }
            if(gateway:contains(errorMessage, "Malformed URL")) {
                errorCode = 101505;
                errorDescription = "Malformed URL";
            }
            invocationContext.attributes["error_response_code"] = errorCode;
            invocationContext.attributes["error_response"] = errorDescription;
            if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
                json payload = {fault : {
                                code : errorCode,
                                message : "Runtime Error",
                                description : errorDescription
                            }};

                            res.setPayload(payload);
            } else {
                gateway:attachGrpcErrorHeaders (res, errorDescription);
            }
            gateway:printError(OpenAPI_space_definition__v0Key, "Error in client response", clientResponse);
            var outboundResult = outboundEp->respond(res);
            if (outboundResult is error) {
                gateway:printError(OpenAPI_space_definition__v0Key, "Error when sending response", outboundResult);
            }
        }
    }


    @http:ResourceConfig {
        methods:["GET"],
        path:"/getCars",
        auth:{
        
            
        
            authHandlers: gateway:getAuthHandlers(["oauth2","jwt"], false, false)
        }
    }
    @gateway:Resource {
        authProviders: ["oauth2","jwt"],
        security: {
            "apikey":[],
            "applicationSecurityOptional": false 
            }
    }
    @gateway:RateLimit{policy : ""}
    resource function get39d1b4032f98461a8a1586df03162d90 (http:Caller outboundEp, http:Request req
) {
        handleExpectHeaderForOpenAPI_space_definition__v0(outboundEp, req);
        runtime:InvocationContext invocationContext = runtime:getInvocationContext();

        map<string> pathParams = { 
        };
        invocationContext.attributes["pathParams"] = pathParams;
        

        
        string urlPostfix = gateway:replaceFirst(req.rawPath,"/carrental/v1","");
        
        if(urlPostfix != "" && !gateway:hasPrefix(urlPostfix, "/")) {
            urlPostfix = "/" + urlPostfix;
        }
        http:Response|error clientResponse;
        http:Response r = new;
        clientResponse = r;
        string destination_attribute;
        invocationContext.attributes["timeStampRequestOut"] = time:currentTime().time;
        boolean reinitRequired = false;
        string failedEtcdKey = "";
        string failedEtcdKeyConfigValue = "";
        boolean|error hasUrlChanged;
        http:ClientConfiguration newConfig;
        boolean reinitFailed = false;
        boolean isProdEtcdEnabled = false;
        boolean isSandEtcdEnabled = false;
        map<string> endpointEtcdConfigValues = {};
        
            
            
                if("PRODUCTION" == <string>invocationContext.attributes["KEY_TYPE"]) {
                
                    
    clientResponse = OpenAPI_space_definition__v0_prod->forward(urlPostfix, <@untainted>req);

invocationContext.attributes["destination"] = gateway:retrieveConfig("api_ea4821b381c1b9410c11d138d321befbcadfd7af8258e6dd328022cb5fe46b92_prod_endpoint_0","http://172.17.0.2:8080");


                
                    } else {
                
                    http:Response res = new;
res.statusCode = 403;
string errorMessage = "Sandbox key offered to the API with no sandbox endpoint";
if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
    json payload = {
        ERROR_CODE: "900901",
        ERROR_MESSAGE: errorMessage
    };
    res.setPayload(payload);
} else {
    gateway:attachGrpcErrorHeaders (res, errorMessage);
}
invocationContext.attributes["error_code"] = "900901";
clientResponse = res;
                
                }
            
        
        
        invocationContext.attributes["timeStampResponseIn"] = time:currentTime().time;


        if(clientResponse is http:Response) {
            

            invocationContext.attributes[gateway:DID_EP_RESPOND] = true;
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                gateway:printError(OpenAPI_space_definition__v0Key, "Error when sending response", outboundResult);
            }
        } else {
            http:Response res = new;
            res.statusCode = 500;
            string errorMessage = clientResponse.reason();
            int errorCode = 101503;
            string errorDescription = "Error connecting to the back end";

            if(gateway:contains(errorMessage, "connection timed out") || gateway:contains(errorMessage,"Idle timeout triggered")) {
                errorCode = 101504;
                errorDescription = "Connection timed out";
            }
            if(gateway:contains(errorMessage, "Malformed URL")) {
                errorCode = 101505;
                errorDescription = "Malformed URL";
            }
            invocationContext.attributes["error_response_code"] = errorCode;
            invocationContext.attributes["error_response"] = errorDescription;
            if (! invocationContext.attributes.hasKey(gateway:IS_GRPC)) {
                json payload = {fault : {
                                code : errorCode,
                                message : "Runtime Error",
                                description : errorDescription
                            }};

                            res.setPayload(payload);
            } else {
                gateway:attachGrpcErrorHeaders (res, errorDescription);
            }
            gateway:printError(OpenAPI_space_definition__v0Key, "Error in client response", clientResponse);
            var outboundResult = outboundEp->respond(res);
            if (outboundResult is error) {
                gateway:printError(OpenAPI_space_definition__v0Key, "Error when sending response", outboundResult);
            }
        }
    }

}

    function handleExpectHeaderForOpenAPI_space_definition__v0 (http:Caller outboundEp, http:Request req ) {
        if (req.expects100Continue()) {
            req.removeHeader("Expect");
            var result = outboundEp->continue();
            if (result is error) {
            gateway:printError(OpenAPI_space_definition__v0Key, "Error while sending 100 continue response", result);
            }
        }
    }

function getUrlOfEtcdKeyForReInitOpenAPI_space_definition__v0(string defaultUrlRef,string etcdRef, string defaultUrl, string etcdKey) returns string {
    string retrievedEtcdKey = <string> gateway:retrieveConfig(etcdRef,etcdKey);
    map<any> urlChangedMap = gateway:getUrlChangedMap();
    urlChangedMap[<string> retrievedEtcdKey] = false;
    map<string> etcdUrls = gateway:getEtcdUrlsMap();
    string url = <string> etcdUrls[retrievedEtcdKey];
    if (url == "") {
        return <string> gateway:retrieveConfig(defaultUrlRef, defaultUrl);
    } else {
        return url;
    }
}

function respondFromJavaInterceptorOpenAPI_space_definition__v0(runtime:InvocationContext invocationContext, http:Caller outboundEp) returns boolean {
    boolean tryRespond = false;
    if(invocationContext.attributes.hasKey(gateway:RESPOND_DONE) && invocationContext.attributes.hasKey(gateway:RESPONSE_OBJECT)) {
        if(<boolean>invocationContext.attributes[gateway:RESPOND_DONE]) {
            http:Response clientResponse = <http:Response>invocationContext.attributes[gateway:RESPONSE_OBJECT];
            var outboundResult = outboundEp->respond(clientResponse);
            if (outboundResult is error) {
                gateway:printError(OpenAPI_space_definition__v0Key, "Error when sending response from the interceptor", outboundResult);
            }
            tryRespond = true;
        }
    }
    return tryRespond;
}

function initInterceptorIndexesOpenAPI_space_definition__v0() {


    
        

        
        


    
        

        
        


}