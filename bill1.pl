use Tk;
use DBI;
use strict;
use warnings;

use Date::Parse;
use DateTime;

use 5.010;
my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();

my $i_d = $ENV{iddd};
my $ptype=$ENV{pat_type};

my $bid;
print "Selected Type : $ptype";
my $cfee =$mw->Label(-text=>"Enter consultancy Fee:",-justify=>'center',-background=>"green")->pack(-side=>'top');
my $entry = $mw->Entry()->pack();
my $but = $mw->Button(-text=>"Proceed",-justify=>'center',-command=>\&push_button1);
$but -> pack(-side=>'top');
my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
print $ptype;
	my $rm=$ENV{room};
	print "Room No:".$rm;
	#print $r_num."\n";
	my $pat=$ENV{id};
	my $doc=$ENV{did};
	print "\nPatient Id:".$pat;
	print "\nDoctor Id:".$doc;
	
	
	
	my $date=DateTime->now;
	print $date;
my $msg=$mw->Label()->pack();
my $msg2=$mw->Label()->pack();
my $msg3=$mw->Label()->pack();
my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();
	
MainLoop;

sub push_button1{
	if($ptype eq "in"){
		#get room type from room.pl"
		
		#my $lroom = mw->label(-text=>"Room Fare :". $totf);
		my $rm=$ENV{room};
		
		my $sth2=$ dbh->prepare("INSERT INTO bill(bill_id,p_id,date,c_fee)values(?,?,?,?)");
		$sth2->execute(' ',$pat,$date,$entry->get()) or die $ DBI::errstr;
		$sth2->finish();
	}
	if($ptype eq "out"){
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