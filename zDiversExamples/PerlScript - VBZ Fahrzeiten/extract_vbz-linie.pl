# ----------------------------------------------------------------------------------#
# extract_vbz_linie.pl
# ++++++++++++++++++++
#
# Perl Script zur Extraktion der Fahrzeitendaten einer einzelnen Linie der VBZ Verbindungen (Tram, Bus)
# Datenquellen: Fahrzeiten SOLL IST pro Woche gemäss https://data.stadt-zuerich.ch/dataset/vbz_fahrzeiten_ogd
# 
# 10.05.23/dbe - version für BINA FS23 / Case Study VBZ IST SOLL Fahrzeitenvergleich
# ----------------------------------------------------------------------------------
# 
# usage:   extract_vbz_linie.pl file-directory input-file vbz-linie-nr
#
#			file-directory	= Verzeichnis der Dateiablagen (input, wie output)
#			input-file 		= Fahrzeiten SOLL IST Datei gemäss VBZ Fahrzeiten OGD Plattform
#			vbz-linie-nr	= zu extrahierende VBZ Tram/Bus Linie (Nummer)
#
#			Hinweis: der Dateiname wird an Hand des file-directory, der vbz-linie-nr und des input-files Names bestimmt
#
# Perl Scripting: see https://www.perl.org/ for more information of Perl 
# 				  and executables to download for Unix/Windows/macOPS
# ----------------------------------------------------------------------------------

# use ARGV to verify the correct number of perl command line arguments
@ARGV == 3 or die "usage: extract_vbz_linie.pl file-directory input-file vbz-linie-nr\n";

$directory_files = $ARGV[0];
$input_file_name = $ARGV[1];
$vbz_linie_nr = $ARGV[2];

# open the FIN (or die trying)
$f_input = $directory_files."/".$input_file_name;
open(FIN, $f_input) or die "Could not read from $f_input, program halting: $!";

# generate output-file name
$f_output = $directory_files."/Linie-".$vbz_linie_nr."_".$input_file_name;

# open the FOUT (or die trying)
open(FOUT, ">>$f_output") or die "Could not read from $f_output, program halting: $!";

# loop through the FIN; start processing when you get to the first_line
# exit the program when you get to last_line.
$count_tot = 0;
$count_found = 0;

while (<FIN>)
{
  if($count_tot==0)
  { 
	 # copy the headline record into the output file
	 print FOUT $_;
  } 
  
  # split a single file record into column elements (separated by ",")
  my @data = split(/,/,$_);
  
  # print the current line if line column value $data[0] is equal to $vbz_linie_nr
   if ($data[0] eq $vbz_linie_nr)
	{
		print FOUT $_;
		
		# increment the found counter
		$count_found++;
	}
  # increment the total counter
  $count_tot++;
}

# document the key figures of this extraction scan
print ("\n----------------------");
print ("\nFor VBZ Line Nr      :", $vbz_linie_nr);
print ("\nTotal lines scanned  :", $count_tot);
print ("\nTotal lines extracted:", $count_found); 
print ("\nAusgabedatei         :", $f_output);

# close the input/output channels
close FIN;
close FOUT;