package Perceptron; 

use strict; 
use warnings; 
use PDL;

sub new { 
     my ($class, $size) = @_; 
     my @weight = (); 
     $size += 1; 
     my $weight = zeros($size);
     my $self = { 
         weight => $weight, 
         size   => $size, 
     }; 
     bless $self, $class; 
     return $self; 
} 

sub train { 
     my ($self, $traindata, $niter) = @_; 
     for (my $i = 0; $i < $niter; $i++) { 
         foreach my $data (@{ $traindata }) { 
             $self->_train($data->{data}, $data->{pn}); 
         } 
     } 
 } 


sub _train { 
    my ($self, $input, $pn) = @_; 
    my $data = pdl(1)->append($input);
    my $prod = _product($self->{weight}, $data); 
    if (_sign($prod) != $pn) { 
        if ($pn == -1) { 
            $data *= -1;
        }
        $self->_update_weight($data); 
    } 
}


sub predict { 
    my ($self, $input) = @_; 
    my $data = pdl(1)->append($input);
    my $prod = _product($self->{weight}, $data); 
    return $prod > 0 ? 1 : 0; 
}

sub _update_weight { 
     my ($self, $data) = @_; 
     my $size = nelem($data); 
     $size = $self->{size} if $size > $self->{size};
     $self->{weight} += $data;
} 

sub _product { 
     my ($vec1, $vec2) = @_; 
     die 'illegal input vector' if  nelem($vec1) != nelem($vec2); 
     return ($vec1 * $vec2)->sum;
}


sub _sign { 
     my $x = shift; 
     if ($x > 0) { 
         return 1; 
     } 
     elsif ($x == 0) { 
         return 0; 
     } 
     else { 
         return -1; 
     } 
}


1; 

