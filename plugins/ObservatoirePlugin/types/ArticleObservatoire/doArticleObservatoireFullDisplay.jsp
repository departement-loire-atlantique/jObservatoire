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








<table class="fields">
  <tr class="field description wysiwygEditor abstract <%= Util.isEmpty(obj.getDescription()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "description", userLang) %><jalios:edit pub='<%= obj %>' fields='description'/></td>
    <td class='field-data' <%= gfla(obj, "description") %>>
            <% if (Util.notEmpty(obj.getDescription())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='description'><%= obj.getDescription() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field source textfieldEditor  <%= Util.isEmpty(obj.getSource()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "source", userLang) %><jalios:edit pub='<%= obj %>' fields='source'/></td>
    <td class='field-data' <%= gfla(obj, "source") %>>
            <% if (Util.notEmpty(obj.getSource())) { %>
            <%= obj.getSource() %>
            <% } %>
    </td>
  </tr>

  <tr class="field imageCarree imageEditor  <%= Util.isEmpty(obj.getImageCarree()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "imageCarree", userLang) %><jalios:edit pub='<%= obj %>' fields='imageCarree'/></td>
    <td class='field-data' <%= gfla(obj, "imageCarree") %>>
            <% if (Util.notEmpty(obj.getImageCarree())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageCarree()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field imageMobile imageEditor  <%= Util.isEmpty(obj.getImageMobile()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "imageMobile", userLang) %><jalios:edit pub='<%= obj %>' fields='imageMobile'/></td>
    <td class='field-data' <%= gfla(obj, "imageMobile") %>>
            <% if (Util.notEmpty(obj.getImageMobile())) { %>
            <img src='<%= Util.encodeUrl(obj.getImageMobile()) %>' alt='' />
            <% } %>
    </td>
  </tr>
  <tr class="field copyright textfieldEditor  <%= Util.isEmpty(obj.getCopyright(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "copyright", userLang) %><jalios:edit pub='<%= obj %>' fields='copyright'/></td>
    <td class='field-data' <%= gfla(obj, "copyright") %>>
            <% if (Util.notEmpty(obj.getCopyright(userLang))) { %>
            <%= obj.getCopyright(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field legende textfieldEditor  <%= Util.isEmpty(obj.getLegende(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "legende", userLang) %><jalios:edit pub='<%= obj %>' fields='legende'/></td>
    <td class='field-data' <%= gfla(obj, "legende") %>>
            <% if (Util.notEmpty(obj.getLegende(userLang))) { %>
            <%= obj.getLegende(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field texteAlternatif textfieldEditor  <%= Util.isEmpty(obj.getTexteAlternatif(userLang)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "texteAlternatif", userLang) %><jalios:edit pub='<%= obj %>' fields='texteAlternatif'/></td>
    <td class='field-data' <%= gfla(obj, "texteAlternatif") %>>
            <% if (Util.notEmpty(obj.getTexteAlternatif(userLang))) { %>
            <%= obj.getTexteAlternatif(userLang) %>
            <% } %>
    </td>
  </tr>
  <tr class="field fichiers linkEditor  <%= Util.isEmpty(obj.getFichiers()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "fichiers", userLang) %><jalios:edit pub='<%= obj %>' fields='fichiers'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getFichiers())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.FileDocument" array="<%= obj.getFichiers() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>' params='details=true' ><jalios:fileicon doc='<%= itData %>' /></jalios:link>
              <jalios:link data='<%= itData %>'/>
              - <jalios:filesize doc='<%= itData %>'/>
              <jalios:pdf doc='<%= itData %>' />
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field libellesLiensExternes textfieldEditor  <%= Util.isEmpty(obj.getLibellesLiensExternes()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "libellesLiensExternes", userLang) %><jalios:edit pub='<%= obj %>' fields='libellesLiensExternes'/></td>
    <td class='field-data' <%= gfla(obj, "libellesLiensExternes") %>>
        <% if (Util.notEmpty(obj.getLibellesLiensExternes())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getLibellesLiensExternes() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <%= itString %>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field liensExternes urlEditor  <%= Util.isEmpty(obj.getLiensExternes()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "liensExternes", userLang) %><jalios:edit pub='<%= obj %>' fields='liensExternes'/></td>
    <td class='field-data' <%= gfla(obj, "liensExternes") %>>
        <% if (Util.notEmpty(obj.getLiensExternes())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getLiensExternes() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <a href='<%= itString %>'><%= itString %></a>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field libellesLiensOpendata textfieldEditor  <%= Util.isEmpty(obj.getLibellesLiensOpendata()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "libellesLiensOpendata", userLang) %><jalios:edit pub='<%= obj %>' fields='libellesLiensOpendata'/></td>
    <td class='field-data' <%= gfla(obj, "libellesLiensOpendata") %>>
        <% if (Util.notEmpty(obj.getLibellesLiensOpendata())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getLibellesLiensOpendata() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <%= itString %>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field liensOpendata urlEditor  <%= Util.isEmpty(obj.getLiensOpendata()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "liensOpendata", userLang) %><jalios:edit pub='<%= obj %>' fields='liensOpendata'/></td>
    <td class='field-data' <%= gfla(obj, "liensOpendata") %>>
        <% if (Util.notEmpty(obj.getLiensOpendata())) { %>
            <ol>
            <jalios:foreach name="itString" type="String" array="<%= obj.getLiensOpendata() %>">
            <% if (Util.notEmpty(itString)) { %>
              <li>
              <a href='<%= itString %>'><%= itString %></a>
              </li>
            <% } %>
            </jalios:foreach>
            </ol>
        <% } %>
    </td>
  </tr>
  <tr class="field contenu wysiwygEditor  <%= Util.isEmpty(obj.getContenu()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "contenu", userLang) %><jalios:edit pub='<%= obj %>' fields='contenu'/></td>
    <td class='field-data' <%= gfla(obj, "contenu") %>>
            <% if (Util.notEmpty(obj.getContenu())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='contenu'><%= obj.getContenu() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field texteencart wysiwygEditor  <%= Util.isEmpty(obj.getTexteencart()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "texteencart", userLang) %><jalios:edit pub='<%= obj %>' fields='texteencart'/></td>
    <td class='field-data' <%= gfla(obj, "texteencart") %>>
            <% if (Util.notEmpty(obj.getTexteencart())) { %>
            <jalios:wysiwyg data='<%= obj %>' field='texteencart'><%= obj.getTexteencart() %></jalios:wysiwyg>            
            <% } %>
    </td>
  </tr>
  <tr class="field voirAussi linkEditor  <%= Util.isEmpty(obj.getVoirAussi()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "voirAussi", userLang) %><jalios:edit pub='<%= obj %>' fields='voirAussi'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getVoirAussi())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.Content" array="<%= obj.getVoirAussi() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>'/>
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field motsCles categoryEditor  <%= Util.isEmpty(obj.getMotsCles(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "motsCles", userLang) %><jalios:edit pub='<%= obj %>' fields='motsCles'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getMotsCles(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getMotsCles(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.observatoire.category.motscle.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field portletEncartBas linkEditor  <%= Util.isEmpty(obj.getPortletEncartBas()) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "portletEncartBas", userLang) %><jalios:edit pub='<%= obj %>' fields='portletEncartBas'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getPortletEncartBas())) { %>
            <ol>
              <jalios:foreach name="itData" type="com.jalios.jcms.portlet.PortalElement" array="<%= obj.getPortletEncartBas() %>">
              <% if (itData != null && itData.canBeReadBy(loggedMember)) { %>
              <li>
              <jalios:link data='<%= itData %>'/>
              </li>
              <% } %>
              </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
  <tr class="field categorieDeNavigation categoryEditor  <%= Util.isEmpty(obj.getCategorieDeNavigation(loggedMember)) ? "empty" : "" %>">
    <td class='field-label'><%= channel.getTypeFieldLabel(ArticleObservatoire.class, "categorieDeNavigation", userLang) %><jalios:edit pub='<%= obj %>' fields='categorieDeNavigation'/></td>
    <td class='field-data' >
            <% if (Util.notEmpty(obj.getCategorieDeNavigation(loggedMember))) { %>
            <ol>
            <jalios:foreach collection="<%= obj.getCategorieDeNavigation(loggedMember) %>" type="Category" name="itCategory" >
              <li><% if (itCategory != null) { %><a href="<%= ResourceHelper.getQuery() %>?cids=<%= itCategory.getId() %>"><%= itCategory.getAncestorString(channel.getCategory("$jcmsplugin.socle.category.categorieDeNavigation.root"), " > ", true, userLang) %></a><% } %></li>
            </jalios:foreach>
            </ol>
            <% } %>
    </td>
  </tr>
 
</table>
<jsp:include page="/front/doFullDisplayCommonFields.jsp" />
</div><%-- **********4A616C696F73204A434D53 *** SIGNATURE BOUNDARY * DO NOT EDIT ANYTHING BELOW THIS LINE *** --%><%
%><%-- ak3O155AYVmNQ881KSIO7g== --%>