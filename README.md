WebSite
=======

A framework extension for Perl CGI

## Overview

WebSite is a collection of Perl Modules to provide object oriented extensions to Perl CGI when using a framework such as bootstrap. It is extensible to more features of the framework as well to other frameworks.

## Example

If you would like to use a bootstrap "panel" in your HTML, you would use this HTML code:

```html
<div id="Panel_Test" class="panel panel-default">
  <div class="panel-heading">
    <span class="h4 panel-title">My Panel Title<span>
  </div>
  <div class="panel-body">
    My Content
  </div>
  <div class="panel-footer text-left">
    My Footer
  </div>
</div>
```

Instead of this, with the WebSite framework extension you could write:

```perl
print Panel->new({
  ID      => 'Test',
  Head    => 'My Panel Title',
  Content => 'My Content',
  Footer  => 'My Footer',
  Solo    => 1,
});
```
or, put the HTML content into a variable for later use or manipulation:

```perl
my $Panel = Panel->new({ OPTIONS });
$Panel->setContent('My Content');
```

## Supported Frameworks

So far, only bootstrap is supported and not all elements are implemented yet. The idea is to support more frameworks with the same interfaces which would make it easy to change them without major modifications of your code.

For example, to define a navigation panel entry with bootstrap you could write:

```perl
use WebSite::Framework::Bootstrap;

my $Start = NavBar->new({'ID' => 'start','Order' => 0,'Title' => 'Startseite'});
$Start->setPane($CGI->div({-class => 'row'},$CGI->div({-class => 'col-xs-12'},$CGI->h2({-class => 'text-center'},'Some Text') . $DateString)));
```
and it should be possible to switch the framework only with the use statement.

