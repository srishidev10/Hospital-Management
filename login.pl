use Tk;
use DBI;
my $username;
my $password;
my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
my $query="SELECT * FROM LOGIN";
	my $sth=$dbh->prepare($query) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
	$sth->execute() or die "Can't execute SQL statement:",$sth->errstr(),"\n";
	#$rows=$sth->dump_results();
	#print $rows;
	my @row;
	my $variable1;
	my $variable2;
	while(@row=$sth->fetchrow_array){
		$variable1 = $row[0];
		$variable2 = $row[1];
		
		#print  join(",",@row),"\n";
		#$username=@ary[0];
		#$password=@ary[1];
	}
	print "From DB:\n";
	print "Username:",$variable1,"\n";;
	print "Password:",$variable2,"\n";
	
my $mw=MainWindow->new(-title=>"HOSPITAL MANAGEMENT SYSTEM");
my $c = $mw->Canvas(-width=>500,-height=>70,);
$c->pack;
#my $frmTop = $mw->Frame(-bd=>2)->pack(-side=>'top',-fill =>'x',-pady=>3);
#my $frmLocations = $frmTop->Frame(-bd=>2)->pack(-side=>'top',-fill =>'y');
#my $lblLocationsID = $frmLocations->Label(-text=>"Locations")->pack(-side=>'left');
my $user =$mw->Label(-text=>"User Name:",-justify=>'center')->pack(-side=>'top');
my $entry = $mw->Entry()->pack();
my $pass =$mw->Label(-text=>"Password:",-justify=>'center')->pack(-side=>'top');
my $ent = $mw->Entry(-show=>'*')->pack();
my $but = $mw->Button(-text=>"Login",-justify=>'center',-command=>\&push_button);
$but -> pack(-side=>'top');
my $msg=$mw->Label()->pack();
my $msg2=$mw->Label()->pack();
my $msg3=$mw->Label()->pack();
my $msg4=$mw->Label()->pack();
my $msg5=$mw->Label()->pack();
MainLoop;
sub push_button{
	$pass=$ent->get();
	$user=$entry->get();
	print "You entered Username: $user\n";
	print "You entered Password: $pass\n";
	if($pass eq $variable2){
		if($user eq $variable1){
			my $string=$user." Logged in!";
			my $msg=$mw->Label(-text=>$string)->pack();
			$response=$mw->messageBox(-message=>"Login Successful!",-title=>"Authentication");
			$mw->destroy;
			system("menu.pl");
			
			
			
		}
		else{
			$response=$mw->messageBox(-message=>"Login UnSuccessful!",-title=>"Authentication");
		}
	}
	else{
		$response=$mw->messageBox(-message=>"Login UnSuccessful!",-title=>"Authentication");
	}
	exit;
	#system("menu.pl");
}
