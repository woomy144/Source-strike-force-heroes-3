package Box2D.Dynamics.Contacts
{
   import Box2D.Collision.Shapes.b2EdgeShape;
   import Box2D.Collision.Shapes.b2PolygonShape;
   import Box2D.Collision.Shapes.b2Shape;
   import Box2D.Collision.b2Manifold;
   import Box2D.Common.Math.b2Transform;
   import Box2D.Common.b2Settings;
   import Box2D.Common.b2internal;
   import Box2D.Dynamics.b2Body;
   import Box2D.Dynamics.b2Fixture;
   
   use namespace b2internal;
   
   public class b2PolyAndEdgeContact extends b2Contact
   {
       
      
      public function b2PolyAndEdgeContact()
      {
         super();
      }
      
      public static function Create(allocator:*) : b2Contact
      {
         return new b2PolyAndEdgeContact();
      }
      
      public static function Destroy(contact:b2Contact, allocator:*) : void
      {
      }
      
      public function Reset(fixtureA:b2Fixture, fixtureB:b2Fixture) : void
      {
         super.Reset(fixtureA,fixtureB);
         b2Settings.b2Assert(fixtureA.GetType() == b2Shape.e_polygonShape);
         b2Settings.b2Assert(fixtureB.GetType() == b2Shape.e_edgeShape);
      }
      
      override b2internal function Evaluate() : void
      {
         var bA:b2Body = b2internal::m_fixtureA.GetBody();
         var bB:b2Body = b2internal::m_fixtureB.GetBody();
         this.serveAnimatedFather2(b2internal::m_manifold,b2internal::m_fixtureA.GetShape() as b2PolygonShape,bA.m_xf,b2internal::m_fixtureB.GetShape() as b2EdgeShape,bB.m_xf);
      }
      
      private function serveAnimatedFather2(manifold:b2Manifold, polygon:b2PolygonShape, xf1:b2Transform, edge:b2EdgeShape, xf2:b2Transform) : void
      {
      }
   }
}
