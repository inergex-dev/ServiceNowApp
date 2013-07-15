/**
 * SOAPClient.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.inergex.servicenow.test;

public interface SOAPClient extends java.rmi.Remote {
    public java.lang.String getTickets(java.lang.String user, java.lang.String pass, boolean open) throws java.rmi.RemoteException;
    public boolean authenticatLogin(java.lang.String user, java.lang.String pass) throws java.rmi.RemoteException;
    public java.lang.String createIncident(java.lang.String user, java.lang.String pass, java.lang.String short_description, java.lang.String comments) throws java.rmi.RemoteException;
}
