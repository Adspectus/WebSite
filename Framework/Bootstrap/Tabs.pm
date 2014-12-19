package Tabs;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:standard -any Button);

sub new {
  my ($class,$args) = (@_);
  my $self = {
    'Tabs'    => $args || [],
    'Active'  => '0',
  };
  my $object = bless $self,$class;
  return $object;
}

sub append {
  my ($self,$object) = (@_);
  push(@{$self->get('Tabs')},$object);
}

sub prepend {
  my ($self,$object) = (@_);
  unshift(@{$self->get('Tabs')},$object);
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
  $Tabs[$self->{'Active'}]->activate();
  my $Navigation = ul({-id => 'Nav',-class => 'nav nav-tabs'},join("",map { $_->output('Title') } @Tabs));
  my $Content    = div({-class => 'tab-content'},join("",map { $_->output('Pane') } @Tabs));
  return $Navigation if ($key eq 'Title');
  return $Content if ($key eq 'Pane');
  return $Navigation . $Content;
}

1;

