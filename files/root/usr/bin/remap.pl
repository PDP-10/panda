#!/sys/perl

while (<>) {
    s/\n$//;
    print ($_,"\n");
    $file = $_ . "/remap.ambiguous";
    $remap = ">" . $_ . "/remap.h";
    open (FILE,$file);
    @syms = <FILE>;
    close FILE;
    @syms = sort @syms;
    $lastsym = "";
    $n = 1;
    open (REMAP,$remap);
sym: foreach (@syms) {
	next sym if ($_ eq $lastsym);
	$lastsym = $_;
	s/\n//;
	print REMAP ("#pragma private define ", $_, " gs_", $n, "\n");
	$n++;
    }
    close REMAP;
    close FILE;
}