use Tk;
use DBI;

my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();

my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();
                              
my $pname =$mw->Label(-text=>"Patient Name:")->pack();
my $ent1 = $mw->Entry()->pack();
my $pgname =$mw->Label(-text=>"Patient Guardian Name:")->pack();
my $ent2 = $mw->Entry()->pack();
my $pag =$mw->Label(-text=>"Patient Age:")->pack();
my $ent3 = $mw->Entry()->pack();
my $pgender =$mw->Label(-text=>"Patient Gender:")->pack();
my $ent4 = $mw->Entry()->pack();

my $msg5=$mw->Label()->pack();


my $but = $mw->Button(-text=>"Register",-command=>\&push_button);
$but -> pack();
my $msg=$mw->Label()->pack();
my $msg2=$mw->Label()->pack();
my $msg3=$mw->Label()->pack();
my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();
               

MainLoop;

sub push_button{
	my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
	$pat1=$ent1->get();
	$pat2=$ent2->get();
	$pat3=$ent3->get();
	$pat4=$ent4->get();
	
	my $sth=$ dbh->prepare("INSERT INTO out_patient(name,guardian,age,gender)values(?,?,?,?)");
	$sth->execute($pat1,$pat2,$pat3,$pat4) or die $ DBI::errstr;
	$ sth->finish();
	
	
	my $query1="SELECT p_id FROM out_patient where name='".$pat1."'";
	my $sth1=$dbh->prepare($query1) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth1->execute() or die "Can'r execute SQL statement:",$sth1->errstr(),"\n";
	#$rows=$sth->dump_results();
	#print $rows;
	my @row;
	while(@row=$sth1->fetchrow_array){
		$id = $row[0];
	}
	#$ dbh->commit or die $ DBI::errstr;
	$ENV{id}=$id;
	$mw->destroy;
	system("suggest_doctor1.pl");
	
}
