 use strict; 
 use warnings;
 use PDF::Create;

    my $pdf = PDF::Create->new(
        'filename'     => 'sample.pdf',
        'Author'       => 'John Doe',
        'Title'        => 'Sample PDF',
        'CreationDate' => [ localtime ]
    );

    # Add a A4 sized page
    my $root = $pdf->new_page('MediaBox' => $pdf->get_page_size('A4'));

    # Add a page which inherits its attributes from $root
    my $page1 = $root->new_page;

    # Prepare a font
    my $font = $pdf->font('BaseFont' => 'Helvetica');

    # Prepare a Table of Content
    my $toc = $pdf->new_outline('Title' => 'Title Page', 'Destination' => $page1);

    # Write some text
    $page1->stringc($font, 40, 306, 426, 'PDF::Create');
    $page1->stringc($font, 20, 306, 396, "version $PDF::Create::VERSION");
    $page1->stringc($font, 20, 306, 300, 'by John Doe <john.doe@example.com>');

    # Add another page
    my $page2 = $root->new_page;

    # Draw some lines
    $page2->line(0, 0,   592, 840);
    $page2->line(0, 840, 592, 0);

    $toc->new_outline('Title' => 'Second Page', 'Destination' => $page2);

    # Close the file and write the PDF
    $pdf->close;
	
	system("bill13.pdf");