#############################################################################
##
##  ToricSubvarieties.gi         ToricVarieties package
##
##  Copyright 2011- 2016, Sebastian Gutsche, TU Kaiserslautern
##
## The Category of toric Subvarieties
##
#############################################################################

DeclareRepresentation( "IsCombinatoricalSubRep",
                       IsToricSubvariety and IsAttributeStoringRep,
                       [ UnderlyingToricVariety, AmbientToricVariety ]
                      );

DeclareRepresentation( "IsFanSubRep",
                       IsCombinatoricalSubRep,
                       [ ]
                      );

##################################
##
## Family and Type
##
##################################


BindGlobal( "TheTypeFanToricSubvariety",
        NewType( TheFamilyOfToricVarietes,
                 IsFanSubRep ) );

##
TORIC_VARIETIES!.prop_and_attr_shared_by_vars_and_subvars := [
                "IsNormalVariety",
                "IsAffine",
                "IsProjective",
                "IsSmooth",
                "IsComplete",
                "HasTorusfactor",
                "HasNoTorusfactor",
                "IsOrbifold",
                "AffineOpenCovering",
                "CoxRing",
                "ClassGroup",
                "PicardGroup",
                "TorusInvariantDivisorGroup",
                "MapFromCharacterToPrincipalDivisor",
                "Dimension",
                "DimensionOfTorusfactor",
                "CoordinateRingOfTorus",
                "IsProductOf",
                "CharacterLattice",
                "TorusInvariantPrimeDivisors",
                "IrrelevantIdeal",
                "FanOfVariety",
                "PolytopeOfVariety",
                "ConeOfVariety",
                "MorphismFromCoxVariety",
                "CoxVariety",
                "ConeOfVariety",
                "AffineCone",
                "PolytopeOfVariety",
                "ProjectiveEmbedding",
                "CartierTorusInvariantDivisorGroup",
                "NameOfVariety"
                                                             ];

#################################
##
## Methods
##
#################################

##
InstallMethod( ClosureOfTorusOrbitOfCone,
               " for homalg cone",
               [ IsFanRep, IsCone ],
               
  function( variety, cone )
    local star_fan, orbit;
    
    star_fan := StarFan( cone, FanOfVariety( variety ) );
    
    orbit := ToricVariety( star_fan );
    
    orbit := ToricSubvariety( orbit, variety );
    
    SetIsClosedSubvariety( orbit, true );
    
    SetIsOpen( orbit, false );
    
    return orbit;
    
end );

##
InstallMethod( InclusionMorphism,
               "for open toric varieties",
               [ IsToricSubvariety and IsOpen ],
               
  function( subvariety )
    local morphism, ambvariety;
    
    ambvariety := AmbientToricVariety( subvariety );
    
    morphism := IdentityMat( Dimension( ambvariety ) );
    
    return ToricMorphism( UnderlyingToricVariety( subvariety ), morphism, ambvariety );
    
end );

# ##
# InstallMethod( IsClosed,
#                "for closed subvars",
#                [ IsToricSubvariety ],
#                
#   IsClosedSubvariety
#   
# );
# 
# ##
# InstallMethod( HasIsClosed,
#                "for closed subvars",
#                [ IsToricSubvariety ],
#                
#   HasIsClosedSubvariety
#   
# );
# 
# ##
# InstallMethod( SetIsClosed,
#                "for closed subvars",
#                [ IsToricSubvariety, IsBool ],
#                
#   SetIsClosedSubvariety
#   
# );

##################################
##
## Constructors
##
##################################

##
InstallMethod( ToricSubvariety,
               " for 2 toric varieties",
               [ IsToricVariety, IsToricVariety ],
  function( variety, ambient_variety )
    local subvariety;
    
    subvariety := rec( );
    
    ObjectifyWithAttributes(
                            subvariety, TheTypeFanToricSubvariety,
                            UnderlyingToricVariety, variety,
                            AmbientToricVariety, ambient_variety
    );

    # set the map into the class group
    # the 'ByASmallerPresentation' immediately reduces the class group presentation
    SetMapFromWeilDivisorsToClassGroup( variety, 
                                       ByASmallerPresentation( CokernelEpi( MapFromCharacterToPrincipalDivisor( variety ) ) ) );

    # and return the variety
    return variety;
    
end );






