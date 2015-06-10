package HTML;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);


sub Button { #
  my ($Attributes,$Value) = (@_);
  my $ClosingTag = ' />';

  $ClosingTag = '>' . $Value . '</button>' if $Value;

  return '<button' . &__getAttributes($Attributes) . $ClosingTag;
}

sub large {
  my ($Attributes,$Value) = (@_);
  my $ClosingTag = ' />';

  $ClosingTag = '>' . $Value . '</large>' if $Value;

  return '<large' . &__getAttributes($Attributes) . $ClosingTag;
}

sub __getAttributes {
  my $Attributes = shift;
  my @Attributes = ();

  foreach my $key (keys(%{$Attributes})) {
    (my $Attribute = $key) =~ s/^\-//;
    $Attribute =~ s/\_/\-/g;
    my $value = $Attributes->{$key} || '';
    push(@Attributes,$Attribute . '=' . '"' . $value . '"');
  }

  return ' ' . join(' ',@Attributes);
}

1;

