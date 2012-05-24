# DESCRIPTION:

Installs passenger gem via RVM and configures Apache or Nginx.


# REQUIREMENTS:

The following platforms are supported by this cookbook, meaning that the recipes run on these platforms without error:

* Ubuntu


# RECIPES

## default

Installs dependencies and contains helpers for other recipes.

## apache2

Installs passenger as an apache2 module. Requires the `apache2` recipe.

## nginx

Installs passenger as an nginx module. Requires the `nginx::source` recipe.


# ATTRIBUTES:

## version

The version of passenger to deploy. This will be in a format used by the gem command. 

Default is `3.0.7`.

## rvm_ruby

The RVM ruby (and optional gemset) under which to install the passenger gem. This will be in a format used by the rvm command.

Default is `ree-1.8.7-2011.03@passenger`.

## root_path

Optionally override the full path to the root of the installed passenger gem.

## module_path

Optionallly override the full path to the Apache2 module.


# LICENSE and AUTHOR

Author:: Fletcher Nichol (<fnichol@nichol.ca>)

Contributors:: Phil Cohen (http://phlippers.net/)

Copyright:: 2010, 2011, Fletcher Nichol

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
