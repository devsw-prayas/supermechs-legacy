package net.battleMechsMulti.helpers
{
   import net.battleMechsMulti.utils.ExternalInterfaceWrapper;
   
   public class BMAffiliatesHelper
   {
      
      public static var YEPI_CAMPAIGN_ID:uint = 851;
      
      public static var Y8_CAMPAIGN_ID:uint = 724;
      
      public static var MINIJUEGOS_CAMPAIGN_ID:uint = 395;
      
      public static var ARMOR_GAMES_CAMPAIGN_ID:uint = 655;
      
      public function BMAffiliatesHelper()
      {
         super();
      }
      
      public static function getAffiliateCampaignID() : uint
      {
         var _loc2_:String = null;
         var _loc1_:uint = 0;
         if(ExternalInterfaceWrapper.isAvailable())
         {
            _loc2_ = ExternalInterfaceWrapper.call("window.location.href.toString");
            if(_loc2_ != null)
            {
               if(_loc2_.indexOf("mcamp_id=" + YEPI_CAMPAIGN_ID) > 0)
               {
                  _loc1_ = YEPI_CAMPAIGN_ID;
               }
            }
         }
         return _loc1_;
      }
      
      public static function canAffiliateUseExternalLogins() : Boolean
      {
         var _loc1_:Boolean = true;
         if(ExternalInterfaceWrapper.isAvailable())
         {
            switch(getAffiliateCampaignID())
            {
               case YEPI_CAMPAIGN_ID:
               case ARMOR_GAMES_CAMPAIGN_ID:
               case MINIJUEGOS_CAMPAIGN_ID:
               case Y8_CAMPAIGN_ID:
                  _loc1_ = false;
            }
         }
         return _loc1_;
      }
      
      public static function doesAffiliateAllowMobileVersionAds() : Boolean
      {
         var _loc1_:Boolean = true;
         if(ExternalInterfaceWrapper.isAvailable())
         {
            switch(getAffiliateCampaignID())
            {
               case YEPI_CAMPAIGN_ID:
               case ARMOR_GAMES_CAMPAIGN_ID:
               case MINIJUEGOS_CAMPAIGN_ID:
               case Y8_CAMPAIGN_ID:
                  _loc1_ = false;
            }
         }
         return _loc1_;
      }
   }
}

