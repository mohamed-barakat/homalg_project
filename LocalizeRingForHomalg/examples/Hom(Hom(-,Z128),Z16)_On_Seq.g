##  <#GAPDoc Label="HomHomZ128">
##  <Section Label="HomHomZ128">
##  <Heading>Hom(Hom(-,Z128),Z16)</Heading>
##  The following example is taken from Section 2 of <Cite Key="BREACA"/>. <Br/><Br/>
##  The computation takes place over the local ring <M>R=&ZZ;_{\langle 2\rangle}</M>
##  (i.e. &ZZ; localized at the maximal ideal generated by <M>2</M>). <P/>
##  Here we compute the (infinite) long exact homology sequence of the
##  covariant functor <M>Hom(Hom(-,R/2^7R),R/2^4R)</M> (and its left derived functors)
##  applied to the short exact sequence<Br/><Br/>
##  <Alt Not="Text,HTML"><Math>0 \longrightarrow M\_=R/2^2R \stackrel{\alpha_1}{\longrightarrow}
##  M=R/2^5R \stackrel{\alpha_2}{\longrightarrow} \_M=R/2^3R \longrightarrow 0</Math></Alt>
##  <Alt Only="Text,HTML"><M>0 -> M_=R/2^2R --alpha_1--> M=R/2^5R --alpha_2--> \_M=R/2^3R -> 0</M></Alt>.
##  <Example><![CDATA[
##  gap> LoadPackage( "LocalizeRingForHomalg" );;
##  gap> GlobalR := HomalgRingOfIntegersInExternalGAP(  );
##  Z
##  gap> Display( GlobalR );
##  <An external ring residing in the CAS GAP>
##  gap> LoadPackage( "RingsForHomalg" );;
##  gap> R := LocalizeAt( GlobalR , [ 2 ] );
##  Z_< 2 >
##  gap> Display( R );
##  <A local ring>
##  gap> M := LeftPresentation( HomalgMatrix( [ 2^5 ], R ) );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> _M := LeftPresentation( HomalgMatrix( [ 2^3 ], R ) );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> alpha2 := HomalgMap( HomalgMatrix( [ 1 ], R ), M, _M );
##  <A "homomorphism" of left modules>
##  gap> M_ := Kernel( alpha2 );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> alpha1 := KernelEmb( alpha2 );
##  <A monomorphism of left modules>
##  gap> seq := HomalgComplex( alpha2 );
##  <A "complex" containing a single morphism of left modules at degrees
##  [ 0 .. 1 ]>
##  gap> Add( seq, alpha1 );
##  gap> IsShortExactSequence( seq );
##  true
##  gap> K := LeftPresentation( HomalgMatrix( [ 2^7 ], R ) );
##  <A cyclic left module presented by 1 relation for a cyclic generator>
##  gap> L := RightPresentation( HomalgMatrix( [ 2^4 ], R ) );
##  <A cyclic right module on a cyclic generator satisfying 1 relation>
##  gap> triangle := LHomHom( 4, seq, K, L, "t" );
##  <An exact triangle containing 3 morphisms of left complexes at degrees
##  [ 1, 2, 3, 1 ]>
##  gap> lehs := LongSequence( triangle );
##  <A sequence containing 14 morphisms of left modules at degrees [ 0 .. 14 ]>
##  gap> ByASmallerPresentation( lehs );
##  <A non-zero sequence containing 14 morphisms of left modules at degrees
##  [ 0 .. 14 ]>
##  gap> IsExactSequence( lehs );
##  true
##  ]]></Example>
##  </Section>
##  <#/GAPDoc>
LoadPackage( "RingsForHomalg" );;
GlobalR := HomalgRingOfIntegersInExternalGAP(  );;

LoadPackage( "LocalizeRingForHomalg" );;
R := LocalizeAt( GlobalR , [ 2 ] );

LoadPackage( "Modules" );
M := LeftPresentation( HomalgMatrix( [ 2^5 ], R ) );
_M := LeftPresentation( HomalgMatrix( [ 2^3 ], R ) );
alpha2 := HomalgMap( HomalgMatrix( [ 1 ], R ), M, _M );
M_ := Kernel( alpha2 );
alpha1 := KernelEmb( alpha2 );
seq := HomalgComplex( alpha2 );
Add( seq, alpha1 );
IsShortExactSequence( seq );
K := LeftPresentation( HomalgMatrix( [ 2^7 ], R ) );
L := RightPresentation( HomalgMatrix( [ 2^4 ], R ) );
triangle := LHomHom( 4, seq, K, L, "t" );
lehs := LongSequence( triangle );
ByASmallerPresentation( lehs );
IsExactSequence( lehs );
