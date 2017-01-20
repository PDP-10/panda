!* -*-TECO-*- *!

!~Filename~:! !S Split a big file into smaller ones for editing.!
SPLIT

!Split File:! !C Split a big file into smaller ones for editing.
Takes name of file to split as string argument.
Divides it into subfiles of about 250,000 characters.
These subfiles have second names "1", "2", etc.
and the same first name as the original file.
A numeric argument indicates a subfile size other than 250,000.!

    5,f File_to_split[0
    er0			    !* Start reading the file.!
    f[b bind
    0[1 [3			    !* Q1 counts subfiles made so far.!
    [2 "e 250000u2'		    !* Q2 gets size of subfiles; default 250000.!
    < fs lastpage;		    !* Stop if at eof in original file.!
      q2fy			    !* Read a lot of data.!
      :A			    !* Keep going past end of a line.!
      %1:\u3
      f63 fs d fn2		    !* Increment count and set FN2.!
      ei hp ef			    !* Write out what we got as next subfile.!
      hk >			    !* Go around again.!
    

!Unsplit File:! !C Put edited subfiles back together.
Takes name of combined file as string argument.
The subfiles, whose second names are numbers "1", "2", etc.
and whose first names match the combined file,
are concatenated and the result is written as the combined file.!

    5,f File_to_unsplit[0
    et0 ei			    !* Open combined file for writing.!
    f[b bind
    0[1 [3			    !* Count subfiles read so far.!
    < %1:\u3
      f63 fs d fn2		    !* Increment count and set FN2.!
      1:< er @y hp hk		    !* Read subfile and copy into combined file.!
          >:;			    !* Error opening subfile =>!
				    !* all subfiles processed, so return.!
      >
    et0 ef			    !* Close combined file (under correct name).!
    
