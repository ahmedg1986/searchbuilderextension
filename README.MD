# CiviCRM Search Builder extenstion. 

Extend CiviCRM search builder to support location based searches.    

### Built With

* [Drupal](https://www.drupal.org/) - Drupal 7.54
* [CiviCRM](https://civicrm.org/download/) - CiviCRM 4.7.19
* [Civix](https://github.com/totten/civix) - CiviCRM extension builder


### Assumtions

* Assuming that you have drupal 7 and civiCRM 4.7 installed in your system.


### Installation

* Create an extension folder 'civicrm_extensions' in /sites/all/ directory for custom extensions.
* Add custom extension path in CiviCRM Administer Settings(Administer->System Settings->Directories->Extensions Directory)
* Clone our civicrm.search.builderextension directoy.
* Enable the extension from Administer->System Settings-> Extensions.


### Solution Approach

* Generate an extenstion skeleton using civix:
	```
	civix generate:module civicrm.search.builderextension --license=AGPL-3.0
	```
* Overriden below files in my extenstion.
	- /templates/CRM/Contact/Form/Search/table.tpl
		- Added two fields for postal code range and appropriate jquery for it.
	- /CRM/Core/SelectValues.php
		- Added Range operator 
	- /CRM/Core/BAO/Mapping.php
		- Combined two values when range opertor choosen.
	- /CRM/Contact/BAO/Query.php
		- Added function PostalCodeRange() to create new query when range operator choosen.


### Steps to Use this extenstion

	- Go to Search -> Search Builder
	- Select record type as a Contacts
	- Select Field as a Postal Code
	- Select Operator as Range
	- Add Range From and To in available text boxes
	- You can add more search By clicking Another Search Field
	- Hit Search button to view output









