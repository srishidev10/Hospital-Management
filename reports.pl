use Tk;
my $mw=new MainWindow;


my $but2 = $mw->Button(-text=>"Patient Report",-command=>\&push_button2);

$but2->pack();
my $but1 = $mw->Button(-text=>"Doctor Report",-command=>\&push_button1);
$but1->pack();

MainLoop;

sub push_button1{
	system("pdf1.pl")
}

sub push_button2{
	system("pdf2.pl");
}