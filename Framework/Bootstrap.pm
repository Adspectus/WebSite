package WebSite::Framework::Bootstrap;

use constant { TRUE => 1, FALSE => 0 };
use strict;
use warnings;
use Module::Find;

usesub WebSite::Framework::Bootstrap;


#******************************************************************************
# Constructor
#******************************************************************************

sub new {
  my ($class,$args) = (@_);
  my $self = {
  };
  my $object = bless $self,$class;
  return $object;
}


#******************************************************************************
# Public methods
#******************************************************************************

sub set {
  my ($self,$key,$value) = (@_);
  $self->{$key} = $value;
}

sub get {
  my ($self,$key) = (@_);
  return $self->{$key};
}

sub dump {
  my ($self) = (@_);
  return Data::Dumper->Dump([$self],[ref($self)]);
}


#******************************************************************************
# Private methods
#******************************************************************************


1;

