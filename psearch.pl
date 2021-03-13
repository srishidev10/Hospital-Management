use Tk;
use DBI;
my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();my $user =$mw->Label(-text=>"Patient Name:",-justify=>'center')->pack(-side=>'top');
my $entry = $mw->Entry()->pack();my $but1 = $mw->Button(-text=>"Search Patient",-command=>\&push_button);
$but1 -> pack();
                                MainLoop;sub push_button{
	my $details =$mw->Label(-text=>"Patient Details:",-justify=>'center')->pack(-side=>'top');
	$name=$entry->get();	my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
	my $query="SELECT * FROM out_patient where name='".$name."'";
	my $sth=$dbh->prepare($query) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth->execute() or die "Can't execute SQL statement:",$sth->errstr(),"\n";
        my @row1;
	my $patid;
	my $patname;
	my $patguard;
	my $patage;
	my $patgender;
	while(@row1=$sth->fetchrow_array){
		$patid = $row1[0];
		$patname = $row1[1];
		$patguard = $row1[2];
		$patage = $row1[3];
		$patgender = $row1[4];
	}
	my $msg1=$mw->Label(-text=>"Patient ID:".$patid,-justify=>'left')->pack();
	my $msg2=$mw->Label(-text=>"Patient Name:".$patname)->pack();
	my $msg3=$mw->Label(-text=>"Patient Guardian:".$patguard)->pack();
	my $msg4=$mw->Label(-text=>"Patient Age:".$patage)->pack();
	my $msg5=$mw->Label(-text=>"Patient Gender:".$patgender)->pack();
	#print $patid.",".$patname.",".$patguard.",".$patage.",".$patgender;
	my $but3 = $mw->Button(-text=>"Go to Menu",-justify=>'center',-command=>\&push_button2);
	$but3 -> pack(-side=>'top');
}
sub push_button2{
	$mw->destroy;
	system("menu.pl");
}
