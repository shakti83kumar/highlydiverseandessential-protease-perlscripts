#!usr/bin/perl -w
use strict;
use warnings;
# *************************************************
# * Copyright 2013 Shakti Kumar
# * 
# * extract_protease_domain.pl is a part of highly diverse and essential protease extraction.
# * It free software. User can redistribute it and/or modify
# * It under the terms of the GNU General Public License as published by
# * the Free Software Foundation, either version 3 of the License, or
# * (at your option) any later version.
# * 
# * It is distributed in the hope that it will be useful,
# * but WITHOUT ANY WARRANTY; without even the implied warranty of
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# * GNU General Public License for more details.
# * 
# * You should have received a copy of the GNU General Public License.
# * If not, see <http://www.gnu.org/licenses/>.
# ***************************************************
my(@SeqArray, @AllProteaseSeqArray, $i, @FastLineArray, $lenFastLineArray);
my($DomainBod, @DomainBodArray, $j, @AllFastaLineArray, $lwlimit, $uplimit, $k, $skipchar);
my($FastaSeqLine, $limit1, @SequenceArray, $SequenceLine, @SequenceLineArray, $DomainSeq, $DomainSeqLen);
open(INFILE, "protease_sequences");
open(OUTFILE, ">proteolytic_domain_of_protease_sequences");
while(@SeqArray = <INFILE>)
{
  @AllProteaseSeqArray = @SeqArray;
}
push(@AllProteaseSeqArray, ">");
$j = 0;
for($i = 0; $i<@AllProteaseSeqArray; $i++)
   {
     if($AllProteaseSeqArray[$i] =~ /^>/)
       {
          $AllFastaLineArray[$j] = $i;
          $j++;
       }
   }
##########################################
for($k=0; $k<@AllFastaLineArray-1; $k++)
     {
       $lwlimit = $AllFastaLineArray[$k];
       $uplimit = $AllFastaLineArray[$k+1];
       if($AllProteaseSeqArray[$lwlimit] =~ /^>/g)
         {
           print OUTFILE ($AllProteaseSeqArray[$lwlimit]);
           $FastaSeqLine = $AllProteaseSeqArray[$lwlimit];
           $FastaSeqLine =~ s/^\s+|\s+$//g;
           @FastLineArray = split(/\s+/, $FastaSeqLine);
           $lenFastLineArray = @FastLineArray;
           $FastLineArray[$lenFastLineArray-1] =~ s/\{|\}//g;
           $DomainBod = $FastLineArray[$lenFastLineArray-1];
           @DomainBodArray = split(/-/, $DomainBod); 
           print("$FastLineArray[0]\t$FastLineArray[$lenFastLineArray-1]\tlowlimit:$DomainBodArray[0]\tuplimit:$DomainBodArray[1]\n");
       }
       $limit1 = $lwlimit+1;
       my $y1 = 0;
       while($limit1<$uplimit)
           {
              #print("inhibitor: lowlimit: $lwlimit and uplimit: $uplimit\n");
              $AllProteaseSeqArray[$limit1] =~ s/^\s+|\s+$//g;
              $SequenceArray[$y1] = $AllProteaseSeqArray[$limit1];
              #print OUTFILE1 ($AllProteaseSeqArray[$lwlimit]);
              $limit1++;
              $y1++;
           }
       $SequenceLine = join("", @SequenceArray);
       $SequenceLine =~ s/^\s+|\s+$//g;
       $SequenceLine =~ s/\s+//g;
       $skipchar = $DomainBodArray[0]-1;
       $DomainSeqLen = $DomainBodArray[1]-$DomainBodArray[0];
       $DomainSeqLen = $DomainSeqLen + 1;
       $DomainSeq = substr($SequenceLine, $skipchar, $DomainSeqLen);
       print OUTFILE ("$DomainSeq\n");
   }
