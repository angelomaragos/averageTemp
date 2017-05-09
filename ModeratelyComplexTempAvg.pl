#Author: Angelo Maragos
# Moderately Complex Perl Programming  - Avg Temp
# Purpose:
     # This program finds the avg temprature from
     # series of temprature data entered by user from command line...
     # Output is printed to screen and local file
     # Also uses cpan Weather::Airport module for current weather conditions.
     # usage: AngeloMaragosModeratelyComplexTempAvg.pl



use strict;
use warnings;
use Weather::Airport;  # Only cpan weather module I could find that didn't require use of API key to function. http://search.cpan.org/~droogie/Weather-Airport-1.0/lib/Weather/Airport.pm



print "Enter the number of days you'd like to find the avg temprature for: ";
my $howMany = <>; # stores command line input of number of temps/data to be entered
print "Number of days you're going to find the average temprature for: $howMany  \n \n \n";



my $input;
my @temp;  # store temps entered from command line
my $cntr = 0;  #initialize $cntr to 0
my $tempFinal = 0 ;  #initialize temp1 to 0


print"Enter individual daily temp data and press enter: \n";

while ($cntr < $howMany)  #while cntr less than num of temps user will enter
  {

		$input =<>; #i$nput is equal to what is entered from command line
		$temp[$cntr] =  $input;  #command line input storted in element of $temp array...used to store and eventually write each temp entered to txt file
		$tempFinal = $tempFinal + $temp[$cntr];  #$tempFinal on going tally of temp data entered
		$cntr = $cntr + 1;  #increment $cntr

   }




 my $avg = $tempFinal / $howMany;  #calculate avg temp

 print "Based on the data entered, the average temprature is: $avg \n";
 print "This information has been saved to local data.txt file \n";


 open (MYFILE, '>>data.txt');   # open filehandle, (append) pointing to data.txt
 print MYFILE "The recorded tempratures are: \n";  #printing to file
 print MYFILE" ";  #printing to file
 print MYFILE "@temp";  #print temp array to file
 print MYFILE "The average temprature is: $avg \n";    #printing to file
 close (MYFILE);   #close finlehandle


 print "Would you like to see current weather conditions in your area? y or n? \n";
my $question = <>;
 if ($question =~ /^[Y]?$/i)  #Matching on yY or blank input from command line.... if not matching, end
 {
		print"What airport are you near? Enter the airport code (eg: LAX or JFK) \n";
		my $aPort = <>; #airport code from command prompt

		use Weather::Airport;                 #pull current weather conditions from airport code sp
		my $wa = Weather::Airport->new;
		my $airport = $wa->query($aPort);  #from airport code sp
		use Data::Dumper;
		print Dumper ($airport);  #print/display results

		open (MYFILE, '>>data.txt');   # open filehandle, (append) pointing to data.txt
		print MYFILE "The weather conditions in your area are: \n \n";   #printing to file
		print MYFILE Dumper ($airport);  #printing to file
		close (MYFILE);   #close finlehandle

		print "The current weather information has been saved to local data.txt file \n";   #print to screen
		print "End";
 }

 else
  {
		print "End";
  }
