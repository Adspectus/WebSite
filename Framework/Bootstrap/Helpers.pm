package Helpers;

use constant { TRUE => 1, FALSE => 0 };
use parent qw(WebSite::Framework::Bootstrap);
use CGI qw(:standard -any Button);

sub HeaderText {
  my $Text = shift;
  return span({-class => 'h5 visible-xs-inline'},$Text).span({-class => 'h3 visible-sm-inline'},$Text).span({-class => 'h3 visible-md-inline'},$Text).span({-class => 'h2 visible-lg-inline'},$Text);
}

1;

