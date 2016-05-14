use strict;
use warnings;
use Data::Dumper;
use Perceptron;
use PDL;

my $size = 4;
my $p = Perceptron->new($size);

# training
my @traindata = (
    {
        data => pdl(1, 1, 0, 0),
        pn   => 1,
    },
    {
        data => pdl(2, 1, 0, 0),
        pn   => 1,
    },
    {
        data => pdl(0, 0, 1, 1),
        pn   => -1,
    },
    {
        data => pdl(0, 0, 1, 2),
        pn   => -1,
    },
);
$p->train(\@traindata, 100);
printf "%s\n", $p->{weight};

# predict
my @testdata = (
    pdl(2, 2, 0, 0),  # maybe 1
    pdl(1, 2, 0, 0),  # maybe 1
    pdl(0, 0, 2, 2),  # maybe 0
    pdl(0, 0, 2, 1),  # maybe 0
);
foreach my $data (@testdata) {
    my $result = $p->predict($data);
    print "$result\n";
}
