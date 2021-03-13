use Tk;
use DBI;
use DateTime;
use Date::Parse;
$date=	DateTime->now;
my $dbh = DBI->connect("dbi:mysql:database=datetdemo;host=localhost","root", "");
	
	print $date;
	my $que = "Select * from date_table";
	my $sth=$dbh->prepare($que);
	$sth->execute() or die $DBI::errstr;
	my @row;
	my $i=0;
	my $d;
	while(@row=$sth->fetchrow_array){
		$i=$i+1;
		if($i==2){
		$did = $row[0];
		$d=str2time($date)-str2time($did);
		$diff=($d/(24*60*60));
		print "Differerence:".$diff;
	}
}