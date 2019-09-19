#!usr/bin/perl -w
use strict;
use warnings;
# *************************************************
# * Copyright 2013 Shakti Kumar
# * 
# * parsing_blasttable_accoding_to_Eval_and_seqID.pl is a part of highly diverse and essential protease extraction.
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
my($line, @lineArray, %nodeAssoArray);
my($i, $line1, $node, $evalue);
open(INFILE, "blast_result_in_table_form");
open(OUTFILE, ">filtering_those_sequences_whose_Eval_lessthaneq_04_and_seqID_lessthaneq_35");
while($line = <INFILE>)
{
  $line =~ s/^\s+|\s+$//g;
  @lineArray = split(/\s+/, $line);
  $nodeAssoArray{$lineArray[0]} += 1;
}
close(INFILE);
foreach $node (keys(%nodeAssoArray))
{
  open(INFILE, "cytsteine_proteases_of_hel_protz_seqs_agst_mammalian_table");
  my(@seqIDarray, @sortedseqIDarray, @sortedEvalArray, @lineArray1, $i, @EvalArray);
  $i = 0;
  while($line1 = <INFILE>)
      {
         if($line1 =~ /$node/g)
           {
             $line1 =~ s/^\s+|\s+$//g;
             @lineArray1 = split(/\s+/, $line1);
             $lineArray1[2] =~ s/^\s+|\s+$//g;
             $lineArray1[10] =~ s/^\s+|\s+$//g;
             $EvalArray[$i] = $lineArray1[10];
             $seqIDarray[$i] = $lineArray1[2];
             $i = $i + 1;
           }
      }
  close(INFILE);
  @sortedseqIDarray = sort{$b<=>$a}@seqIDarray;
  @sortedEvalArray = sort{$a<=>$b}@EvalArray;
  #print OUTFILE ("node: $node\n");
  #print OUTFILE ("sorted seqID array: @sortedseqIDarray\n");
  #print OUTFILE ("sorted Eval array: @sortedEvalArray\n");
  if(($sortedEvalArray[0] <= 1e-004)&&($sortedseqIDarray[0] <= 35.00))
    {
      print("$node\t$sortedseqIDarray[0]\t$sortedEvalArray[0]\n");
      print OUTFILE ("$node\t$sortedseqIDarray[0]\t$sortedEvalArray[0]\n");
    }  
  undef(@seqIDarray);
  undef(@sortedseqIDarray);
  undef(@sortedEvalArray);
  undef(@lineArray1);
  undef(@EvalArray);
}
   
   
