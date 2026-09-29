package net.battleMechsMulti.screens.shop
{
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4945")]
   public class BMShopPremiumInfoCard extends BMMovieClip
   {
      
      public var txtTitle:TextField;
      
      public var txtAddFree:TextField;
      
      public var txtArenaBonusesTitle:TextField;
      
      public var txtArenaCoinsBonus:TextField;
      
      public var txtArenaXPBonus:TextField;
      
      public var txtArenaGoldBonus:TextField;
      
      public var txtCampaignBonus:TextField;
      
      public function BMShopPremiumInfoCard()
      {
         super();
         var _loc1_:BMDataManager = BMDataManager.getInstance();
         var _loc2_:BMLanguageManager = BMLanguageManager.getInstance();
         updateTextAndFormat(this.txtTitle,_loc2_.getText("premiumAccount_title"));
         var _loc3_:Array = TextUtils.splitStringToTwoLines(_loc2_.getText("premiumAccount_addFree"));
         updateTextAndFormat(this.txtAddFree,_loc3_.join("<BR>"));
         updateTextAndFormat(this.txtArenaBonusesTitle,_loc2_.getText("premiumAccount_arenaBonuses"));
         updateTextAndFormat(this.txtArenaCoinsBonus,"+50% " + _loc2_.getText("general_arenaCoins"));
         updateTextAndFormat(this.txtArenaGoldBonus,"+50% " + _loc2_.getText("globalShop_gold"));
         updateTextAndFormat(this.txtArenaXPBonus,"+50% XP");
         var _loc4_:String = _loc2_.getText("premiumAccount_campaignBonus");
         _loc4_ = _loc1_.replaceStringInText(_loc4_,"%VALUE%","20");
         updateTextAndFormat(this.txtCampaignBonus,_loc4_);
         ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtAddFree,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtArenaBonusesTitle,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtArenaCoinsBonus,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtArenaXPBonus,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtArenaGoldBonus,this);
         ImageUtils.swapTextFieldWithBitMap(this.txtCampaignBonus,this);
      }
   }
}

