package Modal;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:standard);

sub new {
  my ($class,$args) = (@_);
  my $self = {
    'ID'             =>  $args->{'ID'},
    'Size'           =>  $args->{'Size'}          || 'medium',
    'ContentClass'   =>  $args->{'ContentClass'}  || 'modal-content',
    'Fade'           =>  exists($args->{'Fade'}) ? $args->{'Fade'} : FALSE,
    'Header'         =>  $args->{'Header'}        || '',
    'Body'           =>  $args->{'Body'}          || '',
    'Footer'         =>  $args->{'Footer'}        || '',
  };
  my $object = bless $self,$class;
  return $object;
}

sub getID {
  my ($self) = (@_);
  return $self->get('ID');
}

sub setContentClass {
  my ($self,$value) = (@_);
  $self->set('ContentClass',$value);
}

sub getContentClass {
  my ($self) = (@_);
  return $self->get('ContentClass');
}

sub setSize {
  my ($self,$value) = (@_);
  $self->set('Size',$value);
}

sub getSize {
  my ($self) = (@_);
  return 'modal-sm' if ($self->get('Size') eq 'small');
  return '' if ($self->get('Size') eq 'medium');
  return 'modal-lg' if ($self->get('Size') eq 'large');
}

sub isFade {
  my ($self) = (@_);
  return $self->get('Fade');
}

sub setHeader {
  my ($self,$value) = (@_);
  $self->set('Header',$value);
}

sub getHeader {
  my ($self) = (@_);
  return $self->get('Header');
}

sub setBody {
  my ($self,$value) = (@_);
  $self->set('Body',$value);
}

sub getBody {
  my ($self) = (@_);
  return $self->get('Body');
}

sub setFooter {
  my ($self,$value) = (@_);
  $self->set('Footer',$value);
}

sub getFooter {
  my ($self) = (@_);
  return $self->get('Footer');
}

sub appendHeader {
  my ($self,$value) = (@_);
  $self->set('Header',$self->get('Header') . $value);
}

sub prependHeader {
  my ($self,$value) = (@_);
  $self->set('Header',$value . $self->get('Header'));
}

sub appendBody {
  my ($self,$value) = (@_);
  $self->set('Body',$self->get('Body') . $value);
}

sub prependBody {
  my ($self,$value) = (@_);
  $self->set('Body',$value . $self->get('Body'));
}

sub appendFooter {
  my ($self,$value) = (@_);
  $self->set('Footer',$self->get('Footer') . $value);
}

sub prependFooter {
  my ($self,$value) = (@_);
  $self->set('Footer',$value . $self->get('Footer'));
}

sub output {
  my ($self) = (@_);
  my $Header = div({-class => 'modal-header'},&HTML::Button({-type => 'button',-class => 'close',-data_dismiss => 'modal'},span({-aria_hidden => 'true'},'&times;')),h4({-id => $self->getID().'Label',-class => 'modal-title'},$self->getHeader()));
  my $Body = div({-id => $self->getID().'Message',-class => 'modal-body'},$self->getBody());
  my $Footer = $self->getFooter() ? div({-class => 'modal-footer'},&HTML::Button({-type => 'button',-class => 'btn btn-success',-data_dismiss => 'modal'},$self->getFooter())) : '';
  return div({-id => $self->getID(),-class => 'modal'.($self->isFade() ? ' fade' : ''),-tabindex => '-1',-aria_labelledby => $self->getID().'Label',-aria_hidden => 'true'},div({-class => 'modal-dialog '.$self->getSize()},div({-class => $self->getContentClass()},$Header . $Body . $Footer)));
}

1;

