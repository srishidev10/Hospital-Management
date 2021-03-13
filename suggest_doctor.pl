use Tk;
use DBI;
use strict;
use warnings;
require Tk::BrowseEntry;

my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();

#my $idd=$ENV{id};
#$ENV{idd} = $iddd;



my $user =$mw->Label(-text=>"Choose the Patient's Problem:",-justify=>'center')->pack(-side=>'top');
my $bee=$mw->BrowseEntry->pack;
my $l=$bee->Subwidget('slistbox')->Subwidget('scrolled');
my @content=("");
my $g = 1;
my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
#tie @content ,'Tk::Listbox',$l;
my $query2="SELECT name FROM disease";
my $sth2=$dbh->prepare($query2) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
$sth2->execute() or die "Can'r execute SQL statement:",$sth2->errstr(),"\n";
my @row;
while(@row=$sth2->fetchrow_array){
		@content[$g] = $row[0];
		$g=$g+1;
	}
	my $b=0;
$l->insert('end',@content);
	  
my $but1 = $mw->Button(-text=>"Submit",-command=>\&push_button);
$but1 -> pack();
my $doc =$mw->Label(-text=>"Choose the Doctor:",-justify=>'center')->pack(-side=>'top');
my $beel=$mw->BrowseEntry->pack;
my $d=$beel->Subwidget('slistbox')->Subwidget('scrolled');
my $msg=$mw->Label()->pack();
my $msg2=$mw->Label()->pack();
my $msg3=$mw->Label()->pack();
my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();



MainLoop();

sub push_button{
  my @select=$l->curselection();
  my $diname= $l->get(@select);
  my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
  my $query="SELECT specialization FROM disease where name='".$diname."'";
	my $sth=$dbh->prepare($query) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth->execute() or die "Can'r execute SQL statement:",$sth->errstr(),"\n";
        my @row1;
	my $special;
	my $i=1;
	while(@row1=$sth->fetchrow_array){
		$special = $row1[0];
	}
  
  #
      my $q;
      	my $k=1;
      	my @doctors=(" "," ");
        my $query1="SELECT name FROM doctor where specialization='".$special."' and availability=1";
	my $sth1=$dbh->prepare($query1) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth1->execute() or die "Can'r execute SQL statement:",$sth1->errstr(),"\n";
	#$rows=$sth->dump_results();
	#print $rows;
	my @row;
	while(@row=$sth1->fetchrow_array){
		@doctors[$k] = $row[0];
		$k=$k+1;
	}
	my $a=0;
	for(my $a=1;$a<$k;$a=$a+1){
		print $doctors[$a];
	}

$d->insert('end',@doctors);

my $but2 = $mw->Button(-text=>"Proceed",-command=>\&push_button1);
$but2 -> pack();
}
sub push_button1{
	my @row3;
	my @select1=$d->curselection();
	my $did;
	my $d_nam =$d->get(@select1);
	my $lab=$mw->Label(-text=>"Selected Doctor : ".$d_nam,-justify=>'center')->pack(-side=>'top');
	my $query2 = "update doctor set availability=0 where name='".$d_nam."'";
	my $sth2=$dbh->prepare($query2) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth2->execute() or die "Can'r execute SQL statement:",$sth2->errstr(),"\n";
	my $query3 = "select doc_id from doctor where name='".$d_nam."'";
	my $sth3=$dbh->prepare($query3) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth3->execute() or die "Can't execute SQL statement:",$sth3->errstr(),"\n";
	while(@row3=$sth3->fetchrow_array){
		$did = $row3[0];
	}
	print $did;
	$ENV{did}=$did;
	$mw->destroy;
	system("room.pl");
}