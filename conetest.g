LoadPackage( "PolymakeInterface" );
C := POLYMAKE_CREATE_CONE_BY_RAYS([[1,0],[0,1]]);
POLYMAKE_DEFINING_INEQUALITIES_OF_CONE(C);
