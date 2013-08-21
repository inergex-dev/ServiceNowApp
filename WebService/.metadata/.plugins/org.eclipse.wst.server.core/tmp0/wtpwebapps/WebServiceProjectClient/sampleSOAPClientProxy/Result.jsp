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
        String open_3id=  request.getParameter("open20");
        boolean open_3idTemp  = Boolean.valueOf(open_3id).booleanValue();
        java.lang.String getTickets13mtemp = sampleSOAPClientProxyid.getTickets(user_1idTemp,pass_2idTemp,open_3idTemp);
if(getTickets13mtemp == null){
%>
<%=getTickets13mtemp %>
<%
}else{
        String tempResultreturnp14 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(getTickets13mtemp));
        %>
        <%= tempResultreturnp14 %>
        <%
}
break;
case 22:
        gotMethod = true;
        String user_4id=  request.getParameter("user25");
            java.lang.String user_4idTemp = null;
        if(!user_4id.equals("")){
         user_4idTemp  = user_4id;
        }
        String pass_5id=  request.getParameter("pass27");
            java.lang.String pass_5idTemp = null;
        if(!pass_5id.equals("")){
         pass_5idTemp  = pass_5id;
        }
        boolean authenticatLogin22mtemp = sampleSOAPClientProxyid.authenticatLogin(user_4idTemp,pass_5idTemp);
        String tempResultreturnp23 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(authenticatLogin22mtemp));
        %>
        <%= tempResultreturnp23 %>
        <%
break;
case 29:
        gotMethod = true;
        String user_6id=  request.getParameter("user32");
            java.lang.String user_6idTemp = null;
        if(!user_6id.equals("")){
         user_6idTemp  = user_6id;
        }
        String pass_7id=  request.getParameter("pass34");
            java.lang.String pass_7idTemp = null;
        if(!pass_7id.equals("")){
         pass_7idTemp  = pass_7id;
        }
        String short_description_8id=  request.getParameter("short_description36");
            java.lang.String short_description_8idTemp = null;
        if(!short_description_8id.equals("")){
         short_description_8idTemp  = short_description_8id;
        }
        String comments_9id=  request.getParameter("comments38");
            java.lang.String comments_9idTemp = null;
        if(!comments_9id.equals("")){
         comments_9idTemp  = comments_9id;
        }
        java.lang.String createIncident29mtemp = sampleSOAPClientProxyid.createIncident(user_6idTemp,pass_7idTemp,short_description_8idTemp,comments_9idTemp);
if(createIncident29mtemp == null){
%>
<%=createIncident29mtemp %>
<%
}else{
        String tempResultreturnp30 = org.eclipse.jst.ws.util.JspUtils.markup(String.valueOf(createIncident29mtemp));
        %>
        <%= tempResultreturnp30 %>
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