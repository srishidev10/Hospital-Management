use strict;
use warnings;
use PDF::Create;
use DBI;

my $billid=$ENV{bill};
my $total=$ENV{total};
my $date=localtime;
    my $pdf = PDF::Create->new(
        'filename'     => 'bill90.pdf',
        'Author'       => 'Madhu,Beulah',
        'Title'        => 'BILL',
        'CreationDate' => [ localtime ]
    );
 my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
#tie @content ,'Tk::Listbox',$l;
my $query2="SELECT * FROM bill where bill_id=".$billid;
my $sth2=$dbh->prepare($query2) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
$sth2->execute() or die "Can'r execute SQL statement:",$sth2->errstr(),"\n";
my @row;
my $g = 1;
my @id=("","");
my @name=("","");
my @gname=("","");
my @age=("","");
my @gender=("","");
my @fee=("","");
while(@row=$sth2->fetchrow_array){
		@id[$g] = $row[0];
		@name[$g] = $row[1];
		@gname[$g]= $row[2];
		@age[$g]=$row[3];
		@gender[$g]=$row[4];
		@fee[$g]=$row[5];
		$g=$g+1;
}
	print "Name".$name[1]."...";
    # Add a A4 sized page
    
    my $root = $pdf->new_page('MediaBox' => $pdf->get_page_size('A4'));
    my $page1 = $root->new_page;
    my $font = $pdf->font('BaseFont' => 'Helvetica');

    my $toc = $pdf->new_outline('Title' => 'Title Page', 'Destination' => $page1);
	$page1->stringc($font, 30, 500, 900, "Date:".$date);
    $page1->stringc($font, 30, 200, 700, "BILL INFORMATION");
    $page1->stringc($font, 10, 100, 650, "BILL ID:");
    $page1->stringc($font, 10, 100, 600, "PATIENT ID:");
    $page1->stringc($font, 10, 100, 550, "CONSULTANCY FEE:");
    $page1->stringc($font, 10, 100, 500, "ROOM FEE:");
	$page1->stringc($font, 10, 100, 450, "ROOM-MAINTANANCE FEE:");
	$page1->stringc($font, 10, 100, 400, "TOTAL FEE:");
    my $i=1;
    my $x = 0;
    while($i<$g){
        $page1->stringc($font, 10, 400-$x, 650, "$id[$i]");
        $page1->stringc($font, 10, 400-$x, 600, "$name[$i]");
        $page1->stringc($font, 10, 400-$x, 550, "$age[$i]");
        $page1->stringc($font, 10, 400-$x, 500, "$gender[$i]");
		$page1->stringc($font, 10, 400-$x, 450, "$fee[$i]");	
		$page1->stringc($font, 10, 400-$x, 400, "$total");	

		 
		 
        $i = $i+1;
        $x = $x +50;
    }
    $pdf->close;
    system("bill90.pdf");