use Tk;
use DBI;
my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();
my $user =$mw->Label(-text=>"Enter Patient Name:",-justify=>'center')->pack(-side=>'top');
my $entry = $mw->Entry()->pack();

my $msgg=$mw->Label()->pack();
my $msgg2=$mw->Label()->pack();
my $msgg3=$mw->Label()->pack();
my $msgg4=$mw->Label()->pack();
my $msgg5=$mw->Label()->pack();
my $but1 = $mw->Button(-text=>"Generate Bill",-command=>\&push_button);
$but1 -> pack();
                                my $msg=$mw->Label()->pack();
my $msggg2=$mw->Label()->pack();
my $msggg3=$mw->Label()->pack();
my $msggg4=$mw->Label()->pack();
my $msggg5=$mw->Label()->pack();


MainLoop;

sub push_button{
	
	my $details =$mw->Label(-text=>"Patient Details:",-justify=>'center')->pack(-side=>'top');
	$name=$entry->get();
	my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
	my $query="SELECT p_id FROM out_patient where name='".$name."'";
	my $sth=$dbh->prepare($query) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth->execute() or die "Can't execute SQL statement:",$sth->errstr(),"\n";
        my @row1;
	my $patid;
	while(@row1=$sth->fetchrow_array){
		$patid = $row1[0];
	}
	print $patid;
	
	my $select="select d_id from record where p_id=".$patid;
		my $sthh=$dbh->prepare($select);
		$sthh->execute();
		my @roww;
		my $did;
		while(@roww=$sthh->fetchrow_array){
			$did=$row[0];
		}
		
		my $update="update doctor set availability=1 where doc_id=".$did;
		my $sth41=$dbh->prepare($update);
		$sth41->execute();
		$sth41->finish();
	
	my $query1="SELECT * FROM bill where p_id=".$patid."";
	my $sth1=$dbh->prepare($query1) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth1->execute() or die "Can't execute SQL statement:",$sth1->errstr(),"\n";
	my @row2;
	my $billid;
	my $pid;
	my $date;
	my $confee;
	my $roomfee;
	my $rommfee;
	while(@row2=$sth1->fetchrow_array){
		$billid = $row2[0];
		$date = $row2[2];
		$confee = $row2[3];
	}
	my $msg1=$mw->Label(-text=>"Bill ID:".$billid,-justify=>'left')->pack();
	my $msg2=$mw->Label(-text=>"Patient Name:".$name)->pack();
	my $msg3=$mw->Label(-text=>"Date:".$date)->pack();
	my $msg4=$mw->Label(-text=>"Consultancy Fee:".$confee)->pack();
	my $msg5=$mw->Label(-text=>"Total Fee:".$confee)->pack();

}