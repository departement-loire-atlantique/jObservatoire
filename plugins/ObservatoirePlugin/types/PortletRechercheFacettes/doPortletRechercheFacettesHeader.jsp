<%@ page import="fr.cg44.plugin.socle.SocleUtils"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='/jcore/doInitPage.jspf'%>
<%@ include file='/jcore/portal/doPortletParams.jspf'%>
<%@ include file='/plugins/SoclePlugin/jsp/facettes/commonParamsFacettes.jspf' %>

<% 
    PortletRechercheFacettes obj = (PortletRechercheFacettes)portlet;
    
    String query = Util.notEmpty(obj.getQueries()) ? obj.getQueries()[0] : "";
    request.setAttribute("query", query);
    
    Boolean hasFonctionsAdditionnelles = false; // TODO
    Boolean showFiltres = isInRechercheFacette && Util.notEmpty(obj.getFacettesSecondaires()) || hasFonctionsAdditionnelles;
    request.setAttribute("showFiltres", showFiltres);
    
    request.setAttribute("rechercheId", obj.getId());
    
    request.setAttribute("isFilter", false);
    
%>



<jalios:select>

<jalios:if predicate='<%= isInRechercheFacette && Util.isEmpty(request.getAttribute("headerMenu")) %>'>
    <jalios:include jsp="plugins/SoclePlugin/types/PortletRechercheFacettes/doPortletRechercheFacettesBoxDisplay.jsp" />
</jalios:if>

<jalios:default>

<p class="h4-like" id="inp-rech" role="heading" aria-level="2"><%= glp("jcmsplugin.socle.recherche.votrerecherche") %> :</p>

<form role="search" method='<%= channel.getBooleanProperty("jcmsplugin.socle.url-rewriting", false) ? "POST" : "GET" %>' data-is-ajax='<%= isInRechercheFacette ? "true" : "false" %>' data-auto-load='<%= isInRechercheFacette ? "true" : "false" %>' action='<%= isInRechercheFacette ? "plugins/SoclePlugin/jsp/facettes/displayResultDecodeParams.jsp" : channel.getPublication("$jcmsplugin.socle.recherche.facettes.portal").getDisplayUrl(userLocale) + "?boxId=" + obj.getId() %>'>

     <div class="grid-12">
     
         <% int cptFacetCat = 0; // Sert au calcul de la marge pour les PortletFacetteCategorie %>
	     <jalios:foreach array="<%= obj.getFacettesPrincipales() %>" name="itFacette" type="AbstractPortletFacette">
	         	         
	         <jalios:if predicate='<%= itFacette instanceof PortletFacetteMotcle  %>'>
	           <div class="col-12">                          
                    <jalios:include pub="<%= itFacette %>" />
                </div>
	         </jalios:if>
	         
	         <jalios:if predicate='<%= itFacette instanceof PortletFacetteCategorie %>'>
	           <% cptFacetCat++; // Marge différente suivant l'emplacement de la facette %>
	           <div class='col-6 ds44-minTiny-margin-<%= cptFacetCat % 2 == 0 ? "l" : "r" %>'> 
	               <jalios:include pub="<%= itFacette %>" />
	           </div>
	         </jalios:if>
	         
	     </jalios:foreach>
     
      
      
         
    </div>     
    
    
    <input type="hidden" name='<%= "typeDeTuileFicheLieu" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getTypeDeTuileFicheLieu() %>' data-technical-field />
        
    <input type="hidden" name='<%= "facetOperatorUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesFacettes() %>' data-technical-field />
    
    <input type="hidden" name='<%= "sectorisation" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getSectorisation() %>' data-technical-field />
    <input type="hidden" name='<%= "afficheCarte" + glp("jcmsplugin.socle.facette.form-element") %>' value="<%= obj.getAffichageDeLaCarte() %>" data-technical-field />

    <input type="hidden" name='<%= "modCatBranchesUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesBranches() %>' data-technical-field />
    <input type="hidden" name='<%= "modCatNivUnion" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getModeDesCategories() %>' data-technical-field />
    
    <jalios:if predicate="<%= Util.notEmpty(obj.getTypeDeLieu()) && Util.notEmpty(channel.getCategory(obj.getTypeDeLieu())) %>">
       <input type="hidden" name='<%= "cidTypeLieu" + glp("jcmsplugin.socle.facette.form-element") %>' value="<%= channel.getCategory(obj.getTypeDeLieu()).getId() %>" data-technical-field />
    </jalios:if>

    <input type="hidden" name='<%= "boxId" + glp("jcmsplugin.socle.facette.form-element") %>' value='<%= obj.getId() %>' data-technical-field />
    <input type="hidden" name='pubId' value='<%= Util.notEmpty(request.getAttribute("publication")) ? ((Publication)request.getAttribute("publication")).getId() : "" %>' data-technical-field />
    
    
    
    <button type="submit" class="ds44-btnStd ds44-btn--invert" title="Valider votre recherche par mots-clés">
         <span class="ds44-btnInnerText">Valider</span><i class="icon icon-long-arrow-right" aria-hidden="true"></i>
    </button> 
    
   
       
</form>       
</jalios:default>

</jalios:select>   
         
         