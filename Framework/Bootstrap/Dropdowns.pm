package Dropdown;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:standard -any Button);

sub new {
  my ($class,$args) = (@_);
  my $self = {
    'ID'        => $args->{'ID'},
    'Title'     => $args->{'Title'} || 'Dropdown',
    'Elements'  => $args->{'Elements'} || [],
  };
  my $object = bless $self,$class;
  return $object;
}

sub setID {
  my ($self,$id) = (@_);
  $self->set('ID',$id);
}

sub getID {
  my ($self) = (@_);
  $self->get('ID');
}

sub setTitle {
  my ($self,$title) = (@_);
  $self->set('Title',$title);
}

sub getTitle {
  my ($self) = (@_);
  $self->get('Title');
}

sub setElements {
  my ($self,$aryref) = (@_);
  $self->set('Elements',$aryref);
}

sub appendElement {
  my ($self,$object) = (@_);
  push(@{$self->get('Elements')},$object);
}

sub prependElement {
  my ($self,$object) = (@_);
  unshift(@{$self->get('Elements')},$object);
}

sub sortElements {
  my ($self) = (@_);
  my $Elements = [ sort { $a->get('Order') <=> $b->get('Order') } @{$self->get('Elements')} ];
  $self->set('Elements',$Elements);
}

sub getVisibleElements {
  my ($self) = (@_);
  $self->sortElements();
  my $Elements = [ grep { $_->isVisible() } @{$self->get('Elements')} ];
  return $Elements;
}

sub toNavBar {
  my ($self) = (@_);
  return ('ID' => $self->getID(),'Title' => $self->getTitle(),'Dropdown' => $self->output('Title'),'Elements' => $self->getVisibleElements());
}

sub output {
  my ($self,$key) = (@_);
  my @Elements = @{$self->getVisibleElements()};
  return div({-class => 'tab-content'},join("",map { $_->output('Pane') } @Elements)) if ($key eq 'Pane');
  return ul({-class => 'dropdown-menu'},join("",map { $_->output('Title') } @Elements)) if ($key eq 'Title');
}


package Dropdown::Element;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:standard -any Button);

sub new {
  my ($class,$args) = (@_);
  my $self = {
    'ID'         =>  $args->{'ID'},
    'Order'      =>  $args->{'Order'}    || 0,
    'Title'      =>  $args->{'Title'}    || '',
    'Pane'       =>  $args->{'Pane'}     || '',
    'Show'       =>  (exists($args->{'Show'}) ? $args->{'Show'} : TRUE),
    'Active'     =>  exists($args->{'Active'}) ? $args->{'Active'} : FALSE,
  };
  my $object = bless $self,$class;
  return $object;
}

sub getID {
  my ($self) = (@_);
  return $self->get('ID');
}

sub setTitle {
  my ($self,$value) = (@_);
  $self->set('Title',$value);
}

sub getTitle {
  my ($self) = (@_);
  return $self->get('Title');
}

sub setPane {
  my ($self,$value) = (@_);
  $self->set('Pane',$value);
}

sub getPane {
  my ($self) = (@_);
  return $self->get('Pane');
}

sub appendTitle {
  my ($self,$value) = (@_);
  $self->set('Title',$self->get('Title') . $value);
}

sub prependTitle {
  my ($self,$value) = (@_);
  $self->set('Title',$value . $self->get('Title'));
}

sub appendPane {
  my ($self,$value) = (@_);
  $self->set('Pane',$self->get('Pane') . $value);
}

sub prependPane {
  my ($self,$value) = (@_);
  $self->set('Pane',$value . $self->get('Pane'));
}

sub isActive  {
  my ($self) = (@_);
  $self->get('Active');
}

sub activate {
  my ($self) = (@_);
  $self->set('Active',TRUE);
}

sub deactivate {
  my ($self) = (@_);
  $self->set('Active',FALSE);
}

sub isVisible {
  my ($self) = (@_);
  return $self->get('Show');
}

sub show {
  my ($self) = (@_);
  $self->set('Show',TRUE);
}

sub hide {
  my ($self) = (@_);
  $self->set('Show',FALSE);
}

sub raiseOrder {
  my ($self) = (@_);
  $self->set('Order',$self->get('Order') + 1);
}

sub lowerOrder {
  my ($self) = (@_);
  $self->set('Order',$self->get('Order') - 1);
}

sub output {
  my ($self,$key) = (@_);
  if ($key eq 'Title') {
    return li({-class => '' . ($self->isActive() ? ' active' : '')},a({-data_toggle => 'tab',-href => '#'.$self->getID()},$self->getTitle())) if ($self->getTitle());
    return li({-class => 'divider'},'') unless ($self->getTitle());
  }
  return div({-id => $self->getID(),-class => 'tab-pane' . ($self->isActive() ? ' active' : '')},$self->getPane()) if ($key eq 'Pane');
}

1;
