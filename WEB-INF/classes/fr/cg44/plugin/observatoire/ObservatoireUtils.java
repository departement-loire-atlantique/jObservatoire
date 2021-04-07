package fr.cg44.plugin.observatoire;

import org.apache.log4j.Logger;

import com.jalios.jcms.Category;
import com.jalios.jcms.Channel;
import com.jalios.jcms.Content;
import com.jalios.util.Util;

import fr.cg44.plugin.socle.SocleUtils;

public class ObservatoireUtils{
  private static final Logger logger = Logger.getLogger(ObservatoireUtils.class);
  private static Channel channel = Channel.getChannel();
  private static Category catCartes = channel.getCategory("$jcmsplugin.observatoire.category.cartes.root");
  private static Category catStats = channel.getCategory("$jcmsplugin.observatoire.category.stats.root");
  private static Category catEtudes = channel.getCategory("$jcmsplugin.observatoire.category.etudes.root");

  /**
   * Renvoie le libellé du type d'ArticleObservatoire ("carte" / "stat" / "etude")
   * On se base sur la catégorie de navigation du contenu.
   * Attention : on ne tient pas compte du fait que potentiellement un contenu puisse être catégorisé dans plusieurs branches de navigation.
   * 
   * @param obj La publication de type ArticleObservatoire
   * @return Le libellé du type d'article
   */
  public static String getTypeArticleObservatoire(Content obj){
    String typeArticle = "";
    
    if(Util.notEmpty(obj)){
      if(Util.notEmpty(catCartes) && SocleUtils.hasAncestorCat(obj,catCartes)){
        typeArticle = "carte";
      }
      else if(Util.notEmpty(catStats) && SocleUtils.hasAncestorCat(obj,catStats)){
        typeArticle = "stat";
      }
      else if(Util.notEmpty(catEtudes) && SocleUtils.hasAncestorCat(obj,catEtudes)){
        typeArticle = "etude";
      } 
    }

    return typeArticle;
  }

}