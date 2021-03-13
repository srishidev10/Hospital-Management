use strict;
use warnings;
use PDF::Create;
use DBI;

    my $pdf = PDF::Create->new(
        'filename'     => 'bill81.pdf',
        'Author'       => 'Madhu,Beulah',
        'Title'        => 'BILL',
        'CreationDate' => [ localtime ]
    );
 my $dbh = DBI->connect("dbi:mysql:database=hospital_management;host=localhost","root", "");
#tie @content ,'Tk::Listbox',$l;
my $query2="SELECT * FROM doctor";
my $sth2=$dbh->prepare($query2) or die "Can't prepare SQL statement:",$dbh->errstr(),"\n";
$sth2->execute() or die "Can'r execute SQL statement:",$sth2->errstr(),"\n";
my @row;
my $g = 1;
my @id=("","");
my @name=("","");
my @gname=("","");
my @age=("","");
my @gender=("","");
while(@row=$sth2->fetchrow_array){
		@id[$g] = $row[0];
		@name[$g] = $row[1];
		@gname[$g]= $row[2];
		@age[$g]=$row[3];
		@gender[$g]=$row[4];
		$g=$g+1;
	}
	print "Name".$name[1]."...";
    # Add a A4 sized page
    
    my $root = $pdf->new_page('MediaBox' => $pdf->get_page_size('A4'));
    my $page1 = $root->new_page;
    my $font = $pdf->font('BaseFont' => 'Helvetica');

    my $toc = $pdf->new_outline('Title' => 'Title Page', 'Destination' => $page1);
    $page1->stringc($font, 30, 200, 700, "DOCTOR INFORMATION");
    $page1->stringc($font, 20, 50, 650, "DID");
    $page1->stringc($font, 20, 150, 650, "NAME");
    $page1->stringc($font, 20, 250, 650, "AGE");
    $page1->stringc($font, 20, 350, 650, "GENDER");
    $page1->stringc($font, 20, 450, 650, "SPECIAL");
    my $i=1;
    my $x = 0;
    while($i<$g){
        $page1->stringc($font, 20, 50, 600-$x, "$id[$i]");
        $page1->stringc($font, 20, 150, 600-$x, "$name[$i]");
        $page1->stringc($font, 20, 250, 600-$x, "$gname[$i]");
        $page1->stringc($font, 20, 350, 600-$x, "$age[$i]");
        $page1->stringc($font, 20, 450, 600-$x, "$gender[$i]");
        $i = $i+1;
        $x = $x +50;
    }
    $pdf->close;
    system("bill81.pdf");