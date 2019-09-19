#!usr/bin/perl -w
use strict;
use warnings;
# *************************************************
# * Copyright 2013 Shakti Kumar
# * 
# * extract_sequences_blastTable.pl is a part of highly diverse and essential protease extraction.
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
my(@SeqArray, @AllProteaseSeqArray, $i, $j, $limit);
my(@AllFastaLineArray, $line, @lineArray, $k, $lwlimit, $uplimit);
open(INFILE1, "those_sequences_whose_Eval_lessthaneq_04_and_seqID_lessthaneq_35");
open(INFILE2, "helminth_protozoan_protease_sequences.fasta");
open(OUTFILE, ">Highly_Diverse_and_Essential_sequences");
while(@SeqArray = <INFILE2>)
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
while($line = <INFILE1>)
{
  $line =~ s/^\s+|\s+$//g;
  @lineArray = split(/\s+/, $line);
  for($k=0; $k<@AllFastaLineArray-1; $k++)
     {
       $lwlimit = $AllFastaLineArray[$k];
       $uplimit = $AllFastaLineArray[$k+1];
       if($AllProteaseSeqArray[$lwlimit] =~ /$lineArray[0]/g)
         {
           print OUTFILE ($AllProteaseSeqArray[$lwlimit]);
           $limit = $lwlimit + 1;
            while($limit<$uplimit)
                 {
                    print OUTFILE ($AllProteaseSeqArray[$limit]);
                    $limit++;
                 }
         }
     }
}
