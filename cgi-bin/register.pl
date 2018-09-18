#!/usr/bin/perl  -w
use cPanelUserConfig;

use CGI;
use CGI::Carp qw(fatalsToBrowser);
use JSON;
use DBI;


my $dsn = "DBI:mysql:registrants:localhost";
my $dbh = DBI->connect($dsn,'akohag','Redwings4030', {RaiseError => 1, PrintError => 1}) or die "$DBI::errstr";

my $q = CGI->new;

my $firstname = $q->param('firstName');
my $lastname = $q->param('lastName');
my $address1 = $q->param('address1');
my $address2 = $q->param('address2');
my $city = $q->param('city');
my $state = $q->param('state');
my $zip = $q->param('zip');
my $country = $q->param('country');

my $json;

if($firstname && $lastname && $address1 && $city && $state && $zip && $country eq 'US') {
    $json = {success => 'true'};
    my $sth = $dbh->prepare("INSERT INTO registrants (first_name, last_name, address1, address2, city, state, zip, country) VALUES (?,?,?,?,?,?,?,?)");
    $sth->execute($firstname, $lastname, $address1, $address2, $city, $state, $zip, $country);
    $sth->finish();
} else {
    $json = {success => 'false'};
}

$dbh->disconnect;

print $q->header(-type => "application/json");

print to_json($json);
