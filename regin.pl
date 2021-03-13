use Tk;
my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();
my $but = $mw->Button(-text=>"Existing Patient",-command=>\&push_button2);
$but -> pack();
my $msg=$mw->Label()->pack();
my $msg2=$mw->Label()->pack();
my $msg3=$mw->Label()->pack();
my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();
my $but1 = $mw->Button(-text=>"New Patient",-command=>\&push_button1);
$but1 -> pack();

MainLoop;
sub push_button1{
	$mw->destroy;
	system("newin.pl");
}

sub push_button2{
	$mw->destroy;
	system("existing1.pl");
}