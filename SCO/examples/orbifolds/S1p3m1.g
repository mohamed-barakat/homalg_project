# S1 of p3m1

# http://en.wikipedia.org/wiki/Wallpaper_group#Group_p3m1

M := [ [1,2], [1,3], [2,5], [3,7], [5,6], [6,7] ];

S3 := Group( (1,2,3), (1,2) );

iso := rec( 1 := S3, 5 := S3, 7 := S3,
                 2 := Group( (1,2) ), 3 := Group( (1,3) ), 6 := Group( (2,3) ) );

mu := [];

dim := 3;

#----------------------------------------------->>>>  Z^(1 x 1)
#----------------------------------------------->>>>  Z^(1 x 1)
#----------------------------------------------->>>>  Z/< 2 >

