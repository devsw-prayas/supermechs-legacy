package net.battleMechsMulti.screens.raid
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class RaidLeaderboardListRow extends BMMovieClip
   {
      
      public var txtRank:TextField;
      
      public var txtScore:TextField;
      
      public var txtLevel:TextField;
      
      public var txtName:TextField;
      
      public var txtGold:TextField;
      
      public var txtTokens:TextField;
      
      public var mcGold:Sprite;
      
      public var mcTokens:Sprite;
      
      public var mcSizer_flag:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcRankProgression:MovieClip;
      
      public var mcFlag:BMAvatarImage;
      
      public const BACKGROUND_REGULAR1:String = "regular1";
      
      public const BACKGROUND_REGULAR2:String = "regular2";
      
      public const BACKGROUND_ONLINE:String = "online";
      
      public const BACKGROUND_SELF:String = "self";
      
      public const BACKGROUND_TOP10:String = "top10";
      
      public const BACKGROUND_TOP10_SELF:String = "self_top10";
      
      public const BACKGROUND_TOP10_ONLINE:String = "top10_online";
      
      public function RaidLeaderboardListRow()
      {
         super();
      }
      
      public function initialize(param1:uint, param2:uint, param3:uint, param4:String, param5:uint, param6:uint, param7:String = "") : void
      {
         updateTextAndFormat(this.txtRank,TextUtils.getNumberWithComma(param1));
         updateTextAndFormat(this.txtScore,TextUtils.getNumberWithComma(param2));
         updateTextAndFormat(this.txtLevel,String(param3));
         updateTextAndFormat(this.txtName,param4);
         if(param5 == 0)
         {
            this.mcGold.visible = false;
            this.txtGold.text = "";
         }
         else
         {
            updateTextAndFormat(this.txtGold,TextUtils.getNumberWithComma(param5));
         }
         if(param6 == 0)
         {
            this.mcTokens.visible = false;
            this.txtTokens.text = "";
         }
         else
         {
            updateTextAndFormat(this.txtTokens,TextUtils.getNumberWithComma(param6));
         }
         if(param7 != null && param7 != "")
         {
            this.mcFlag = BMDataManager.getInstance().getAvatarImage(param7);
            this.mcFlag.x = this.mcSizer_flag.x;
            this.mcFlag.y = this.mcSizer_flag.y;
            this.mcFlag.width = this.mcSizer_flag.width;
            this.mcFlag.height = this.mcSizer_flag.height;
            addChild(this.mcFlag);
         }
      }
      
      public function setBackground(param1:String) : void
      {
         this.mcBackground.gotoAndStop(param1);
      }
      
      public function hasFlag() : Boolean
      {
         return this.mcFlag != null;
      }
      
      public function getFlagImage() : BMAvatarImage
      {
         return this.mcFlag;
      }
      
      public function removeProgressionArrow() : void
      {
         if(this.mcRankProgression == null)
         {
            return;
         }
         this.mcRankProgression.parent.removeChild(this.mcRankProgression);
         this.mcRankProgression = null;
      }
      
      public function showPositiveProgressionArrow() : void
      {
         this.mcRankProgression.gotoAndStop("up");
      }
      
      public function showNegativeProgressionArrow() : void
      {
         this.mcRankProgression.gotoAndStop("down");
      }
   }
}

