<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file='/jcore/doInitPage.jspf' %>
<%@page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@page import="fr.cg44.plugin.observatoire.ObservatoireUtils"%>

<%@ include file='/jcore/media/mediaTemplateInit.jspf' %>
<%

if (data == null) {
  return;
}

ArticleObservatoire pub = (ArticleObservatoire) data;
String typeArticle = ObservatoireUtils.getTypeArticleObservatoire(pub);
String typeArticleLibelle = "";
String typeArticleIcone = "";

if(Util.notEmpty(typeArticle)){
  typeArticleLibelle = glp("jcmsplugin.observatoire."+typeArticle+".libelle-court");
  typeArticleIcone = glp("jcmsplugin.observatoire."+typeArticle+".icone");
}
%>

<section class="ds44-card ds44-js-card ds44-card--contact ds44-bgGray">
    <div class="ds44-card__section">
        <div class="ds44-innerBoxContainer">
            <p role="heading" aria-level="3" class="h4-like ds44-cardTitle">
                <a href="<%= pub.getDisplayUrl(userLocale) %>" class="ds44-card__globalLink"><%= pub.getTitle(userLang) %></a>
            </p>
            <hr class="mbs" aria-hidden="true">
            <p class="ds44-docListElem ds44-mt-std">
                <i class="icon <%= typeArticleIcone %> ds44-docListIco" aria-hidden="true"></i><%= typeArticleLibelle %>
            </p>
            
            <%-- Mots clés --%>
            <jalios:if predicate='<%= Util.notEmpty(pub.getMotsCles(loggedMember)) %>'>
	            <ul class="ds44-list ds44-list--tag ds44-mt1">
                    <jalios:foreach collection="<%= pub.getMotsCles(loggedMember) %>" type="Category" name="itCategory">
                        <li><span class="ds44-btnStd ds44-btnStd--tag ds44-btnInnerText"><%=itCategory%></span></li>
                    </jalios:foreach>
	            </ul>            
            </jalios:if> 

        </div>
        <i class="icon icon-arrow-right ds44-cardArrow" aria-hidden="true"></i>
    </div>
</section>