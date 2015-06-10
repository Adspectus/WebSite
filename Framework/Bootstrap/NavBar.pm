package NavBar;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:standard);


sub new {
  my ($class,$args) = (@_);
  my $self = {
    'ID'         =>  $args->{'ID'},
    'Order'      =>  $args->{'Order'}    || 0,
    'Title'      =>  $args->{'Title'}    || '',
    'Pane'       =>  $args->{'Pane'}     || '',
#    'Type'       =>  $args->{'Type'}     || 'Link',
    'Dropdown'   =>  $args->{'Dropdown'} || '',
    'Elements'   =>  $args->{'Elements'} || [],
    'Show'       =>  exists($args->{'Show'}) ? $args->{'Show'} : TRUE,
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

sub isDropdown {
  my ($self) = (@_);
  return TRUE if ($self->{'Dropdown'});
  return FALSE;
}

sub getDropdown {
  my ($self) = (@_);
  return $self->get('Dropdown');
}

sub getElements {
  my ($self) = (@_);
  return $self->get('Elements');
}

sub output {
  my ($self,$key) = (@_);
  if ($key eq 'Title') {
    return li({-class => '' . ($self->isActive() ? ' active' : '')},a({-data_toggle => 'tab',-href => '#'.$self->getID()},$self->getTitle())) unless ($self->isDropdown());
    return li({-class => 'dropdown' . ($self->isActive() ? ' active' : '')},a({-class => 'dropdown-toggle',-data_toggle => 'dropdown',-href => '#'},$self->getTitle().span({-class => 'caret'},'')).$self->getDropdown()) if ($self->isDropdown());
  }
  if ($key eq 'Pane') {
    return div({-id => $self->getID(),-class => 'tab-pane' . ($self->isActive() ? ' active' : '')},$self->getPane()) unless ($self->isDropdown());
    return join("",map { div({-id => $_->getID(),-class => 'tab-pane' . ($_->isActive() ? ' active' : '')},$_->getPane()) } @{$self->getElements()} ) if ($self->isDropdown());
  }
}

1;

