#############################################################################
##
##  RingsForHomalg.gi         RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for RingsForHomalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

##
InstallValue( HOMALG_RINGS,
        rec(
            RingOfIntegersDefaultCAS := "Singular",
            FieldOfRationalsDefaultCAS := "Singular",
           )
);

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( HomalgRingOfIntegersInDefaultCAS,
  function( arg )
    local nargs, integers;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsHomalgRing( arg[nargs] ) then
        integers := ValueGlobal( Concatenation( "HomalgRingOfIntegersIn", homalgExternalCASystem( arg[nargs] ) ) );
    elif not IsBound( HOMALG_RINGS.RingOfIntegersDefaultCAS ) or HOMALG_RINGS.RingOfIntegersDefaultCAS = "" then
        integers := HomalgRingOfIntegers;
    else
        integers := ValueGlobal( Concatenation( "HomalgRingOfIntegersIn", HOMALG_RINGS.RingOfIntegersDefaultCAS ) );
    fi;
    
    return CallFuncList( integers, arg );
    
end );

##
InstallGlobalFunction( HomalgFieldOfRationalsInDefaultCAS,
  function( arg )
    local nargs, rationals;
    
    nargs := Length( arg );
    
    if nargs > 0 and IsHomalgRing( arg[nargs] ) then
        rationals := ValueGlobal( Concatenation( "HomalgFieldOfRationalsIn", homalgExternalCASystem( arg[nargs] ) ) );
    elif not IsBound( HOMALG_RINGS.FieldOfRationalsDefaultCAS ) or HOMALG_RINGS.FieldOfRationalsDefaultCAS = "" then
        rationals := HomalgFieldOfRationals;
    else
        rationals := ValueGlobal(  Concatenation( "HomalgFieldOfRationalsIn", HOMALG_RINGS.FieldOfRationalsDefaultCAS ) );
    fi;
    
    return CallFuncList( rationals, arg );
    
end );

####################################
#
# install global functions
#
####################################

##
InstallGlobalFunction( _PrepareInputForRingOfDerivations,
  function( R, indets )
    local var, nr_var, der, nr_der, r, param, base;
    
    ## check whether the base ring is polynomial and then extract needed data
    if IsFreePolynomialRing( R ) then
        if HasRelativeIndeterminatesOfPolynomialRing( R ) then
            var := RelativeIndeterminatesOfPolynomialRing( R );
        else
            var := IndeterminatesOfPolynomialRing( R );
        fi;
        nr_var := Length( var );
    else
        Error( "the given ring is not a free polynomial ring" );
    fi;
    
    var := List( var, Name );
    
    ## get the new indeterminates (the derivatives) for the ring and save them in der
    if IsString( indets ) and indets <> "" then
        der := SplitString( indets, "," );
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        der := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    nr_der := Length( der );
    
    if nr_var <> nr_der then
        Error( "the number of indeterminates of the given polynomial ring is not equal to the number of specified derivations\n" );
    fi;
    
    if Intersection2( der, var ) <> [ ] then
        Error( "the following indeterminate(s) are already elements of the polynomial ring: ", Intersection2( der, var ), "\n" );
    fi;
    
    if HasIndeterminatesOfPolynomialRing( R ) then
        r := CoefficientsRing( R );
    else
        r := R;
    fi;
    
    if HasRationalParameters( r ) then
        param := Concatenation( ",", JoinStringsWithSeparator( RationalParameters( r ) ) );
    else
        param := "";
    fi;
    
    if HasBaseRing( R ) and HasCoefficientsRing( R ) and
       not IsIdenticalObj( BaseRing( R ), CoefficientsRing( R ) ) and
       HasIndeterminatesOfPolynomialRing( BaseRing( R ) ) then
        base := IndeterminatesOfPolynomialRing( BaseRing( R ) );
        base := List( base, Name );
    else
        base := "";
    fi;
    
    return [ r, var, der, param, base ];
    
end );

##
InstallGlobalFunction( _PrepareInputForExteriorRing,
  function( R, T, indets )
    local var, nr_var, anti, comm, nr_anti, nr_comm, r, param;
    
    ## check whether the base ring is polynomial and then extract needed data
    if IsFreePolynomialRing( R ) then
        var := IndeterminatesOfPolynomialRing( R );
        nr_var := Length( var );
    else
        Error( "the given ring is not a free polynomial ring" );
    fi;
    
    var := List( var, Name );
    
    ## get the new anti commuting variables for the ring and save them in anti
    if IsString( indets ) and indets <> "" then
        anti := SplitString( indets, "," );
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        anti := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    ## get the new commuting variables for the ring and save them in comm
    if HasIndeterminatesOfPolynomialRing( T ) then
        comm := Indeterminates( T );
    else
        comm := [ ];
    fi;
    
    comm := List( comm, Name );
    
    nr_anti := Length( anti );
    nr_comm := Length( comm );
    
    if nr_var <> nr_anti + nr_comm then
        Error( "number of indeterminates of the given ring does not equal the number of the new anti commuting and old commuting variables\n" );
    fi;
    
    if Intersection2( anti, var ) <> [ ] then
        Error( "the following indeterminate(s) are already elements of the base ring: ", Intersection2( anti, var ), "\n" );
    fi;
    
    if HasIndeterminatesOfPolynomialRing( R ) then
        r := CoefficientsRing( R );
    else
        r := R;
    fi;
    
    if HasRationalParameters( r ) then
        param := Concatenation( ",", JoinStringsWithSeparator( RationalParameters( r ) ) );
    else
        param := "";
    fi;
    
    return [ r, param, var, anti, comm ];
    
end );

##
InstallGlobalFunction( _PrepareInputForDoubleShiftAlgebra,
  function( R, indets )
    local var, nr_var, shift, nr_shift, r, param, base;
    
    ## check whether the base ring is polynomial and then extract needed data
    if IsFreePolynomialRing( R ) then
        if HasRelativeIndeterminatesOfPolynomialRing( R ) then
            var := RelativeIndeterminatesOfPolynomialRing( R );
        else
            var := IndeterminatesOfPolynomialRing( R );
        fi;
        nr_var := Length( var );
    else
        Error( "the given ring is not a free polynomial ring" );
    fi;
    
    var := List( var, Name );
    
    ## get the new indeterminates (the shifts) for the ring and save them in shift
    if IsString( indets ) and indets <> "" then
        shift := SplitString( indets, "," );
    elif indets <> [ ] and ForAll( indets, i -> IsString( i ) and i <> "" ) then
        shift := indets;
    else
        Error( "either a non-empty list of indeterminates or a comma separated string of them must be provided as the second argument\n" );
    fi;
    
    nr_shift := Length( shift );
    
    if nr_var <> 1/2 * nr_shift then
        Error( "the number of indeterminates of the given polynomial ring is not half the number of specified shifts\n" );
    fi;
    
    if Intersection2( shift, var ) <> [ ] then
        Error( "the following indeterminate(s) are already elements of the polynomial ring: ", Intersection2( shift, var ), "\n" );
    fi;
    
    if HasIndeterminatesOfPolynomialRing( R ) then
        r := CoefficientsRing( R );
    else
        r := R;
    fi;
    
    if HasRationalParameters( r ) then
        param := Concatenation( ",", JoinStringsWithSeparator( RationalParameters( r ) ) );
    else
        param := "";
    fi;
    
    if HasBaseRing( R ) and HasCoefficientsRing( R ) and
       not IsIdenticalObj( BaseRing( R ), CoefficientsRing( R ) ) and
       HasIndeterminatesOfPolynomialRing( BaseRing( R ) ) then
        base := IndeterminatesOfPolynomialRing( BaseRing( R ) );
        base := List( base, Name );
    else
        base := "";
    fi;
    
    return [ r, var, shift, param, base ];
    
end );

##
InstallMethod( RelationsOfBiasedDoubleShiftAlgebra,
        "for homalg rings",
        [ IsHomalgExternalRingRep, IsList ],
        
  function( R, indets )
    local ar, r, var, shift, param, base, all, F, b, n, rels,
          base_var, l, i, j, pairs, Ds, D_s, steps;
    
    ar := _PrepareInputForDoubleShiftAlgebra( R, indets );
    
    r := ar[1];
    var := ar[2];
    shift := ar[3];
    param := ar[4];
    base := ar[5];
    
    all := Concatenation( base, var, shift );
    
    F := FreeAssociativeRing( r, all );
    
    b := Length( base );
    
    n := Length( shift ) / 2;
    
    steps := ValueOption( "steps" );
    
    if IsRat( steps ) then
        steps := ListWithIdenticalEntries( n, steps );
    elif not ( IsList( steps ) and Length( steps ) = n and ForAll( steps, IsRat ) ) then
        steps := ListWithIdenticalEntries( n, 1 );
    fi;
    
    rels := [ ];
    
    base_var := Concatenation( base, var );

    l := Length( base_var );
    
    for i in [ 1 .. l ] do
        for j in [ i + 1 .. l ] do
            Add( rels, Concatenation( base_var[i], "*", base_var[j], "-", base_var[j], "*", base_var[i] ) / F );
        od;
    od;
    
    pairs := IsIdenticalObj( ValueOption( "pairs" ), true );
    
    if pairs then
        Ds := shift{List( [ 1 .. n ], i -> 2 * i - 1 )};
        D_s := shift{List( [ 1 .. n ], i -> 2 * i )};
    else
        Ds := shift{[ 1 .. n ]};
        D_s := shift{[ n + 1 .. 2 * n ]};
    fi;
    
    l := Length( base );
    
    for i in [ 1 .. n ] do
        for j in [ 1 .. l ] do
            Add( rels, Concatenation( Ds[i], "*", base[j], "-", base[j], "*", Ds[i] ) / F );
            Add( rels, Concatenation( D_s[i], "*", base[j], "-", base[j], "*", D_s[i] ) / F );
        od;
    od;
    
    for i in [ 1 .. n ] do
        for j in [ i + 1 .. n ] do
            Add( rels, Concatenation( Ds[i], "*", Ds[j], "-", Ds[j], "*", Ds[i] ) / F );
            Add( rels, Concatenation( D_s[i], "*", D_s[j], "-", D_s[j], "*", D_s[i] ) / F );
        od;
    od;
    
    for i in [ 1 .. n ] do
        for j in Concatenation( [ 1 .. i - 1 ], [ i + 1 .. n ] ) do
            Add( rels, Concatenation( Ds[i], "*", D_s[j], "-", D_s[j], "*", Ds[i] ) / F );
            Add( rels, Concatenation( Ds[i], "*", var[j], "-", var[j], "*", Ds[i] ) / F );
            Add( rels, Concatenation( D_s[i], "*", var[j], "-", var[j], "*", D_s[i] ) / F );
        od;
    od;
    
    steps := ValueOption( "steps" );
    
    if IsRat( steps ) then
        steps := ListWithIdenticalEntries( n, steps );
    elif not ( IsList( steps ) and Length( steps ) = n and ForAll( steps, IsRat ) ) then
        steps := ListWithIdenticalEntries( n, 1 );
    fi;

    steps := List( steps, String );
    
    for i in [ 1 .. n ] do
        Add( rels, Concatenation( Ds[i], "*", var[i], "-", var[i], "*", Ds[i], "+(", steps[i], ")*", Ds[i] ) / F );
        Add( rels, Concatenation( D_s[i], "*", var[i], "-", var[i], "*", D_s[i], "-(", steps[i], ")*", D_s[i] ) / F );
        Add( rels, Concatenation( Ds[i], "*", D_s[i], "-1" ) / F );
    od;
    
    return HomalgMatrix( rels, Length( rels ), 1, F );
    
end );
