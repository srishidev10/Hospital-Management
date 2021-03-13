use Tk;
use DBI;
my $mw=new MainWindow;
my $c = $mw->Canvas(-width=>500,-height=>70);
$c->pack();
my $but = $mw->Button(-text=>"Patient",-command=>\&push_button2);
$but -> pack();


MainLoop;


sub push_button2{
	$mw->destroy;
	system("psearch.pl");
}


