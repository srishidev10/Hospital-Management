use Tk;
use DBI;
use strict;
use warnings;
use 5.010;
my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();
my $ptype;
my $i_d = $ENV{iddd};


my $bid;
print "Selected Type : $ptype";
my $cfee =$mw->Label(-text=>"Enter consultancy Fee:",-justify=>'center',-background=>"green")->pack(-side=>'top');
my $entry = $mw->Entry()->pack();
my $but = $mw->Button(-text=>"Proceed",-justify=>'center',-command=>\&push_button1);
$but -> pack(-side=>'top');
my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
print $ptype;
	my $rm=$ENV{room};
	#print $r_num."\n";
	my $pat=$ENV{id};
	my $doc=$ENV{did};
	print "\nPatient Id:".$pat;
	print "\nDoctor Id:".$doc;
	
	my $date=localtime;
	
	
MainLoop;

sub push_button1{
	if($ptype eq "In-patient"){
		#get room type from room.pl"
		my $type = "AC";
		my $adate = "2016-11-16 12:50:22";
		my $ddate  = "2016-11-17 12:53:22";
		my $query="SELECT fare FROM room_fare where type='".$type."'";
		#my $diff  = str2time($ddate) - str2time($adate);
		#my $days = int($diff/(24*60*60));
		my $days = 5;
		my $sth=$dbh->prepare($query) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
		$sth->execute() or die "Can'r execute SQL statement:",$sth->errstr(),"\n";
		my @row;
		my $fare;
		while(@row=$sth->fetchrow_array){
			$fare = $row[0];
		}
		my $query1="SELECT m_fare FROM room_fare where type='".$type."'";
		my $sth1=$dbh->prepare($query1) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
		$sth1->execute() or die "Can'r execute SQL statement:",$sth1->errstr(),"\n";
		my @row1;
		my $farem;
		while(@row1=$sth1->fetchrow_array){
			$farem = $row1[0];
		}
		my $totf = $fare*$days;
		my $totfm = $farem*$days;
		print $totf;
		print $totfm;
		#my $lroom = mw->label(-text=>"Room Fare :". $totf);
		my $sth2=$ dbh->prepare("INSERT INTO bill(bill_id,p_id,date,c_fee,r_fee,rm_fee)values(?,?,?,?,?,?)");
		$sth2->execute(' ',$pat,$date,$entry->get(),$totf,$totfm) or die $ DBI::errstr;
		$sth2->finish();
	}
	if($ptype eq "Out-patient"){
		print "Out patient";
		my $sth4=$ dbh->prepare("INSERT INTO bill(bill_id,p_id,date,c_fee)values(?,?,?,?)");
		$sth4->execute(' ',$pat,$date,$entry->get()) or die $ DBI::errstr;
		$sth4->finish();
	}
	my $query5 = "Select bill_id from bill where p_id=".$pat;
	my $sth5=$dbh->prepare($query5) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth5->execute() or die "Can'r execute SQL statement:",$sth5->errstr(),"\n";
	my @row5;
	while(@row5=$sth5->fetchrow_array){
			$bid = $row5[0];
	}
	print $bid;
	my $sth6=$ dbh->prepare("INSERT INTO record(p_id,d_id,a_date,room_no,bill_id)values(?,?,?,?,?)");
	$sth6->execute($pat,$doc,$date,$rm,$bid) or die $ DBI::errstr;
	$sth6->finish();
	my $but3 = $mw->Button(-text=>"Go to Menu",-justify=>'center',-command=>\&push_button2);
	$but3 -> pack(-side=>'top');
}
sub push_button2{
	$mw->destroy;
	system("menu.pl");
}