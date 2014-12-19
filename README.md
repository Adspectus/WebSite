WebSite
=======

A framework extension for Perl CGI

## Overview

WebSite is a collection of Perl Modules which provide object oriented extensions to Perl CGI. These extensions are more or less simple interfaces to HTML snippets required when using a framework such as bootstrap.

## Example

If you would like to use a bootstrap "panel" in your HTML code, you would use this HTML code:

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

Instead of this, you could write:

```perl
print Panel->new({
  ID      => 'Test',
  Head    => 'My Panel Title',
  Content => 'My Content',
  Footer  => 'My Footer',
  Solo    => 1,
});
```

## Work in progress

I started working on this project while programming two websites with similar requirements - Perl/CGI and MySQL at the server side together with bootstrap and jQuery at the frontend side. Hence, the only framework extension provided so far is bootstrap. Functionality is very limited and documentation is not present. I hope it will be evolved further in the next time.
