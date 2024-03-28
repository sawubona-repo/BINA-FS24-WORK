# ----------------------------------------------------------------------------------#
# extract_vbz_linie_infos.pl
# ++++++++++++++++++++++++++
#
# Perl Script zur Extraktion der in einer Fahrzeitendatei enthaltenen Linien von VBZ Verbindungen (Tram, Bus)
# Datenquellen: Fahrzeiten SOLL IST pro Woche gemäss https://data.stadt-zuerich.ch/dataset/vbz_fahrzeiten_ogd
# 
# 10.05.23/dbe - version für BINA FS23 / Case Study VBZ IST SOLL Fahrzeitenvergleich
# ----------------------------------------------------------------------------------
# 
# usage:   extract_vbz_linie_infos.pl file-directory input-file
#
#			file-directory	= Verzeichnis der Dateiablagen (input, wie output)
#			input-file 		= Fahrzeiten SOLL IST Datei gemäss VBZ Fahrzeiten OGD Plattform
#
#
# Perl Scripting: see https://www.perl.org/ for more information of Perl 
# 				  and executables to download for Unix/Windows/macOPS
# ----------------------------------------------------------------------------------

# use ARGV to verify the correct number of perl command line arguments
@ARGV == 2 or die "usage: extract_vbz_linie_infos.pl file-directory input-file\n";

$directory_files = $ARGV[0];
$input_file_name = $ARGV[1];

# open the FIN (or die trying)
$f_input = $directory_files."/".$input_file_name;
open(FIN, $f_input) or die "Could not read from $f_input, program halting: $!";


# loop through the FIN; start processing when you get to the first_line
# exit the program when you get to last_line.
$count_tot = 0;
$line_list = "";

while (<FIN>)
{
  # split a single file record into column elements (separated by ",")
  my @data = split(/,/,$_);
  
  my $line_nr = "/".$data[0]."/";
  
  if ($count_tot > 0)
  {
	if (index($line_list, $line_nr) == -1)
	{
		$line_list = $line_list.$line_nr;
	}
  } 
  
  # increment the total counter
  $count_tot++;
}

# document the list of line number within this input file
print ("\n----------------------");
print ("\nInputfile            :",$input_file_name);
print ("\nTotal Scanned Records:", $count_tot);
print ("\nFound VBZ Lines      :", $line_list);

# close the input channels
close FIN;
