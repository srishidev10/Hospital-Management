use Tk;
my $mw=new MainWindow;
my $but = $mw->Button(-text=>"In Patient",-command=>\&push_button2);
$but -> pack();
my $msg=$mw->Label()->pack();
my $msg2=$mw->Label()->pack();
my $msg3=$mw->Label()->pack();
my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();
my $but1 = $mw->Button(-text=>"Out Patient",-command=>\&push_button1);
$but1 -> pack();
MainLoop;
sub push_button2{
	$mw->destroy;
	system("regin.pl");
}

sub push_button1{
	$mw->destroy;
	system("register.pl");
}
