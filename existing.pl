use Tk;
use DBI;
my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();
my $pname =$mw->Label(-text=>"Patient Name:")->pack();
my $ent = $mw->Entry()->pack();
my $but = $mw->Button(-text=>"Search",-command=>\&push_button2);
$but -> pack();
#display the patient details
my $msg=$mw->Label()->pack();




MainLoop;

sub push_button2{
	my $details =$mw->Label(-text=>"Patient Details:",-justify=>'center')->pack(-side=>'top'); 
	$name=$ent->get();
	my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
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
	
	
	my $but = $mw->Button(-text=>"Continue",-command=>\&push_button1);
	my $msg=$mw->Label()->pack();
	my $msg2=$mw->Label()->pack();
	my $msg3=$mw->Label()->pack();
	my $msg4=$mw->Label()->pack();
	my $msg5=$mw->Label()->pack();
	$but -> pack();
	
	
}

sub push_button1{
	$mw->destroy;
	system("suggest_doctor.pl");
}