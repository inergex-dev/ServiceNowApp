package com.inergex.servicenow.test;

public class SOAPClientProxy implements com.inergex.servicenow.test.SOAPClient {
  private String _endpoint = null;
  private com.inergex.servicenow.test.SOAPClient sOAPClient = null;
  
  public SOAPClientProxy() {
    _initSOAPClientProxy();
  }
  
  public SOAPClientProxy(String endpoint) {
    _endpoint = endpoint;
    _initSOAPClientProxy();
  }
  
  private void _initSOAPClientProxy() {
    try {
      sOAPClient = (new com.inergex.servicenow.test.SOAPClientServiceLocator()).getSOAPClient();
      if (sOAPClient != null) {
        if (_endpoint != null)
          ((javax.xml.rpc.Stub)sOAPClient)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
        else
          _endpoint = (String)((javax.xml.rpc.Stub)sOAPClient)._getProperty("javax.xml.rpc.service.endpoint.address");
      }
      
    }
    catch (javax.xml.rpc.ServiceException serviceException) {}
  }
  
  public String getEndpoint() {
    return _endpoint;
  }
  
  public void setEndpoint(String endpoint) {
    _endpoint = endpoint;
    if (sOAPClient != null)
      ((javax.xml.rpc.Stub)sOAPClient)._setProperty("javax.xml.rpc.service.endpoint.address", _endpoint);
    
  }
  
  public com.inergex.servicenow.test.SOAPClient getSOAPClient() {
    if (sOAPClient == null)
      _initSOAPClientProxy();
    return sOAPClient;
  }
  
  public java.lang.String getTickets(java.lang.String user, java.lang.String pass, boolean open) throws java.rmi.RemoteException{
    if (sOAPClient == null)
      _initSOAPClientProxy();
    return sOAPClient.getTickets(user, pass, open);
  }
  
  public boolean authenticatLogin(java.lang.String user, java.lang.String pass) throws java.rmi.RemoteException{
    if (sOAPClient == null)
      _initSOAPClientProxy();
    return sOAPClient.authenticatLogin(user, pass);
  }
  
  public java.lang.String createIncident(java.lang.String user, java.lang.String pass, java.lang.String short_description, java.lang.String comments) throws java.rmi.RemoteException{
    if (sOAPClient == null)
      _initSOAPClientProxy();
    return sOAPClient.createIncident(user, pass, short_description, comments);
  }
  
  
}