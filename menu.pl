use Tk;
my $mw=new MainWindow;
#my $mw=MainWindow->new(-title=>"HOSPITAL MANAGEMENT SYSTEM",-background=>"green");
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();
my $but = $mw->Button(-text=>"Patient Registration",-command=>\&push_button);
$but -> pack();
my $msg=$mw->Label()->pack();
my $msg2=$mw->Label()->pack();
my $msg3=$mw->Label()->pack();
my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();
my $but1 = $mw->Button(-text=>"Search Patient",-command=>\&push_button1);
$but1 -> pack();
my $msgg=$mw->Label()->pack();
my $msgg2=$mw->Label()->pack();
my $msgg3=$mw->Label()->pack();
my $msgg4=$mw->Label()->pack();
my $msgg5=$mw->Label()->pack();
my $but2 = $mw->Button(-text=>"Bill Generation",-command=>\&push_button2);
$but2 -> pack();

my $msggg1=$mw->Label()->pack();
my $msggg2=$mw->Label()->pack();
my $msggg3=$mw->Label()->pack();
my $msggg4=$mw->Label()->pack();
my $msggg5=$mw->Label()->pack();
my $but3 = $mw->Button(-text=>"Reports",-command=>\&push_button3);
$but3->pack();

MainLoop;

sub push_button3{
	#$mw->destroy;
	system("reports.pl");
}
sub push_button{
	$mw->destroy;
	system("inoutopt.pl");
}
sub push_button1{
	$mw->destroy;
	system("search.pl");
}
sub push_button2{
	$mw->destroy;
	system("billing.pl");
}