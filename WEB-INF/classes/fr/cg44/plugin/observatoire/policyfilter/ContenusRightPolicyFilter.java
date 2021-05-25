package fr.cg44.plugin.observatoire.policyfilter;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Group;
import com.jalios.jcms.Member;
import com.jalios.jcms.Publication;
import com.jalios.jcms.plugin.Plugin;
import com.jalios.jcms.plugin.PluginComponent;
import com.jalios.jcms.policy.BasicRightPolicyFilter;
import com.jalios.util.Util;

/**
 * RightPolicyFilter pour les contenus :
 * Un contenu catégorisé dans la branche "Classement > Contenus agents internes" ne sera visible
 * que pour les agents du réseau DEP, les admin d'espace et les membres d'un groupe spécifique.
 * Hors réseau on passe par le reverse-proxy et on place un header http spécifique.
 * Un agent n'a donc pas ce header.
 * 
 * Si le header est absent, et que le contenu est catégorisé dans la bonne branche, on peut voir ce contenu
 * 
 */
public class ContenusRightPolicyFilter extends BasicRightPolicyFilter implements PluginComponent {
	private static final Logger LOGGER = Logger.getLogger(ContenusRightPolicyFilter.class);
	public static final Channel channel = Channel.getChannel();

	public boolean init(Plugin plugin) {
		return true;
	} 

	/* Teste les contenus uniquement.
	 * Si un contenu est placé dans la catégorie protégée alors on regarde si on a affaire à un agent DEP ou pas.
	 * Si oui, on autorise la lecture. On bloque dans le cas contraire. 
	 * */
	public boolean canBeReadBy(boolean isAuthorized, Publication pub, Member member, boolean searchInGroups) {

		// Check JCMS status
		if (!isAuthorized) {
			return false;
		}


		Category categorieProtegee = channel.getCategory("$jcmsplugin.observatoire.contenusAgents.cat");
		
		if(null!=categorieProtegee && pub.hasCategory(categorieProtegee)){
			if(isAgent() || isLecteurAutorise(member) || channel.getDefaultWorkspace().isAdmin(member)){
				return true;	
			}
			else{
				return false;
			}
		}


		return true;
	}

	/* Si la requete ne possède pas le header "Client-Origin", on a affaire à un agent DEP
	 * Ce header est positionné sur le reverse-proxy par l'équipe réseau.
	 * */
	public static boolean isAgent(){
		HttpServletRequest request = channel.getCurrentJcmsContext().getRequest();
		if(Util.isEmpty(request.getHeader("Client-Origin"))){
			return true;
		}

		return false;
	}
	
	/* Teste si le membre fait partie du groupe de lecteurs privilégiés, autorisés à consulter 
	 * les contenus réservés.
	 * */
	public static boolean isLecteurAutorise(Member mbr){
		Group group = channel.getGroup("$jcmsplugin.observatoire.contenusAgents.group");
		if(Util.notEmpty(mbr) && Util.notEmpty(group) && mbr.belongsToGroup(group)){
			return true;
		}

		return false;
	}
}