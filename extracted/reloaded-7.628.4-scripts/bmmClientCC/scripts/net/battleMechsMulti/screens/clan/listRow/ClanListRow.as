package net.battleMechsMulti.screens.clan.listRow
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   public class ClanListRow extends BMMovieClip
   {
      
      public static const BACKGROUND_REGULAR1:String = "regular1";
      
      public static const BACKGROUND_REGULAR2:String = "regular2";
      
      public static const BACKGROUND_ONLINE:String = "online";
      
      public static const BACKGROUND_SELF:String = "self";
      
      public static const BACKGROUND_TOP10:String = "top10";
      
      public static const BACKGROUND_TOP10_SELF:String = "self_top10";
      
      public static const BACKGROUND_TOP10_ONLINE:String = "top10_online";
      
      public var txtLevel:TextField;
      
      public var txtName:TextField;
      
      public var mcSizer_rank:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcSizer_flag:Sprite;
      
      public var mcFlag:BMAvatarImage;
      
      private var mcRank:Sprite;
      
      public function ClanListRow()
      {
         super();
      }
      
      public function initialize(param1:ClanListRowData) : void
      {
         this.initializeSub(param1);
      }
      
      public function initializeSub(param1:ClanListRowData) : void
      {
         if(this.txtLevel != null)
         {
            updateTextAndFormat(this.txtLevel,String(param1.level));
         }
         if(this.txtName != null)
         {
            updateTextAndFormat(this.txtName,param1.name);
         }
         if(this.mcSizer_rank != null)
         {
            this.mcRank = BMExternalAssetsManager.getInstance().getAsset("general","Grp_rank" + param1.rankIconNumber,this.mcSizer_rank.width,this.mcSizer_rank.height,false,false);
            this.mcRank.x = this.mcSizer_rank.x;
            this.mcRank.y = this.mcSizer_rank.y;
            addChild(this.mcRank);
         }
         if(param1.flag != null && param1.flag != "")
         {
            this.mcFlag = BMDataManager.getInstance().getAvatarImage(param1.flag);
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
   }
}

