package Box2D.Collision
{
   import Box2D.Common.Math.b2Vec2;
   
   public class b2ManifoldPoint
   {
       
      
      public var m_localPoint:b2Vec2;
      
      public var m_normalImpulse:Number;
      
      public var m_tangentImpulse:Number;
      
      public var m_id:b2ContactID;
      
      public function b2ManifoldPoint()
      {
         this.m_localPoint = new b2Vec2();
         this.m_id = new b2ContactID();
         super();
         this.Reset();
      }
      
      public function Reset() : void
      {
         this.m_localPoint.SetZero();
         this.m_normalImpulse = 0;
         this.m_tangentImpulse = 0;
         this.m_id.key = 0;
      }
      
      public function Set(m:b2ManifoldPoint) : void
      {
         this.m_localPoint.SetV(m.m_localPoint);
         this.m_normalImpulse = m.m_normalImpulse;
         this.m_tangentImpulse = m.m_tangentImpulse;
         this.m_id.Set(m.m_id);
      }
   }
}
