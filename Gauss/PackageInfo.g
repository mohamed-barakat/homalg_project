SetPackageInfo( rec(

PackageName := "Gauss",

Subtitle := "Extended Gauss functionality for GAP",

Version := "2020.10-02",

Date := Concatenation( "01/", ~.Version{[ 6, 7 ]}, "/", ~.Version{[ 1 .. 4 ]} ),

License := "GPL-2.0-or-later",

Persons := [
  rec( 
    FirstNames    := "Simon",
    LastName      := "Görtzen",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "simon.goertzen@rwth-aachen.de",
    WWWHome       := "https://www.linkedin.com/in/simongoertzen/",
    PostalAddress := Concatenation( [
                       "Simon Görtzen\n",
                       "Lehrstuhl B fuer Mathematik, RWTH Aachen\n",
                       "Templergraben 64\n",
                       "52062 Aachen\n",
                       "Germany" ] ),
    Place         := "Aachen",
    Institution   := "RWTH Aachen University"
  ),
  rec(
    FirstNames := "Mohamed",
    LastName := "Barakat",
    IsAuthor := false,
    IsMaintainer := true,
    Email := "mohamed.barakat@uni-siegen.de",
    WWWHome := "https://mohamed-barakat.github.io",
    PostalAddress := Concatenation(
               "Walter-Flex-Str. 3\n",
               "57072 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
  rec(
    FirstNames := "Sebastian",
    LastName := "Gutsche",
    IsAuthor := false,
    IsMaintainer := true,
    WWWHome := "https://sebasguts.github.io",
    Email := "gutsche@mathematik.uni-siegen.de",
    PostalAddress := Concatenation(
               "Department Mathematik\n",
               "Universität Siegen\n",
               "Walter-Flex-Straße 3\n",
               "57072 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
],

Status := "deposited",

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/homalg_project",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://homalg-project.github.io/pkg/Gauss",
PackageInfoURL  := "https://homalg-project.github.io/homalg_project/Gauss/PackageInfo.g",
README_URL      := "https://homalg-project.github.io/homalg_project/Gauss/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/homalg_project/releases/download/Gauss-", ~.Version, "/Gauss-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz .zip",

AbstractHTML := 
"The <span class=\"pkgname\">Gauss</span> package provideds extended Gauss functionality for <span class=\"pkgname\">GAP</span>",
PackageDoc := rec(
  BookName  := "Gauss",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Extended Gauss functionality for GAP",
  Autoload  := false
),

Dependencies := rec(
  GAP := ">=4.8",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [ [ "GAPDoc", ">= 1.0" ] ],
  ExternalConditions := []
                      
),

AvailabilityTest := function()
  if (not("gauss" in SHOW_STAT())) and
     (Filename(DirectoriesPackagePrograms("gauss"), "gauss.so") = fail) then
    LogPackageLoadingMessage( PACKAGE_INFO, "Gauss C-module was not compiled!", "Gauss" );
    LogPackageLoadingMessage( PACKAGE_INFO, "Gauss will work, but slower.", "Gauss" );
  fi;
  return true;
end,

Autoload := false,


Keywords := ["Gauss", "RREF", "sparse" ]

));
