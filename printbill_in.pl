use Tk;
use DBI;
use Date::Parse;
use DateTime;

my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();
my $user =$mw->Label(-text=>"Enter Patient Name:",-justify=>'center')->pack(-side=>'top');
my $entry = $mw->Entry()->pack();

my $msg=$mw->Label()->pack();
my $msg2=$mw->Label()->pack();
my $msg3=$mw->Label()->pack();
my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();
my $but1 = $mw->Button(-text=>"Generate Bill",-command=>\&push_button);
$but1 -> pack();
                                
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
		my $queryy="SELECT room_no from record where p_id=".$patid;
		my $sth8=$dbh->prepare($queryy);
		$sth8->execute();
		my @row8;
		my $rno;
		while(@row8=$sth8->fetchrow_array){
			$rno=$row8[0];
		}
		print "Room".$rno;
		
		my $updatee="update room set status=1 where room_no=".$rno;
		my $sth43=$dbh->do($updatee);
		#$sth43->execute();
		#$sth43->finish();
		
		my $queryy1="SELECT rtype from room where room_no=".$rno;
		my $sth9=$dbh->prepare($queryy1);
		$sth9->execute();
		my @row9;
		while(@row9=$sth9->fetchrow_array){
			$room_type=$row9[0];
		}
		
		#$room_type=$ENV{rtype};
		print "ROOM TYPE:".$room_type;
		my $query1="SELECT a_date FROM record where p_id=".$patid;
		my $sth1=$dbh->prepare($query1) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
		$sth1->execute() or die "Can'r execute SQL statement:",$sth1->errstr(),"\n";
		my @row2;
		my $adate;
		while(@row2=$sth1->fetchrow_array){
			$adate = $row2[0];
		}
		#print "adate".$adate;
		use POSIX qw(strftime);
		my $ddate=DateTime->now;		
		print "Time".$ddate;
		my $query2="SELECT fare FROM room_fare where type='".$room_type."'";
		

		my $diff  = str2time($ddate)- str2time($adate);
		my $days = int($diff/(24*60*60));
	
		print "Days:".$days."!!";
		my $updatee1="update record set d_date='".$ddate."' where p_id=".$patid;
		my $sth44=$dbh->prepare($updatee1);
		$sth44->execute();
		#$sth44->finish();
		
		my $query3="SELECT m_fare FROM room_fare where type='".$room_type."'";
		my $sth3=$dbh->prepare($query3) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
		$sth3->execute() or die "Can't execute SQL statement:",$sth3->errstr(),"\n";
		my @row4;
		my $farem;
		while(@row4=$sth3->fetchrow_array){
			$farem = $row4[0];
		}
		my $totf = $fare*$days;
		my $totfm = $farem*$days;
		print "Total Fare".$totf;
		print "Total Maintenance Fare".$totfm;
		
		
		my $update="update bill set r_fee=".$totf.",rm_fee=".$totfm." where p_id=".$patid;
		my $sth4=$dbh->prepare($update);
		$sth4->execute();
		#$sth4->finish();
	
	
	my $select="select d_id from record where p_id=".$patid;
		my $sthh=$dbh->prepare($select);
		$sthh->execute();
		my @roww;
		my $didd;
		while(@roww=$sthh->fetchrow_array){
			$didd=$roww[0];
		}
		print "Doc:".$didd;
		my $update1="update doctor set availability=1 where doc_id=".$didd;
		my $sth41=$dbh->prepare($update1);
		$sth41->execute();
		#$sth41->finish();
	
	my $query10="SELECT * FROM bill where p_id=".$patid;
	my $sth10=$dbh->prepare($query10) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth10->execute() or die "Can't execute SQL statement:",$sth10->errstr(),"\n";
	my @row10;
	my $billid;
	my $pid;
	my $date;
	my $confee;
	my $roomfee;
	my $rommfee;
	while(@row10=$sth10->fetchrow_array){
		$billid = $row10[0];
		$date = $row10[2];
		$confee = $row10[3];
		$roomfee = $row10[4];
		$rommfee = $row10[5];
	}
	my $tot=$confee+$roomfee+$rommfee;
	my $msg1=$mw->Label(-text=>"Bill ID:".$billid,-justify=>'left')->pack();
	my $msg2=$mw->Label(-text=>"Patient Name:".$name)->pack();
	my $msg3=$mw->Label(-text=>"Date:".$date)->pack();
	my $msg4=$mw->Label(-text=>"Consultancy Fee:".$confee)->pack();
	my $msg5=$mw->Label(-text=>"Room Fee:".$roomfee)->pack();
	my $msg6=$mw->Label(-text=>"Maintainence Fee:".$rommfee,-justify=>'left')->pack();
	my $msg6=$mw->Label(-text=>"Total Fee:".$tot,-justify=>'left')->pack();
	
	$ENV{total}=$tot;
	$ENV{bill}=$billid;
	my $but2 = $mw->Button(-text=>"Get PDF",-command=>\&push_button1);
$but2 -> pack();

}

sub push_button1{
	system("billpdf.pl");
}
	#print $patid.",".$patname.",".$patguard.",".$patage.",".$patgender;
