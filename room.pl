use Tk;
use DBI;
use strict;
use warnings;
require Tk::BrowseEntry;
my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();
my $c = $mw->Canvas(-width=>500,-height=>70);

	my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");


# create the radiobuttons that will let us change it
my $type="";
foreach (qw(AC NonAC)) {
  $mw->Radiobutton(-text => $_,
                   -value => $_,
                   -variable => \$type)->pack();
}
my $lbl_type = $mw ->Label(-text=>"Select Room Type :");





my $rdb_ac = $mw-> Radiobutton(-text=>"AC",-value=>"AC",-variable=>\$type);
my $rdb_nac = $mw-> Radiobutton(-text=>"NonAC",-value=>"NonAC",-variable=>\$type);
print "Selected Room :".$type;
my $but = $mw->Button(-text=>"Proceed",-justify=>'center',-command=>\&push_button1);
	$but -> pack(-side=>'top');
	my $msg=$mw->Label()->pack();
my $msg2=$mw->Label()->pack();
my $msg3=$mw->Label()->pack();
my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();
my $rom =$mw->Label(-text=>"Choose the Room:",-justify=>'center')->pack(-side=>'top');
	my $bee=$mw->BrowseEntry->pack;
	my $r=$bee->Subwidget('slistbox')->Subwidget('scrolled');
	                                                         
MainLoop;
sub push_button1{
	my $query="SELECT room_no FROM room where rtype='".$type."' and status=1";
	my $sth=$dbh->prepare($query) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth->execute() or die "Can'r execute SQL statement:",$sth->errstr(),"\n";
        my @row;
        my @room=(" ");
        my $k =1;
        while(@row=$sth->fetchrow_array){
		@room[$k] = $row[0];
		$k=$k+1;
	}
	
	$r->insert('end',@room);
	my $but = $mw->Button(-text=>"Choose",-justify=>'center',-command=>\&push_button);
	$but -> pack(-side=>'top');
	#use Tk::Date;
	#$date_widget = $top->Date->pack;
	#$date_widget->get("%x %X");	
}	

sub push_button{
	my @select=$r->curselection();
	my $r_num =$r->get(@select);
	my $lab=$mw->Label(-text=>"Selected Room : ".$r_num,-justify=>'center')->pack(-side=>'top');
	my $query2 = "update room set status=0 where room_no='".$r_num."'";
	my $sth2=$dbh->prepare($query2) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth2->execute() or die "Can't execute SQL statement:",$sth2->errstr(),"\n";
	$ENV{room}=$r_num;
	$mw->destroy;
	system("bill1.pl");
}
