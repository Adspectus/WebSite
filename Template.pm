package WebSite::Template;

use constant { TRUE => 1, FALSE => 0 };
use strict;
use warnings;
use Carp;
use Data::Dumper;
use File::Basename;
use HTML::Template;

$Data::Dumper::Indent = 1;
$Data::Dumper::Purity = 1;


#******************************************************************************
# Settings
#******************************************************************************

use constant TEMPLATEFILE  => 'bootstrap-standard.template';
use constant TEMPLATEDIR   => dirname(__FILE__).'/Templates';
use constant CACHE         => FALSE;


#******************************************************************************
# Constructor
#******************************************************************************

sub new {
  my ($class,$args) = (@_);
  my $self = {
    'Template'    => HTML::Template->new(
      filename        => $args->{'TemplateFile'} || TEMPLATEFILE,
      path            => $args->{'TemplatePath'} || TEMPLATEDIR,
      cache           => exists($args->{'Cache'}) ? $args->{'Cache'} : CACHE,
      case_sensitive  => TRUE,
    ),
  };
  my $object = bless $self,$class;
  return $object;
}

sub set {
  my ($self,$key,$value) = (@_);
  $self->{$key} = $value;
}

sub get {
  my ($self,$key) = (@_);
  return $self->{$key};
}


#******************************************************************************
# Public methods
#******************************************************************************


sub setVar {
  my ($self,$var,$content) = (@_);
  return unless($self->{'Template'}->query(name => $var));
  $self->{'Template'}->param($var => $content);
}

sub getVar {
  my ($self,$var) = (@_);
  return unless($self->{'Template'}->query(name => $var));
  return $self->{'Template'}->param($var) || '';
}

sub appendVar {
  my ($self,$var,$content) = (@_);
  return unless($self->{'Template'}->query(name => $var));
  $self->setVar($var,$self->getVar($var) . $content);
}

sub prependVar {
  my ($self,$var,$content) = (@_);
  return unless($self->{'Template'}->query(name => $var));
  $self->setVar($var,$content . $self->getVar($var));
}

sub print {
  my $self = shift;
  return $self->{'Template'}->output;
}

sub dump {
  my ($self) = (@_);
  return Data::Dumper->Dump([$self],[ref($self)]);
}


#******************************************************************************
# Private methods
#******************************************************************************


1;


