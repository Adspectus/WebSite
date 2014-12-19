package Element;

use constant { TRUE => 1, FALSE => 0 };
use feature 'switch';
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:html :form);

sub new {
  my ($class,$args) = (@_);
  my $self = {
    'ID'          => $args->{'ID'},
    'Name'        => $args->{'Name'}        || lc($args->{'ID'}),
    'Type'        => $args->{'Type'}        || 'TextField',
    'Label'       => $args->{'Label'}       || ucfirst($args->{'Name'}),
    'Placeholder' => $args->{'Placeholder'} || $args->{'Label'} || ucfirst($args->{'Name'}) || $args->{'ID'},
    'Value'       => $args->{'Value'}       || '',
    'Values'      => $args->{'Values'}      || [],
    'Labels'      => $args->{'Labels'}      || {},
    'Size'        => $args->{'Size'}        || '1',
    'LabelClass'  => $args->{'LabelClass'}  || 'col-lg-1',
    'Class'       => $args->{'Class'}       || 'col-lg-4',
    'HelpClass'   => $args->{'HelpClass'}   || 'col-lg-7',
    'Checked'     => exists($args->{'Checked'}) ? $args->{'Checked'} : FALSE,
    'Disabled'    => exists($args->{'Disabled'}) ? $args->{'Disabled'} : FALSE,
  };
  my $object = bless $self,$class;
  return $object;
}

sub output {
  my ($self) = (@_);

  my $Element = '';
  given ($self->{'Type'}) {
    when ('Hidden') {
      $Element = input({-type => 'hidden',-id => $self->get('ID'),-name => $self->get('Name'),-class => 'form-control',-value => $self->get('Value')});
      return div({-id => $self->get('ID'),-class => 'form-group'},$Element);
    }
    when ('TextField') {
      $Element = input({-type => 'text',-id => $self->get('ID'),-name => $self->get('Name'),-class => 'form-control',-placeholder => $self->get('Placeholder'),-value => $self->get('Value')}) unless ($self->get('Disabled'));
      $Element = input({-type => 'text',-id => $self->get('ID'),-name => $self->get('Name'),-class => 'form-control',-placeholder => $self->get('Placeholder'),-value => $self->get('Value'),-disabled => TRUE}) if ($self->get('Disabled'));
    }
    when ('Password') {
      $Element = input({-type => 'password',-id => $self->get('ID'),-name => $self->get('Name'),-class => 'form-control',-placeholder => $self->get('Placeholder'),-value => $self->get('Value')}) unless ($self->get('Disabled'));
      $Element = input({-type => 'password',-id => $self->get('ID'),-name => $self->get('Name'),-class => 'form-control',-placeholder => $self->get('Placeholder'),-value => $self->get('Value'),-disabled => TRUE}) if ($self->get('Disabled'));
    }
    when ('EMail') {
      $Element = input({-type => 'email',-id => $self->get('ID'),-name => $self->get('Name'),-class => 'form-control',-placeholder => $self->get('Placeholder'),-value => $self->get('Value')}) unless ($self->get('Disabled'));
      $Element = input({-type => 'email',-id => $self->get('ID'),-name => $self->get('Name'),-class => 'form-control',-placeholder => $self->get('Placeholder'),-value => $self->get('Value'),-disabled => TRUE}) if ($self->get('Disabled'));
    }
    when ('FileField') {
      $Element = filefield(-id => $self->get('ID'),-name => $self->get('Name'),-class  => 'form-control') unless ($self->get('Disabled'));
      $Element = filefield(-id => $self->get('ID'),-name => $self->get('Name'),-class  => 'form-control',-disabled => TRUE) if ($self->get('Disabled'));
    }
    when ('ScrollingList') {
      $Element = scrolling_list(-id => $self->get('ID'),-name => $self->get('Name'),-class => 'form-control',-values => $self->get('Values'),-size => $self->get('Size'),-labels => $self->get('Labels')) unless ($self->get('Disabled'));
      $Element = scrolling_list(-id => $self->get('ID'),-name => $self->get('Name'),-class => 'form-control',-values => $self->get('Values'),-size => $self->get('Size'),-labels => $self->get('Labels'),-disabled => TRUE) if ($self->get('Disabled'));
    }
    when ('Checkbox') {
      if ($self->get('Checked')) {
        $Element = input({-type => 'checkbox',-id => $self->get('ID'),-name => $self->get('Name'),-checked => 'true'}) unless ($self->get('Disabled'));
        $Element = input({-type => 'checkbox',-id => $self->get('ID'),-name => $self->get('Name'),-checked => 'true',-disabled => 'true'}) if ($self->get('Disabled'));
      }
      else {
        $Element = input({-type => 'checkbox',-id => $self->get('ID'),-name => $self->get('Name')}) unless ($self->get('Disabled'));
        $Element = input({-type => 'checkbox',-id => $self->get('ID'),-name => $self->get('Name'),-disabled => 'true'}) if ($self->get('Disabled'));
      }
    }
    default {
      $Element = span({-class => 'alert alert-danger'},'The element '.code($self->get('Type')).' is not defined!');
    }
  }
  return div({-id => $self->get('ID'),-class => 'form-group'},
    label({-for => $self->get('ID'),-class => $self->get('LabelClass').' control-label'},$self->get('Label')) .
    div({-class => $self->get('Class')},$Element) .
#    div({-id => $self->get('ID').'_Help',-class => $self->get('HelpClass').' help-block'},span({-id => $self->get('ID'),-class => 'help-block'},''))
    div({-id => $self->get('ID').'_Help',-class => $self->get('HelpClass').' help-block',-name => $self->get('Name').'_Help'},'')
  );
}

1;

