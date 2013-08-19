<%@page contentType="text/html;charset=UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<HTML>
<HEAD>
<TITLE>Result</TITLE>
</HEAD>
<BODY>
<H1>Result</H1>

<jsp:useBean id="sampleSOAPClientProxyid" scope="session" class="com.inergex.servicenow.test.SOAPClientProxy" />
<%
if (request.getParameter("endpoint") != null && request.getParameter("endpoint").length() > 0)
sampleSOAPClientProxyid.setEndpoint(request.getParameter("endpoint"));
%>

<%
String method = request.getParameter("method");
int methodID = 0;
if (method == null) methodID = -1;

if(methodID != -1) methodID = Integer.parseInt(method);
boolean gotMethod = false;

try {
switch (methodID){ 
case 2:
        gotMethod = true;
        java.lang.String getEndpoint2mtemp = sampleSOAPClientProxyid.getEndpoint();
if(getEndpoint2mtemp == null){
%>
<%=getEndpoint2mtemp %>
<%
}else{
        String tempResultreturnp3 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(getEndpoint2mtemp));
        %>
        <%= tempResultreturnp3 %>
        <%
}
break;
case 5:
        gotMethod = true;
        String endpoint_0id=  request.getParameter("endpoint8");
            java.lang.String endpoint_0idTemp = null;
        if(!endpoint_0id.equals("")){
         endpoint_0idTemp  = endpoint_0id;
        }
        sampleSOAPClientProxyid.setEndpoint(endpoint_0idTemp);
break;
case 10:
        gotMethod = true;
        com.inergex.servicenow.test.SOAPClient getSOAPClient10mtemp = sampleSOAPClientProxyid.getSOAPClient();
if(getSOAPClient10mtemp == null){
%>
<%=getSOAPClient10mtemp %>
<%
}else{
        if(getSOAPClient10mtemp!= null){
        String tempreturnp11 = getSOAPClient10mtemp.toString();
        %>
        <%=tempreturnp11%>
        <%
        }}
break;
case 13:
        gotMethod = true;
        String user_1id=  request.getParameter("user16");
            java.lang.String user_1idTemp = null;
        if(!user_1id.equals("")){
         user_1idTemp  = user_1id;
        }
        String pass_2id=  request.getParameter("pass18");
            java.lang.String pass_2idTemp = null;
        if(!pass_2id.equals("")){
         pass_2idTemp  = pass_2id;
        }
        boolean authenticatLogin13mtemp = sampleSOAPClientProxyid.authenticatLogin(user_1idTemp,pass_2idTemp);
        String tempResultreturnp14 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(authenticatLogin13mtemp));
        %>
        <%= tempResultreturnp14 %>
        <%
break;
case 20:
        gotMethod = true;
        String user_3id=  request.getParameter("user23");
            java.lang.String user_3idTemp = null;
        if(!user_3id.equals("")){
         user_3idTemp  = user_3id;
        }
        String pass_4id=  request.getParameter("pass25");
            java.lang.String pass_4idTemp = null;
        if(!pass_4id.equals("")){
         pass_4idTemp  = pass_4id;
        }
        String short_description_5id=  request.getParameter("short_description27");
            java.lang.String short_description_5idTemp = null;
        if(!short_description_5id.equals("")){
         short_description_5idTemp  = short_description_5id;
        }
        String comments_6id=  request.getParameter("comments29");
            java.lang.String comments_6idTemp = null;
        if(!comments_6id.equals("")){
         comments_6idTemp  = comments_6id;
        }
        java.lang.String createIncident20mtemp = sampleSOAPClientProxyid.createIncident(user_3idTemp,pass_4idTemp,short_description_5idTemp,comments_6idTemp);
if(createIncident20mtemp == null){
%>
<%=createIncident20mtemp %>
<%
}else{
        String tempResultreturnp21 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(createIncident20mtemp));
        %>
        <%= tempResultreturnp21 %>
        <%
}
break;
case 31:
        gotMethod = true;
        String user_7id=  request.getParameter("user34");
            java.lang.String user_7idTemp = null;
        if(!user_7id.equals("")){
         user_7idTemp  = user_7id;
        }
        String pass_8id=  request.getParameter("pass36");
            java.lang.String pass_8idTemp = null;
        if(!pass_8id.equals("")){
         pass_8idTemp  = pass_8id;
        }
        String open_9id=  request.getParameter("open38");
        boolean open_9idTemp  = Boolean.valueOf(open_9id).booleanValue();
        java.lang.String getTickets31mtemp = sampleSOAPClientProxyid.getTickets(user_7idTemp,pass_8idTemp,open_9idTemp);
if(getTickets31mtemp == null){
%>
<%=getTickets31mtemp %>
<%
}else{
        String tempResultreturnp32 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(getTickets31mtemp));
        %>
        <%= tempResultreturnp32 %>
        <%
}
break;
}
} catch (Exception e) { 
%>
Exception: <%= org.eclipse.jst.ws.util.JspUtils.markup(e.toString()) %>
Message: <%= org.eclipse.jst.ws.util.JspUtils.markup(e.getMessage()) %>
<%
return;
}
if(!gotMethod){
%>
result: N/A
<%
}
%>
</BODY>
</HTML>