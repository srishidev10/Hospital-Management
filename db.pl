use Tk;
use DBI;
my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
my $query="SELECT * FROM LOGIN";
	my $sth=$dbh->prepare($query) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth->execute() or die "Can't execute SQL statement:",$sth->errstr(),"\n";