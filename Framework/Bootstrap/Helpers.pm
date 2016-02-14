package Helpers;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:standard);

sub HeaderText {
  my $Text = shift;
  return span({-class => 'h5 visible-xs-inline'},$Text).span({-class => 'h3 visible-sm-inline'},$Text).span({-class => 'h3 visible-md-inline'},$Text).span({-class => 'h2 visible-lg-inline'},$Text);
}

sub Icon {
  my $Type = shift;
  my $Color = shift;
  my $Tooltip = shift;
  return span({-class => 'glyphicon glyphicon-'.$Type,-data_toggle => 'tooltip',-title => $Tooltip,-style => 'color:'.$Color.';'},'') if ($Color);
  return span({-class => 'glyphicon glyphicon-'.$Type,-data_toggle => 'tooltip',-title => $Tooltip},'');
}

1;
