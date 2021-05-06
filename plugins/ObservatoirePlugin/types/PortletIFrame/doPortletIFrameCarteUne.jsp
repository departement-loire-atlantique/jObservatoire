<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/portal/doPortletParams.jspf' %>
<% PortletIFrame box = (PortletIFrame) portlet;  %>

<%
	String iframe = box.getSource(userLang);

	// To prevent XSS and phishing attack : Do not allow iframe from request parameter.
	// If you need to enable this feature, make sure to check the parameter retrieved
  // against expected value 
  // iframe = Util.getString(getValidHttpUrl("iframe"),iframe);

	if (Util.isEmpty(iframe)){
		request.setAttribute("ShowPortalElement",Boolean.FALSE);
		return;
	}
%>

<%
AbstractPortletSkinable portletSkinable  = (AbstractPortletSkinable) portlet;
String iframeTitle = Util.notEmpty(portletSkinable.getDisplayTitle(userLang)) ? portletSkinable.getDisplayTitle(userLang) : "";
%>
<div class="ds44-container-large ds44--mobile--m-padding-b">
    <header class="txtcenter ds44--mobile--m-padding-b">
        <h2 class="h2-like center"><%= glp("jcmsplugin.observatoire.carteALaUne") %></h2>
        <p id="sousTitreCarteUne" class="ds44-component-chapo ds44-centeredBlock">
            <%@ include file="../../../../types/AbstractPortletSkinable/doSkinTitle.jspf" %>
        </p>
    </header>
</div>

<div class="ds44-container-large txtcenter">
    <iframe title="<%= Util.escapeHtml(iframeTitle) %>" src="<%= iframe %>" width="<%= box.getFrameWidth() %>" height="<%= box.getFrameHeight() %>" frameborder="0">
        <a href="<%= iframe %>"><%= iframe %></a>
    </iframe>
</div>


