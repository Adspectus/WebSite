package NavBars;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:standard);

sub new {
  my ($class,$args) = (@_);
  my $self = {
    'Tabs'    => $args->{'Tabs'} || [],
    'Active'  => '0',
    'Brand'   => $args->{'Brand'} || '',
  };
  my $object = bless $self,$class;
  return $object;
}

sub setBrand {
  my ($self,$value) = (@_);
  $self->set('Brand',$value);
}

sub getBrand {
  my ($self) = (@_);
  $self->get('Brand');
}

sub append {
  my ($self,$object) = (@_);
  push(@{$self->get('Tabs')},$object);
}

sub prepend {
  my ($self,$object) = (@_);
  unshift(@{$self->get('Tabs')},$object);
}

sub activate {
  my ($self,$tabid) = (@_);
  my @Tabs = ();
  foreach my $tab (@{$self->get('Tabs')}) {
    $tab->activate() if ($tab->getID() eq $tabid);
    push(@Tabs,$tab);
  }
  $self->set('Tabs',[@Tabs]);
}

sub sort {
  my ($self) = (@_);
  my $Tabs = [ sort { $a->get('Order') <=> $b->get('Order') } @{$self->get('Tabs')} ];
  $self->set('Tabs',$Tabs);
}

sub getVisible {
  my ($self) = (@_);
  $self->sort();
  my $Tabs = [ grep { $_->isVisible() } @{$self->get('Tabs')} ];
  return $Tabs;
}

sub output {
  my ($self,$key) = (@_);
  my @Tabs = @{$self->getVisible()};
  if (scalar(@Tabs)) {
    my $ActiveTab = 0;
    foreach my $tab (@Tabs) {
      $ActiveTab = 1 if ($tab->isActive());
    }
    $Tabs[$self->{'Active'}]->activate() unless ($ActiveTab);
  }

  return div({-class => 'tab-content'},join("",map { $_->output('Pane') } @Tabs)) if ($key eq 'Pane');

  @Tabs = grep { $_->get('Order') } @Tabs;
  
  my $NavHeader  = $self->getBrand();
  $NavHeader     = &HTML::Button({-type => 'button',-class => 'navbar-toggle collapsed',-data_toggle =>'collapse',-data_target => '#navbar-collapse-1'},span({-class => 'icon-bar'},['','',''])) . $NavHeader if (scalar(@Tabs));
  my $Navigation = ul({-id => 'Nav',-class => 'nav navbar-nav'},join("",map { $_->output('Title') } @Tabs));
  my $NavBar = div({-class => 'navbar-header'},$NavHeader).div({-id => 'navbar-collapse-1',-class => 'collapse navbar-collapse'},$Navigation);
  return $NavBar if ($key eq 'Title');
}

1;

