package Accordion;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:standard -any Button);

sub new {
  my ($class,$args) = (@_);
  my $self = {
    'Panels'  => $args || [],
  };
  my $object = bless $self,$class;
  return $object;
}

sub append {
  my ($self,$object) = (@_);
  push(@{$self->get('Panels')},$object);
}

sub prepend {
  my ($self,$object) = (@_);
  unshift(@{$self->get('Panels')},$object);
}

sub sort {
  my ($self) = (@_);
  my $Panels = [ sort { $a->getHead() cmp $b->getHead() } @{$self->get('Panels')} ];
  $self->set('Panels',$Panels);
}

sub output {
  my ($self) = (@_);
  return div({-id => 'accordion',-class => 'panel-group'},join("",map { $_->output() } @{$self->get('Panels')}));
}

1;

