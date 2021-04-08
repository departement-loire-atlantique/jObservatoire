<%@page contentType="text/html; charset=UTF-8" %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="fr.cg44.plugin.socle.infolocale.util.InfolocaleUtil"%>
<%@page import="fr.cg44.plugin.observatoire.ObservatoireUtils"%>
<%@page import="com.jalios.jcms.taglib.card.*" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@ include file='/jcore/media/mediaTemplateInit.jspf' %><%

if (data == null) {
  return;
}

Publication pub = (Publication) data;

String typeArticle = "";
String footerText = "";
String footerIcon = "";
%>

<%@include file="../../../SoclePlugin/jsp/templates/tuileCommon.jsp" %>

<%
ArticleObservatoire obj = (ArticleObservatoire)pub;
typeArticle = ObservatoireUtils.getTypeArticleObservatoire(obj);

if(Util.notEmpty(typeArticle)){
  footerText = glp("jcmsplugin.observatoire."+typeArticle+".libelle-court");
  footerIcon = glp("jcmsplugin.observatoire."+typeArticle+".picto");
}
%>

<section class="ds44-card ds44-js-card ds44-card--horizontal <%= styleContext %> <%= isSmall ? "ds44-tiny-reducedFont" : "" %>">
    <div class="ds44-flex-container ds44-flex-valign-center">
        
		<div class="ds44-card__dateContainer ds44-flex-container ds44-flex-align-center" aria-hidden="true">
		    <p>
		        <span class="ds44-cardDateNumber">
		            <%= InfolocaleUtil.getDayOfMonthLabel(InfolocaleUtil.convertDateToInfolocaleFormat(obj.getUdate())) %>
		        </span>
		        <span class="ds44-cardDateMonth">
		            <%= InfolocaleUtil.getMonthLabel(InfolocaleUtil.convertDateToInfolocaleFormat(obj.getUdate()), true) %>
		        </span>
		    </p>
		</div>
        
        <div class="ds44-card__section--horizontal">
            <p class="ds44-card__title" role="heading" aria-level="3">
                <a class="ds44-card__globalLink" href="<%= urlPub %>" <%=titleAttr%> <%=targetAttr%>>
                    <%= obj.getTitle(userLang) %>
                </a>
            </p>
                        
			<p class="ds44-cardLocalisation">
			    <i class="icon <%= footerIcon %>" aria-hidden="true"></i><span class="ds44-iconInnerText"><%= footerText %></span>
			</p>
            
            <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
        </div>
    </div>
</section>