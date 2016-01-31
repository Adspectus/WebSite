package Element;

use constant { TRUE => 1, FALSE => 0 };
#use feature 'switch';
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
    'Value'       => exists($args->{'Value'}) ? $args->{'Value'} : '',
    'Values'      => $args->{'Values'}      || [],
    'Labels'      => $args->{'Labels'}      || {},
    'Size'        => $args->{'Size'}        || '1',
    'FieldClass'  => $args->{'FieldClass'} ? $args->{'FieldClass'}.' form-control' : 'form-control',
    'LabelClass'  => $args->{'LabelClass'}.' control-label'  || 'col-lg-1 control-label',
    'Class'       => $args->{'Class'}       || 'col-lg-4',
    'HelpClass'   => $args->{'HelpClass'}.' help-block'      || 'col-lg-7 help-block',
    'Default'     => $args->{'Default'}     || [],
    'Suffix'      => $args->{'Suffix'}      || '',
    'Praefix'     => $args->{'Praefix'}     || '',
    'LeftLabel'   => exists($args->{'LeftLabel'}) ? $args->{'LeftLabel'} : TRUE,
    'Checked'     => exists($args->{'Checked'}) ? $args->{'Checked'} : FALSE,
    'Disabled'    => exists($args->{'Disabled'}) ? $args->{'Disabled'} : FALSE,
    'ReadOnly'    => exists($args->{'ReadOnly'}) ? $args->{'ReadOnly'} : FALSE,
    'Help'        => exists($args->{'Help'}) ? $args->{'Help'} : TRUE,
  };
  my $object = bless $self,$class;
  $self->set('LabelClass',$self->get('LabelClass').($self->get('LeftLabel') ? '' : '-left'));
  return $object;
}

sub Element {
  my ($self) = (@_);

  my $Element = '';
  for ($self->{'Type'}) {
    if (/Hidden/) {
      $Element = input({-type => 'hidden',-id => $self->get('ID'),-name => $self->get('Name'),-class => $self->get('FieldClass'),-value => $self->get('Value')});
      $self->{'Help'} = FALSE;
    }
    elsif (/TextField/) {
      $Element = input({-type => 'text',-id => $self->get('ID'),-name => $self->get('Name'),-class => $self->get('FieldClass'),-placeholder => $self->get('Placeholder'),-value => $self->get('Value')}) unless ($self->get('Disabled') || $self->get('ReadOnly'));
      $Element = input({-type => 'text',-id => $self->get('ID'),-name => $self->get('Name'),-class => $self->get('FieldClass'),-placeholder => $self->get('Placeholder'),-value => $self->get('Value'),-disabled => TRUE}) if ($self->get('Disabled'));
      $Element = input({-type => 'text',-id => $self->get('ID'),-name => $self->get('Name'),-class => $self->get('FieldClass'),-placeholder => $self->get('Placeholder'),-value => $self->get('Value'),-readonly => 'readonly'}) if ($self->get('ReadOnly'));
    }
    elsif (/Password/) {
      $Element = input({-type => 'password',-id => $self->get('ID'),-name => $self->get('Name'),-class => $self->get('FieldClass'),-placeholder => $self->get('Placeholder'),-value => $self->get('Value')}) unless ($self->get('Disabled'));
      $Element = input({-type => 'password',-id => $self->get('ID'),-name => $self->get('Name'),-class => $self->get('FieldClass'),-placeholder => $self->get('Placeholder'),-value => $self->get('Value'),-disabled => TRUE}) if ($self->get('Disabled'));
    }
    elsif (/EMail/) {
      $Element = input({-type => 'email',-id => $self->get('ID'),-name => $self->get('Name'),-class => $self->get('FieldClass'),-placeholder => $self->get('Placeholder'),-value => $self->get('Value')}) unless ($self->get('Disabled'));
      $Element = input({-type => 'email',-id => $self->get('ID'),-name => $self->get('Name'),-class => $self->get('FieldClass'),-placeholder => $self->get('Placeholder'),-value => $self->get('Value'),-disabled => TRUE}) if ($self->get('Disabled'));
    }
    elsif (/FileField/) {
      $Element = filefield(-id => $self->get('ID'),-name => $self->get('Name'),-class  => $self->get('FieldClass')) unless ($self->get('Disabled'));
      $Element = filefield(-id => $self->get('ID'),-name => $self->get('Name'),-class  => $self->get('FieldClass'),-disabled => TRUE) if ($self->get('Disabled'));
    }
    elsif (/ScrollingList/) {
      $Element = scrolling_list(-id => $self->get('ID'),-name => $self->get('Name'),-class => $self->get('FieldClass'),-values => $self->get('Values'),-size => $self->get('Size'),-labels => $self->get('Labels'),-default => $self->get('Default')) unless ($self->get('Disabled'));
      $Element = scrolling_list(-id => $self->get('ID'),-name => $self->get('Name'),-class => $self->get('FieldClass'),-values => $self->get('Values'),-size => $self->get('Size'),-labels => $self->get('Labels'),-default => $self->get('Default'),-disabled => TRUE) if ($self->get('Disabled'));
    }
    elsif (/Checkbox/) {
      if ($self->get('Checked')) {
        $Element = input({-type => 'checkbox',-id => $self->get('ID'),-name => $self->get('Name'),-checked => 'true'}) unless ($self->get('Disabled'));
        $Element = input({-type => 'checkbox',-id => $self->get('ID'),-name => $self->get('Name'),-checked => 'true',-disabled => 'true'}) if ($self->get('Disabled'));
      }
      else {
        $Element = input({-type => 'checkbox',-id => $self->get('ID'),-name => $self->get('Name')}) unless ($self->get('Disabled'));
        $Element = input({-type => 'checkbox',-id => $self->get('ID'),-name => $self->get('Name'),-disabled => 'true'}) if ($self->get('Disabled'));
      }
    }
    else {
      $Element = span({-class => 'alert alert-danger'},'The element '.code($self->get('Type')).' is not defined!');
    }
  }
  $Element  = span({-class => 'input-group-addon'},$self->get('Praefix')).$Element if ($self->get('Praefix'));
  $Element .= span({-class => 'input-group-addon'},$self->get('Suffix')) if ($self->get('Suffix'));
  return div({-class => 'input-group'},$Element) if ($self->get('Praefix') or $self->get('Suffix'));
  return $Element;
}

sub output {
  my ($self) = (@_);
  my $Element = div({-class => $self->get('Class')},$self->Element());
  my $Label   = $self->{'Type'} =~ m/Hidden/ ? '' : label({-for => $self->get('ID'),-class => $self->get('LabelClass')},$self->get('Label'));
  my $Help    = $self->get('Help') ? div({-id => $self->get('ID').'_Help',-class => $self->get('HelpClass'),-name => $self->get('Name').'_Help'},'') : '';

  return div({-id => $self->get('ID'),-class => 'form-group'}, $Label . $Element . $Help ) if ($self->get('LeftLabel'));
  return div({-id => $self->get('ID'),-class => 'form-group'}, $Element . $Label . $Help ) unless ($self->get('LeftLabel'));
}

sub raw {
  my ($self) = (@_);
  my $Element = div({-class => $self->get('Class')},$self->Element());
  my $Label   = label({-for => $self->get('ID'),-class => $self->get('LabelClass')},$self->get('Label'));

  return $Label . $Element;
}

1;

