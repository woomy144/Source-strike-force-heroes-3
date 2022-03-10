package Box2D.Dynamics
{
   import Box2D.Common.b2Settings;
   
   public class b2ContactImpulse
   {
       
      
      public var normalImpulses:Array;
      
      public var tangentImpulses:Array;
      
      public function b2ContactImpulse()
      {
         this.normalImpulses = new Array(b2Settings.b2_maxManifoldPoints);
         this.tangentImpulses = new Array(b2Settings.b2_maxManifoldPoints);
         super();
      }
   }
}
