(FILECREATED "23-SEP-81 22:40:46" ("compiled on " <LISPUSERS>MSSWAP.;8) 
(2 . 2) bcompl'd in WORK dated NOBIND)
(FILECREATED " 1-OCT-80 20:57:30" <LISPUSERS>MSSWAP.;8 2370 changes to: 
MSSWAPCOMS previous date: "30-JUL-79 21:45:58" <LISPUSERS>MSSWAP.;7)

ADDTABLE BINARY
           �    �-.           �,<` �"  
3B   +   ,<` �,<` ,<` �&  �,~   ,<` �,<` ,<` �&  ,~      (X . 1)
(V . 1)
(H . 1)
SWPARRAYP
SADDHASH
ADDHASH
(KNIL ENTER3)  8      

EQMEMBTABLE BINARY
     �    	    -.           	,<` �"  �3B   +   ,<` �,<` ,<` �&  ,~   ,<` Z` �Z` �,   D  �,~     (X . 1)
(V . 1)
(H . 1)
SWPARRAYP
SEQMEMBHASH
MEMB
(GETHSH KNIL ENTER3)  �    �       

GETTABLE BINARY
     
    �    �-.           �,<` "  �3B   +   �,<` �,<` $  	,~   Z` �Z` ,   ,~      (X . 1)
(H . 1)
SWPARRAYP
SGETHASH
(GETHSH KNIL ENTER2)   x    8      

MAKETABLE BINARY
       �        -.           ,<` �"  �,~       (N . 1)
SHARRAY
(ENTER1)      

MAPTABLE BINARY
     �    �    
-.           �,<` �"  �3B   +   �,<` �,<` $  	,~   ,<` �,<` $  �,~      (H . 1)
(FN . 1)
SWPARRAYP
SMAPHASH
MAPHASH
(KNIL ENTER2)  �       

MEMBTABLE BINARY
    �    �    -.           �,<` �"  3B   +   ,<` �,<` ,<` �&  �,~   ,<` Z` �Z` �,   ,\  1B  +   -,   +   �*  ,   2B   7       ,~     (X . 1)
(V . 1)
(H . 1)
SWPARRAYP
SEQMEMBHASH
(KT FMEMB SKLST GETHSH KNIL ENTER3)           �    �    � H �       

PUTTABLE BINARY
         �    �-.           �,<` �"  
3B   +   ,<` �,<` ,<` �&  �,~   ,<` �,<` ,<` �&  ,~      (X . 1)
(V . 1)
(H . 1)
SWPARRAYP
SPUTHASH
PUTHASH
(KNIL ENTER3)  8      

SUBTABLE BINARY
            �    �-.           �,<` �"  
3B   +   ,<` �,<` ,<` �&  �,~   ,<` �,<` ,<` �&  ,~      (X . 1)
(V . 1)
(H . 1)
SWPARRAYP
SSUBHASH
SUBHASH
(KNIL ENTER3)  8      

TESTTABLE BINARY
       
    �    �-.           �,<` "  �3B   +   �,<` �,<` $  	,~   Z` �Z` ,   ,~      (X . 1)
(H . 1)
SWPARRAYP
STESTHASH
(GETHSH KNIL ENTER2)  x    8      
(PRETTYCOMPRINT MSSWAPCOMS)
(RPAQQ MSSWAPCOMS ((FILES (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) 
SWAPHASH) (* These replace masterscope functions) (FNS ADDTABLE 
EQMEMBTABLE GETTABLE MAKETABLE MAPTABLE MEMBTABLE PUTTABLE SUBTABLE 
TESTTABLE) (P (RELINK (QUOTE WORLD))) (LOCALVARS . T)))
(FILESLOAD (SYSLOAD FROM VALUEOF LISPUSERSDIRECTORIES) SWAPHASH)
(* These replace masterscope functions)
(RELINK (QUOTE WORLD))
NIL
   