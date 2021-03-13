use Tk;
my $mw=new MainWindow;
my $pname =$mw->Label(-text=>"Patient Name:")->pack();
my $ent = $mw->Entry()->pack();
my $pgname =$mw->Label(-text=>"Patient Guardian Name:")->pack();
my $ent = $mw->Entry()->pack();
my $pag =$mw->Label(-text=>"Patient Age:")->pack();
my $ent = $mw->Entry()->pack();
my $pgender =$mw->Label(-text=>"Patient Gender:")->pack();
my $ent = $mw->Entry()->pack();

my $msg=$mw->Label()->pack();
my $msg2=$mw->Label()->pack();
my $msg3=$mw->Label()->pack();
my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();

my $but = $mw->Button(-text=>"Register",-command=>\&push_button);
$but -> pack();



sub push_button{
	$mw->destroy;
	system("suggest_doctor.pl");
}
