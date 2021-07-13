Re-test Yang's package
07/13/2021
I tested on onyx /USERS_APP/Inlandbay/model_sandy. Here're problems:
1) PrgEnv-intel can't compile successfully due to some symbols in SWAN $
2) PrgEnv-cray works with a slight modification in sc_io.fsc file unit 100-200
3) SWAN didn't work properly with cray compiler. 

I got results from cases without wave, and w/wo winds. /with_wind /without_wind. I plotted figure in /post_retest/, which looks consistent with Lu et al 2018. 


------------ old documentation ---------
Postprocessing
/POSTPROCESSING/

Wave data /DATA/WAVE/
1) download WIS data from WIS website
2) copy/paste to make wave_sandy.txt
3) run mk_wave_field.m to generate wave_field.txt
4) cp wave_field.txt into DATA/WAVE/wave_field_east.txt, wave_field_north.txt and wave_field_south.txt

Boundary Condition /DATA/BC/
1) download surface elevation at LEWES station, lewes_sandy.txt
2) run mk_neasting.f to get coupling_sandy.txt

Elevation data
1) USGS stations rosedale: 01484540, inlet: 01484683, dewey: 01484670
2) remove head to rosedale_nohead.txt ...
3) run mk_lewes_usgs_data.m


FRICTION /DATA/FRICTION/




