package Panel;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:standard -any Button);

sub new {
  my ($class,$args) = (@_);
  my $self = {
    'ID'               => $args->{'ID'},
    'ContentClass'     => $args->{'ContentClass'}  || 'panel-body',
    'PanelClass'       => $args->{'PanelClass'}  || 'panel-default',
    'HeaderClass'      => $args->{'HeaderClass'}  || 'text-left',
    'HeaderTextClass'  => $args->{'HeaderTextClass'} || 'h4',
    'Head'             => $args->{'Head'}     || '',
    'SubHead'          => $args->{'SubHead'}     || '',
    'Content'          => $args->{'Content'}  || '',
    'Footer'           => $args->{'Footer'} || '',
    'FooterClass'      => $args->{'FooterClass'} || 'text-left',
    'Solo'             => exists($args->{'Solo'}) ? $args->{'Solo'} : FALSE,
  };
  my $object = bless $self,$class;
  return $object;
}

sub getID {
  my ($self) = (@_);
  return $self->get('ID');
}

sub isSolo {
  my ($self) = (@_);
  return $self->get('Solo');
}

sub setHeaderClass {
  my ($self,$value) = (@_);
  $self->set('HeaderClass',$value);
}

sub getHeaderClass {
  my ($self) = (@_);
  return $self->get('HeaderClass');
}

sub setContentClass {
  my ($self,$value) = (@_);
  $self->set('ContentClass',$value);
}

sub getContentClass {
  my ($self) = (@_);
  return $self->get('ContentClass');
}

sub setPanelClass {
  my ($self,$value) = (@_);
  $self->set('PanelClass',$value);
}

sub getPanelClass {
  my ($self) = (@_);
  return $self->get('PanelClass');
}

sub setHead {
  my ($self,$value) = (@_);
  $self->set('Head',$value);
}

sub getHead {
  my ($self) = (@_);
  return $self->get('Head');
}

sub setSubHead {
  my ($self,$value) = (@_);
  $self->set('SubHead',$value);
}

sub getSubHead {
  my ($self) = (@_);
  return $self->get('SubHead');
}

sub setContent {
  my ($self,$value) = (@_);
  $self->set('Content',$value);
}

sub getContent {
  my ($self) = (@_);
  return $self->get('Content');
}

sub appendHead {
  my ($self,$value) = (@_);
  $self->set('Head',$self->get('Head') . $value);
}

sub prependHead {
  my ($self,$value) = (@_);
  $self->set('Head',$value . $self->get('Head'));
}

sub appendContent {
  my ($self,$value) = (@_);
  $self->set('Content',$self->get('Content') . $value);
}

sub prependContent {
  my ($self,$value) = (@_);
  $self->set('Content',$value . $self->get('Content'));
}

sub output {
  my ($self) = (@_);
  my $PanelHead    = $self->getHead();
  my $PanelSubHead = $self->getSubHead();
  my $PanelContent = div({-class => $self->getContentClass()},$self->getContent());
  $PanelContent   .= div({-class => 'panel-footer '.$self->get('FooterClass')},$self->get('Footer')) if ($self->get('Footer'));

  unless ($self->isSolo()) {
    $PanelHead = a({-data_toggle => 'collapse',-data_parent => '#accordion',-href => '#'.$self->getID()},$PanelHead);
    $PanelContent = div({-id => $self->getID(),-class => 'panel-collapse collapse'},$PanelContent);
  }
  
#  $PanelHead = div({-class => 'panel-heading '.$self->getHeaderClass()},div({-class => $self->{'HeaderTextClass'}.' panel-title pull-left'},$PanelHead).div({-class => $self->{'HeaderTextClass'}.' panel-title pull-right'},$PanelSubHead));
  $PanelHead = div({-class => 'panel-heading'},span({-class => $self->{'HeaderTextClass'}.' panel-title'},$PanelHead).span({-class => $self->{'HeaderTextClass'}.' panel-title pull-right'},$PanelSubHead));
  
  return div({-id => 'Panel_'.$self->getID(),-class => 'panel '.$self->getPanelClass()},$PanelHead . $PanelContent);
}

1;

