#############################################################################
##
##  RingsForHomalg.gd         RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for RingsForHomalg.
##
#############################################################################


# our info class:
DeclareInfoClass( "InfoRingsForHomalg" );
SetInfoLevel( InfoRingsForHomalg, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_RINGS" );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_PrepareInputForRingOfDerivations" );

DeclareGlobalFunction( "_PrepareInputForExteriorRing" );

DeclareGlobalFunction( "_PrepareInputForDoubleShiftAlgebra" );

# constructor methods:

DeclareGlobalFunction( "HomalgRingOfIntegersInDefaultCAS" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInDefaultCAS" );

