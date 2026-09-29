package net.battleMechsMulti.mobiles
{
   public class BMNewsData
   {
      
      public var newsID:uint;
      
      public var title:String;
      
      public var content:String;
      
      public var postDateString:String;
      
      public var postDate:Date;
      
      public var imageUrl:String;
      
      public var category:uint;
      
      public var clickTarget:uint;
      
      public var clickTargetItemID:uint;
      
      public function BMNewsData(param1:uint, param2:String, param3:String, param4:String, param5:Date, param6:String, param7:uint, param8:uint, param9:uint)
      {
         super();
         this.newsID = param1;
         this.title = param2;
         this.content = param3;
         this.postDateString = param4;
         this.postDate = param5;
         this.imageUrl = param6;
         this.category = param7;
         this.clickTarget = param8;
         this.clickTargetItemID = param9;
      }
   }
}

