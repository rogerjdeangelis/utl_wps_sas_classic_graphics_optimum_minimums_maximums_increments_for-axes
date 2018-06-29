WPS SAS classic graphics optimum minimums maximums increments for axes

Problem: Calculate the optimum options for X and Y axis

 Worked in WPS and SAS
 Output graph looked better in WPS (hardware fonts?)

for SAS output graphic
https://tinyurl.com/y9kara6y
https://github.com/rogerjdeangelis/utl_wps_sas_classic_graphics_optimum_minimums_maximums_increments_for-axes/blob/master/utl_wps_sas_classic_graphics_optimum_minimums_maximums_increments_for%20axes.png

for wps
https://tinyurl.com/y9smj89k
https://github.com/rogerjdeangelis/utl_wps_sas_classic_graphics_optimum_minimums_maximums_increments_for-axes/blob/master/utl_wps_sas_classic_graphics_optimum_minimums_maximums_increments_for%20axesx.png

see github
https://tinyurl.com/yauxb4za
https://github.com/rogerjdeangelis/utl_wps_sas_classic_graphics_optimum_minimums_maximums_increments_for-axes


INPUT
=====

NOTE: This a dataset not a static printed plot (ods output from proc plot)
Comment:  Proc print should be updated to produce aods datasets

WORK.PLTOUT total obs=30

             BATCH

HEIGHT *WEIGHT.  Legend: A = 1 obs, B = 2 obs, etc.

   |
75 +
   |
   |                                             A
   |
70 +
   |                              A
   |                                      A
   |                              B
65 +                        A           A
   |                     A    A
   |                   A      A   A
   |
60 +                   A
   |                         A
   |                  AA
   |                A  A
55 +
   |
   |
   |     A
50 +
   |
   --+-------+-------+-------+-------+-------+-------+--
    40      60      80      100     120     140     160


EXAMPLE OUTPUT

Two macro variable X_Tics and Y_Tics

X_TICS=40,60,80,100,120,140,160
Y_TICS=50,55,60,65,70,75

PROCESS
=======

  Extract axis information from proc plot output

  data _null_;
    length y_tics x_tics $1024;
    retain  y_tics x_tics;
    set pltOut;
    if  index(batch,'|') = 0;
    select;
      when ( input(scan(left(batch),1,' '), ?? best.) ) do;
              tic=scan(batch,1,'+');
              y_tics=catx(',',tic,y_tics);
      end;
      when (index(batch,'-') > 0 ) do;
          pt=_n_+1;
          set pltOut point=pt;
          x_tics=translate(strip(compbl(batch)),',',' ');
          call symputx('x_tics',x_tics);
          call symputx('y_tics',y_tics);
          stop;
      end;
      otherwise;
    end;
  run;quit;

  %put &=x_tics;
  %put &=y_tics;

  * plot using gplot;

  %utlfkil(d:/png/utl_wps_sas_classic_graphics_optimum_minimums_maximums_increments_for axes.png);

  filename outfile "d:/png/utl_wps_sas_classic_graphics_optimum_minimums_maximums_increments_for axes.png";
  goptions
      reset=global
      gsfmode = replace
      device  = png
      gsfname = outfile
      vsize=4in
      hsize=4in
      htext=2 ;
    run;quit;

  axis1 order=(&x_tics);
  axis2 order=(&y_tics);
  proc gplot data = sashelp.class;
  plot height * weight /
  haxis=axis1
  vaxis=axis2;
  run;quit;

  filename outfile clear;


OUTPUT
======

  X_TICS=40,60,80,100,120,140,160
  Y_TICS=50,55,60,65,70,75

  https://tinyurl.com/y9kara6y

  https://tinyurl.com/y9smj89k

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;

options ls=80 ps=48;

   ods output plot=pltOut;
   proc plot data=sashelp.class;
      plot height*weight;
   run;quit;

options ls=171 ps=66;

ods trace off;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

for SAS see process

* here is wps


 libname hlp sas7bdat "C:\Program Files\SASHome\SASFoundation\9.4\core\sashelp";
  proc plot data=hlp.class;
    plot (height weight) * age / overlay;
  run;quit;
 axis1 order=(11 to 16 by 1);
 axis2 order=(50 to 150 by 5);
 PROC GPLOT DATA = hlp.class;
 PLOT height * age /
 HAXIS=AXIS1
 VAXIS=AXIS2;
 run;quit;
');


%utl_submit_wps64('
  libname wrk  sas7bdat "%sysfunc(pathname(work))";
  libname hlp  sas7bdat "C:\Progra~1\SASHome\SASFoundation\9.4\core\sashelp";
  data _null_;
    length y_tics x_tics $1024;
    retain  y_tics x_tics;
    set wrk.pltOut;
    if  index(batch,"|") = 0;
    select;
      when ( input(scan(left(batch),1," "), ?? best.) ) do;
              tic=scan(batch,1,"+");
              y_tics=catx(",",tic,y_tics);
      end;
      when (index(batch,"-") > 0 ) do;
          pt=_n_+1;
          set pltOut point=pt;
          x_tics=translate(strip(compbl(batch)),","," ");
          call symputx("x_tics",x_tics);
          call symputx("y_tics",y_tics);
          stop;
      end;
      otherwise;
    end;
  run;quit;

  %put &=x_tics;
  %put &=y_tics;

  filename outfile "d:/png/utl_wps_sas_classic_graphics_optimum_minimums_maximums_increments_for axesx.png";
  goptions
      reset=global
      gsfmode = replace
      device  = png
      gsfname = outfile
      vsize=4in
      hsize=4in
      htext=2 ;
    run;quit;

  axis1 order=(&x_tics);
  axis2 order=(&y_tics);
  proc gplot data = hlp.class;
  plot height * weight /
  haxis=axis1
  vaxis=axis2;
  run;quit;

  filename outfile clear;
');

