<%@page import="fr.cg44.plugin.socle.SocleUtils"%><%
%><%@page import="fr.cg44.plugin.observatoire.ObservatoireUtils"%><%
%><%@ page contentType="text/html; charset=UTF-8" %><%
%><%@ taglib prefix="ds" tagdir="/WEB-INF/tags"%><%
%><%@ include file='/jcore/doInitPage.jspf' %><%
%><% ArticleObservatoire obj = (ArticleObservatoire)request.getAttribute(PortalManager.PORTAL_PUBLICATION); %><%
%><%@ include file='/front/doFullDisplay.jspf' %>

<main id="content" role="main">

<jalios:include target="SOCLE_ALERTE"/>

    <article class="ds44-container-large">

        <ds:titleSimple pub="<%= obj %>" imagePath="" mobileImagePath="<%= obj.getImageMobile() %>" title="<%= obj.getTitle(userLang) %>"
            breadcrumb="true" legend="<%= obj.getLegende(userLang) %>" copyright="<%= obj.getCopyright(userLang) %>" backButton="true">
        </ds:titleSimple>
        
        <div class="ds44-inner-container ds44-xl-margin-tb">
            <div class="grid-12-small-1">

                <%-- Colonne de gauche --%>
                <div class="col-7">
                    <jalios:if predicate='<%= Util.notEmpty(obj.getDescription()) %>'>
                        <jalios:wysiwyg><%= obj.getDescription() %></jalios:wysiwyg>
                    </jalios:if>
                    
		            <%-- On n'affiche pas certaines infos si on n'est pas dans les rubriques "cartes / stats / etudes" --%>
		            <jalios:if predicate='<%= Util.notEmpty(ObservatoireUtils.getTypeArticleObservatoire(obj)) %>'>
		                <jalios:if predicate='<%= Util.notEmpty(obj.getSource()) %>'>
		                    <p class="ds44-docListElem mts">
                                <i class="icon icon-user-group ds44-docListIco" aria-hidden="true"></i>
                                <strong><%= glp("jcmsplugin.socle.source") %> : </strong><%= obj.getSource() %>
                            </p>
		                </jalios:if>
						<p class="ds44-docListElem mts">
							<i class="icon icon-date ds44-docListIco" aria-hidden="true"></i>
							<%=glp("jcmsplugin.socle.date-actualisation")%> <jalios:date date="<%= obj.getUdate() %>" format="dd/MM/yyyy"/>
						</p>
		            </jalios:if>
		            
		            <%-- Téléchargement --%>
                    <jalios:if predicate="<%= Util.notEmpty(obj.getFichiers()) %>">
                        <section class="ds44-box ds44-theme">
                            <div class="ds44-innerBoxContainer">
                                <p role="heading" aria-level="2" class="ds44-box-heading"><%= glp("jcmsplugin.socle.fichepublication.telecharger") %></p>
                                
		                        <jalios:foreach name="itDoc" type="com.jalios.jcms.FileDocument" array="<%= obj.getFichiers() %>">
                                    <ul class="ds44-list">
			                            <jalios:if predicate='<%= itDoc != null && itDoc.canBeReadBy(loggedMember) %>'>
			                               <% 
			                                String title = HttpUtil.encodeForHTMLAttribute(itDoc.getTitle());
			                                String fileType = FileDocument.getExtension(itDoc.getFilename()).toUpperCase();
			                                String fileSize = Util.formatFileSize(itDoc.getSize());
			                              %>
			                            <li class="mts">
			                              <jalios:include pub="<%= itDoc %>" usage="embed"/>
			                            </li>
			                            </jalios:if>
                                    </ul>  
                                </jalios:foreach>
                            </div>
                        </section>
                    </jalios:if>
                    
                    <%-- Mots clés --%>
	                <jalios:if predicate='<%= Util.notEmpty(obj.getMotsCles(loggedMember)) %>'>
	                    <div>
	                        <h2><%= glp("jcmsplugin.socle.motscles") %></h2>
	                        <ul>
								<jalios:foreach collection="<%= obj.getMotsCles(loggedMember) %>" type="Category" name="itCategory">
									<li><%=itCategory%></li>
								</jalios:foreach>
							</ul>
	                    </div>
	                </jalios:if>                    
                
                    <%-- Voir aussi --%>
	                <jalios:if predicate='<%= Util.notEmpty(obj.getVoirAussi()) %>'>
						<section class="ds44-innerBoxContainer ds44-borderContainer">
						  <h2 class="h2-like"><%= glp("jcmsplugin.socle.voiraussi") %></h2>
						      <ul>
								<jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%=obj.getVoirAussi()%>">
									<jalios:if predicate='<%=itData != null && itData.canBeReadBy(loggedMember)%>'>
										<li class="<%=ObservatoireUtils.getTypeArticleObservatoire(itData)%>">
											<jalios:link data='<%=itData%>' />
										</li>
									</jalios:if>
								</jalios:foreach>
							</ul>
						</section>	                
	                </jalios:if>                                       
                </div>
                
                <div class="col-1 grid-offset ds44-hide-tiny-to-medium"></div>
                
                <!-- Colonne de droite -->
                <aside class="col-4">
                
                    <jalios:if predicate='<%= Util.notEmpty(obj.getIllustrationPrincipale()) %>'>
		                <div class="main-illustration hidden-phone">
		                    <img class="mainImage" src="<%=Util.encodeUrl(obj.getIllustrationPrincipale())%>" alt="" />
		                        <jalios:if predicate="<%= Util.notEmpty(obj.getLegende()) || Util.notEmpty(obj.getCopyright()) %>">
		                            <div class="legend">
		                                <jalios:if predicate="<%= Util.notEmpty(obj.getCopyright()) %>">
		                                    <p class="copyright"><%= obj.getCopyright() %></p>
		                                </jalios:if>
		                                <jalios:if predicate="<%= Util.notEmpty(obj.getLegende()) && Util.notEmpty(obj.getCopyright()) %>"> - </jalios:if>
		                                <jalios:if predicate="<%= Util.notEmpty(obj.getLegende()) %>">
		                                    <p><%= obj.getLegende() %></p>
		                                </jalios:if>
		                            </div>
		                        </jalios:if>
		                </div>
                    </jalios:if>
                    
                    <jalios:if predicate='<%= Util.notEmpty(obj.getTexteencart()) %>'>
		                <div class="gray-part">
		                    <jalios:wysiwyg><%= obj.getTexteencart() %></jalios:wysiwyg> 
		                </div>
                    </jalios:if>
            
		            <jalios:if predicate='<%= Util.notEmpty(obj.getPortletEncartBas()) %>'>
		                <jalios:foreach name="itPortletEncartBas" type="PortalElement" array="<%= obj.getPortletEncartBas() %>">
                            <jalios:include pub="<%= itPortletEncartBas %>"/>
                        </jalios:foreach> 
		            </jalios:if>                    
                    
                </aside>
                
            </div>
        </div>
        
    </article>
    
    <%-- Partagez cette page --%>
    <%@ include file="/plugins/SoclePlugin/jsp/portal/socialNetworksShare.jspf" %>
    
    <%-- Page utile --%>
    <jsp:include page="/plugins/SoclePlugin/types/PageUtileForm/editFormPageUtileForm.jsp"/>
    
</main>
