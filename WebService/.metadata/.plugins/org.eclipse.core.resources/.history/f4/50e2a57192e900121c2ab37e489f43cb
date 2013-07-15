/**
 * SOAPClientServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.inergex.servicenow.test;

public class SOAPClientServiceLocator extends org.apache.axis.client.Service implements com.inergex.servicenow.test.SOAPClientService {

    public SOAPClientServiceLocator() {
    }


    public SOAPClientServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public SOAPClientServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for SOAPClient
    private java.lang.String SOAPClient_address = "http://localhost:8080/WebServiceProject/services/SOAPClient";

    public java.lang.String getSOAPClientAddress() {
        return SOAPClient_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String SOAPClientWSDDServiceName = "SOAPClient";

    public java.lang.String getSOAPClientWSDDServiceName() {
        return SOAPClientWSDDServiceName;
    }

    public void setSOAPClientWSDDServiceName(java.lang.String name) {
        SOAPClientWSDDServiceName = name;
    }

    public com.inergex.servicenow.test.SOAPClient getSOAPClient() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(SOAPClient_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getSOAPClient(endpoint);
    }

    public com.inergex.servicenow.test.SOAPClient getSOAPClient(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.inergex.servicenow.test.SOAPClientSoapBindingStub _stub = new com.inergex.servicenow.test.SOAPClientSoapBindingStub(portAddress, this);
            _stub.setPortName(getSOAPClientWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setSOAPClientEndpointAddress(java.lang.String address) {
        SOAPClient_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.inergex.servicenow.test.SOAPClient.class.isAssignableFrom(serviceEndpointInterface)) {
                com.inergex.servicenow.test.SOAPClientSoapBindingStub _stub = new com.inergex.servicenow.test.SOAPClientSoapBindingStub(new java.net.URL(SOAPClient_address), this);
                _stub.setPortName(getSOAPClientWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("SOAPClient".equals(inputPortName)) {
            return getSOAPClient();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://test.servicenow.inergex.com", "SOAPClientService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://test.servicenow.inergex.com", "SOAPClient"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("SOAPClient".equals(portName)) {
            setSOAPClientEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
