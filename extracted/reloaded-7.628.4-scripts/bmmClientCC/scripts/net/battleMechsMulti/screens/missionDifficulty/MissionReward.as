package net.battleMechsMulti.screens.missionDifficulty
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2457")]
   public class MissionReward extends BMBaseClass
   {
      
      public var txtValues:TextField;
      
      public var mcSizer_icon:Sprite;
      
      private var _iconMC:MovieClip;
      
      public function MissionReward()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function setIconByType(param1:String, param2:Vector.<BMPlayerItemData> = null) : void
      {
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:uint = 0;
         var _loc6_:BMItemData = null;
         var _loc7_:String = null;
         var _loc8_:MovieClip = null;
         var _loc9_:MovieClip = null;
         var _loc10_:uint = 0;
         var _loc3_:MovieClip = null;
         switch(param1)
         {
            case "tokens":
               _loc3_ = new localIcon_tokensCentered();
               break;
            case "gold":
               _loc3_ = new localIcon_gold();
               break;
            case "boxes":
               _loc3_ = new mcEmptyItemBox();
               break;
            case "xp":
               _loc3_ = new localIcon_xpStar();
               break;
            case "battleCredits":
               _loc3_ = new battleCreditsIcon();
               break;
            case "arenaCoins":
               _loc3_ = new localIcon_arenaCoinsCentered();
               break;
            case "nukes":
               _loc3_ = new localIcon_nukes();
               break;
            case "items":
               if(param2 == null)
               {
                  break;
               }
               if(param2.length == 0)
               {
                  break;
               }
               _loc4_ = param2[0];
               _loc5_ = _loc4_.itemID;
               _loc6_ = BMDataManager.getInstance().itemsDB[_loc5_];
               _loc7_ = BMDataManager.getInstance().itemTypeSourceDB[_loc6_.type];
               _loc8_ = BMExternalAssetsManager.getInstance().getAsset(_loc7_,_loc6_.grp,0,0,true,false);
               _loc9_ = new MovieClip();
               _loc9_.addChild(_loc8_);
               _loc8_.x -= _loc8_.width / 2;
               _loc8_.y -= _loc8_.height / 2;
               _loc10_ = this.mcSizer_icon.width;
               this.mcSizer_icon.width *= 1.2;
               this.mcSizer_icon.height *= 1.2;
               this.mcSizer_icon.x -= _loc10_ * 0.1;
               this.mcSizer_icon.y -= _loc10_ * 0.1;
               this.setIcon(_loc9_);
         }
         if(_loc3_ != null)
         {
            this.setIcon(_loc3_);
         }
      }
      
      public function setIcon(param1:MovieClip) : void
      {
         var _loc2_:Number = NaN;
         if(this._iconMC != null)
         {
            removeChild(this._iconMC);
         }
         _loc2_ = param1.width / param1.height;
         this._iconMC = param1;
         this._iconMC.height = this.mcSizer_icon.height;
         this._iconMC.width = this._iconMC.height * _loc2_;
         this._iconMC.x = this.mcSizer_icon.x + this.mcSizer_icon.width * 0.5;
         this._iconMC.y = this.mcSizer_icon.y + this._iconMC.height * 0.5;
         addChild(this._iconMC);
      }
      
      public function set text(param1:String) : void
      {
         updateTextAndFormat(this.txtValues,param1);
      }
      
      public function pushRightAccordingToContent() : void
      {
         x += (this.txtValues.width - this.txtValues.textWidth) / 2;
      }
   }
}

